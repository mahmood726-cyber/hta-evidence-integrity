#' Sequential Influence Trimming
#'
#' Iteratively downweights influential studies (Cook's distance above
#' `influence_threshold`) by a factor `trim_factor`, refitting the
#' random-effects model until convergence or `max_iterations` is reached.
#' Unlike trim-and-fill, no studies are removed — weights only shrink — and the
#' procedure converges when influence drops below threshold or the pooled
#' estimate stops moving.
#'
#' @param yi Numeric vector of effect sizes.
#' @param vi Numeric vector of sampling variances.
#' @param influence_threshold Cook's distance above which a study is treated as
#'   influential. Default `0.5`.
#' @param max_iterations Maximum number of trimming passes. Default `5`.
#' @param trim_factor Multiplicative weight reduction applied to influential
#'   studies on each pass. Default `0.5`.
#'
#' @return A list with the trimmed estimate, SE, CI, p-value, between-study
#'   variance, number of iterations used, convergence flag, count of trimmed
#'   studies, final per-study weights, and the estimate trajectory.
#'
#' @examples
#' \dontrun{
#'   dat <- metafor::escalc(measure = "RR", ai = tpos, bi = tneg,
#'                          ci = cpos, di = cneg, data = metafor::dat.bcg)
#'   sequential_influence_trimming(dat$yi, dat$vi)
#' }
#'
#' @importFrom metafor rma
#' @importFrom stats qnorm influence
#' @export
sequential_influence_trimming <- function(yi, vi, influence_threshold = 0.5,
                                          max_iterations = 5,
                                          trim_factor = 0.5) {

  k <- length(yi)

  if (k < 4) {
    return(list(
      estimate = mean(yi),
      se = sqrt(mean(vi)),
      method = "SIT",
      message = "Insufficient studies for influence analysis"
    ))
  }

  weights <- rep(1, k)
  iteration <- 0
  converged <- FALSE
  influence_history <- list()
  estimate_history <- numeric()

  fit_orig <- metafor::rma(yi = yi, vi = vi, method = "REML")
  estimate_orig <- fit_orig$beta[1]

  while (!converged && iteration < max_iterations) {
    iteration <- iteration + 1

    fit <- tryCatch({
      metafor::rma(yi = yi, vi = vi, weights = weights, method = "REML")
    }, error = function(e) metafor::rma(yi = yi, vi = vi, method = "REML"))

    estimate_current <- fit$beta[1]
    estimate_history <- c(estimate_history, estimate_current)

    inf <- stats::influence(fit)
    cooks_d <- inf$inf$cook.d
    cooks_d[is.na(cooks_d)] <- 0
    influence_history[[iteration]] <- cooks_d

    influential <- which(cooks_d > influence_threshold)

    if (length(influential) == 0) {
      converged <- TRUE
    } else {
      weights[influential] <- weights[influential] * trim_factor
      weights <- pmax(weights, 0.01)
    }

    if (iteration > 1) {
      change <- abs(estimate_current - estimate_history[iteration - 1])
      if (change < 0.001) converged <- TRUE
    }
  }

  fit_final <- tryCatch({
    metafor::rma(yi = yi, vi = vi, weights = weights, method = "REML")
  }, error = function(e) metafor::rma(yi = yi, vi = vi, method = "REML"))

  estimate_sit <- fit_final$beta[1]
  se_sit <- fit_final$se
  tau2 <- fit_final$tau2

  z <- stats::qnorm(0.975)
  ci_lb <- estimate_sit - z * se_sit
  ci_ub <- estimate_sit + z * se_sit
  pval <- fit_final$pval
  n_trimmed <- sum(weights < 0.9)

  list(
    method = "SIT (Sequential Influence Trimming)",
    estimate = round(estimate_sit, 4),
    se = round(se_sit, 4),
    ci_lb = round(ci_lb, 4),
    ci_ub = round(ci_ub, 4),
    pval = round(pval, 4),
    tau2 = round(tau2, 4),
    k = k,
    iterations = iteration,
    converged = converged,
    n_trimmed = n_trimmed,
    final_weights = round(weights, 3),
    estimate_original = round(estimate_orig, 4),
    adjustment = round(estimate_sit - estimate_orig, 4),
    estimate_history = round(estimate_history, 4)
  )
}
