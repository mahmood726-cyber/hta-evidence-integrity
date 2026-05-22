#' MAFI-Weighted Meta-Analysis
#'
#' Pools effect sizes using a convex combination of inverse-variance weights and
#' stability (leave-one-out) weights, so studies whose removal would change the
#' sign or significance of the pooled estimate are downweighted relative to
#' studies that contribute only precision.
#'
#' @param yi Numeric vector of effect sizes.
#' @param vi Numeric vector of sampling variances (same length as `yi`).
#' @param method Heterogeneity estimator passed to [metafor::rma()]
#'   (e.g. `"REML"`, `"DL"`, `"PM"`). Default `"REML"`.
#' @param alpha Two-sided significance level used for the confidence interval
#'   and stability flags. Default `0.05`.
#' @param stability_weight Mixing weight in `[0, 1]` placed on stability
#'   weights vs. precision weights. Default `0.5`.
#'
#' @return A list with the pooled estimate, standard error, confidence interval,
#'   p-value, between-study variance, per-study stability scores, and the
#'   adjustment relative to the base REML estimate.
#'
#' @examples
#' set.seed(1)
#' k  <- 10
#' yi <- 0.3 + rnorm(k, sd = 0.15) + rnorm(k, sd = 0.20)
#' vi <- runif(k, 0.02, 0.20)
#' mafi_weighted_ma(yi, vi)
#'
#' @importFrom metafor rma leave1out
#' @importFrom stats qnorm pnorm
#' @export
mafi_weighted_ma <- function(yi, vi, method = "REML", alpha = 0.05,
                             stability_weight = 0.5) {

  k <- length(yi)

  if (k < 3) {
    return(list(
      estimate = mean(yi),
      se = sqrt(mean(vi)),
      ci_lb = NA, ci_ub = NA,
      method = "MWM",
      message = "Insufficient studies (k < 3)"
    ))
  }

  fit <- metafor::rma(yi = yi, vi = vi, method = method)
  estimate_base <- fit$beta[1]
  tau2 <- fit$tau2

  loo <- metafor::leave1out(fit)
  stability_scores <- numeric(k)

  for (i in seq_len(k)) {
    dir_change <- (loo$estimate[i] > 0) != (estimate_base > 0)
    orig_sig <- fit$pval < alpha
    loo_sig <- loo$pval[i] < alpha
    sig_change <- orig_sig != loo_sig

    if (abs(estimate_base) > 0.001) {
      mag_change <- abs(loo$estimate[i] - estimate_base) / abs(estimate_base)
    } else {
      mag_change <- abs(loo$estimate[i] - estimate_base)
    }

    stability_scores[i] <- 1 - (
      0.4 * as.numeric(dir_change) +
      0.3 * as.numeric(sig_change) +
      0.3 * min(mag_change, 1)
    )
  }

  precision_weights <- 1 / (vi + tau2)
  precision_weights <- precision_weights / sum(precision_weights)

  stability_weights <- (stability_scores - min(stability_scores) + 0.1)
  stability_weights <- stability_weights / sum(stability_weights)

  combined_weights <- (1 - stability_weight) * precision_weights +
                       stability_weight * stability_weights
  combined_weights <- combined_weights / sum(combined_weights)

  estimate_mwm <- sum(combined_weights * yi)
  var_mwm <- sum(combined_weights^2 * (vi + tau2))
  se_mwm <- sqrt(var_mwm)

  z <- stats::qnorm(1 - alpha / 2)
  ci_lb <- estimate_mwm - z * se_mwm
  ci_ub <- estimate_mwm + z * se_mwm
  z_stat <- estimate_mwm / se_mwm
  pval <- 2 * stats::pnorm(-abs(z_stat))

  list(
    method = "MWM (MAFI-Weighted)",
    estimate = round(estimate_mwm, 4),
    se = round(se_mwm, 4),
    ci_lb = round(ci_lb, 4),
    ci_ub = round(ci_ub, 4),
    pval = round(pval, 4),
    tau2 = round(tau2, 4),
    k = k,
    stability_weight = stability_weight,
    study_stability_scores = round(stability_scores, 3),
    combined_weights = round(combined_weights, 4),
    estimate_base = round(estimate_base, 4),
    adjustment = round(estimate_mwm - estimate_base, 4)
  )
}
