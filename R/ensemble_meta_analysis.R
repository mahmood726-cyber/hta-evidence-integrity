#' Ensemble Meta-Analysis
#'
#' Combines REML, MWM, ARP, SIT, UBSF, and (optionally) RVE and RoBMA into a
#' weighted ensemble. Reports a within-method variance, a between-method
#' variance (model uncertainty), and an agreement statistic that summarises how
#' tightly the contributing methods agree.
#'
#' @param yi Numeric vector of effect sizes.
#' @param vi Numeric vector of sampling variances.
#' @param include_robma If `TRUE`, include the `RoBMA::RoBMA()` Bayesian model
#'   in the ensemble (slow; requires the `RoBMA` package). Default `FALSE`.
#' @param include_rve If `TRUE` and `clubSandwich` is installed, include
#'   robust-variance (CR2) sandwich estimation. Default `TRUE`.
#'
#' @return A list with the ensemble estimate, SE, CI, p-value, contributing
#'   method estimates and weights, and within/between variance components.
#'
#' @examples
#' set.seed(1)
#' k  <- 10
#' yi <- 0.3 + rnorm(k, sd = 0.15) + rnorm(k, sd = 0.20)
#' vi <- runif(k, 0.02, 0.20)
#' ensemble_meta_analysis(yi, vi, include_rve = FALSE)
#'
#' @importFrom metafor rma
#' @importFrom stats qnorm pnorm sd
#' @export
ensemble_meta_analysis <- function(yi, vi, include_robma = FALSE,
                                   include_rve = TRUE) {

  k <- length(yi)
  sei <- sqrt(vi)
  methods_results <- list()

  tryCatch({
    fit_reml <- metafor::rma(yi = yi, vi = vi, method = "REML")
    methods_results$REML <- list(estimate = fit_reml$beta[1],
                                 se = fit_reml$se, weight = 0.15)
  }, error = function(e) NULL)

  tryCatch({
    mwm <- mafi_weighted_ma(yi, vi)
    methods_results$MWM <- list(estimate = mwm$estimate, se = mwm$se,
                                weight = 0.20)
  }, error = function(e) NULL)

  tryCatch({
    arp <- adaptive_robust_pooling(yi, vi)
    methods_results$ARP <- list(estimate = arp$estimate, se = arp$se,
                                weight = 0.20)
  }, error = function(e) NULL)

  tryCatch({
    sit <- sequential_influence_trimming(yi, vi)
    methods_results$SIT <- list(estimate = sit$estimate, se = sit$se,
                                weight = 0.15)
  }, error = function(e) NULL)

  tryCatch({
    ubsf <- unified_bias_stability(yi, vi)
    methods_results$UBSF <- list(estimate = ubsf$estimate, se = ubsf$se,
                                 weight = 0.20)
  }, error = function(e) NULL)

  if (include_rve && requireNamespace("clubSandwich", quietly = TRUE) &&
      k >= 3) {
    tryCatch({
      fit_rve <- metafor::rma(yi = yi, vi = vi, method = "REML")
      vcov_rve <- clubSandwich::vcovCR(fit_rve, type = "CR2")
      se_rve <- sqrt(diag(vcov_rve))
      methods_results$RVE <- list(estimate = fit_rve$beta[1],
                                  se = se_rve, weight = 0.10)
    }, error = function(e) NULL)
  }

  if (include_robma && requireNamespace("RoBMA", quietly = TRUE) && k >= 4) {
    tryCatch({
      robma_fit <- RoBMA::RoBMA(d = yi, se = sei, parallel = FALSE,
                                seed = 123, chains = 2, iter = 2000)
      robma_summary <- summary(robma_fit)
      methods_results$RoBMA <- list(estimate = robma_summary$estimates$Mean[1],
                                    se = robma_summary$estimates$SD[1],
                                    weight = 0.10)
    }, error = function(e) NULL)
  }

  if (length(methods_results) == 0) {
    return(list(method = "EMA", estimate = NA, se = NA,
                message = "All methods failed"))
  }

  total_weight <- sum(sapply(methods_results, function(x) x$weight))
  for (m in names(methods_results)) {
    methods_results[[m]]$weight <- methods_results[[m]]$weight / total_weight
  }

  estimates <- sapply(methods_results, function(x) x$estimate)
  weights <- sapply(methods_results, function(x) x$weight)
  ses <- sapply(methods_results, function(x) x$se)

  estimate_ema <- sum(weights * estimates)
  var_within <- sum(weights * ses^2)
  var_between <- sum(weights * (estimates - estimate_ema)^2)
  se_ema <- sqrt(var_within + var_between)

  z <- stats::qnorm(0.975)
  ci_lb <- estimate_ema - z * se_ema
  ci_ub <- estimate_ema + z * se_ema
  z_stat <- estimate_ema / se_ema
  pval <- 2 * stats::pnorm(-abs(z_stat))

  list(
    method = "EMA (Ensemble Meta-Analysis)",
    estimate = round(estimate_ema, 4),
    se = round(se_ema, 4),
    ci_lb = round(ci_lb, 4),
    ci_ub = round(ci_ub, 4),
    pval = round(pval, 4),
    k = k,
    n_methods = length(methods_results),
    method_estimates = round(estimates, 4),
    method_weights = round(weights, 3),
    method_ses = round(ses, 4),
    var_within = round(var_within, 6),
    var_between = round(var_between, 6),
    agreement = round(1 - stats::sd(estimates) / abs(estimate_ema), 3)
  )
}
