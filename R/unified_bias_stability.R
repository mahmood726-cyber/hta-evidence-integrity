#' Unified Bias-Stability Framework
#'
#' Computes a base REML estimate, derives a bias-adjusted estimate via
#' trim-and-fill (with an Egger's-regression flag), derives a stability-adjusted
#' estimate by shrinking toward the leave-one-out median, and reports a
#' weighted combination of the two adjustments. The standard error is inflated
#' when bias or fragility is detected so the CI reflects this added
#' uncertainty.
#'
#' @param yi Numeric vector of effect sizes.
#' @param vi Numeric vector of sampling variances.
#' @param bias_weight Weight on the trim-and-fill bias adjustment. Default
#'   `0.5`.
#' @param stability_weight Weight on the leave-one-out stability adjustment.
#'   Default `0.5`.
#'
#' @return A list with the adjusted estimate, SE, CI, p-value, between-study
#'   variance, bias and stability diagnostics, the decomposed adjustments, and
#'   the SE inflation factor.
#'
#' @examples
#' set.seed(1)
#' k  <- 10
#' yi <- 0.3 + rnorm(k, sd = 0.15) + rnorm(k, sd = 0.20)
#' vi <- runif(k, 0.02, 0.20)
#' unified_bias_stability(yi, vi)
#'
#' @importFrom metafor rma regtest trimfill leave1out
#' @importFrom stats qnorm pnorm median
#' @export
unified_bias_stability <- function(yi, vi, bias_weight = 0.5,
                                   stability_weight = 0.5) {

  k <- length(yi)

  if (k < 5) {
    fit <- metafor::rma(yi = yi, vi = vi, method = "REML")
    return(list(
      estimate = fit$beta[1],
      se = fit$se,
      method = "UBSF",
      message = "Insufficient studies for bias-stability analysis"
    ))
  }

  fit_base <- metafor::rma(yi = yi, vi = vi, method = "REML")
  estimate_base <- fit_base$beta[1]
  se_base <- fit_base$se
  tau2 <- fit_base$tau2

  egger <- tryCatch(metafor::regtest(fit_base, model = "lm"),
                    error = function(e) NULL)

  bias_detected <- FALSE
  bias_pval <- 1

  if (!is.null(egger)) {
    bias_pval <- egger$pval
    bias_detected <- bias_pval < 0.10
  }

  tf <- tryCatch(metafor::trimfill(fit_base), error = function(e) NULL)
  if (!is.null(tf) && tf$k0 > 0) {
    estimate_bias_adj <- tf$beta[1]
    k_imputed <- tf$k0
  } else {
    estimate_bias_adj <- estimate_base
    k_imputed <- 0
  }

  loo <- metafor::leave1out(fit_base)
  dir_changes <- sum((loo$estimate > 0) != (estimate_base > 0), na.rm = TRUE)
  dir_fragile <- dir_changes > 0
  sig_changes <- sum((loo$pval < 0.05) != (fit_base$pval < 0.05), na.rm = TRUE)
  sig_fragile <- sig_changes > 0
  max_change <- max(abs(loo$estimate - estimate_base), na.rm = TRUE)

  loo_median <- stats::median(loo$estimate, na.rm = TRUE)
  estimate_stability_adj <- estimate_base +
    stability_weight * (loo_median - estimate_base)

  bias_adjustment <- estimate_bias_adj - estimate_base
  stability_adjustment <- estimate_stability_adj - estimate_base
  total_adjustment <- bias_weight * bias_adjustment +
    stability_weight * stability_adjustment
  estimate_ubsf <- estimate_base + total_adjustment

  se_inflation <- 1 + 0.1 * (as.numeric(bias_detected) +
                             as.numeric(dir_fragile) +
                             as.numeric(sig_fragile))
  se_ubsf <- se_base * se_inflation

  z <- stats::qnorm(0.975)
  ci_lb <- estimate_ubsf - z * se_ubsf
  ci_ub <- estimate_ubsf + z * se_ubsf
  z_stat <- estimate_ubsf / se_ubsf
  pval <- 2 * stats::pnorm(-abs(z_stat))

  list(
    method = "UBSF (Unified Bias-Stability Framework)",
    estimate = round(estimate_ubsf, 4),
    se = round(se_ubsf, 4),
    ci_lb = round(ci_lb, 4),
    ci_ub = round(ci_ub, 4),
    pval = round(pval, 4),
    tau2 = round(tau2, 4),
    k = k,
    bias_detected = bias_detected,
    bias_pval = round(bias_pval, 4),
    k_imputed = k_imputed,
    bias_adjustment = round(bias_adjustment, 4),
    direction_fragile = dir_fragile,
    significance_fragile = sig_fragile,
    max_loo_change = round(max_change, 4),
    stability_adjustment = round(stability_adjustment, 4),
    estimate_original = round(estimate_base, 4),
    total_adjustment = round(total_adjustment, 4),
    se_inflation = round(se_inflation, 3)
  )
}
