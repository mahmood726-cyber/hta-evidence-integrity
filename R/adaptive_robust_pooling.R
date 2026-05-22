#' Adaptive Robust Pooling
#'
#' Fits the random-effects model with four estimators (REML, DL, PM, HKSJ) and
#' combines them with weights that depend on observed heterogeneity (`I^2`) and
#' the number of studies. Variance of the pooled estimate includes a
#' between-estimator term so model uncertainty is reflected in the CI.
#'
#' @param yi Numeric vector of effect sizes.
#' @param vi Numeric vector of sampling variances.
#' @param alpha Two-sided significance level for the CI. Default `0.05`.
#'
#' @return A list with the pooled estimate, SE, CI, p-value, mean `I^2`,
#'   per-estimator estimates and weights, and within/between variance
#'   components.
#'
#' @examples
#' set.seed(1)
#' k  <- 10
#' yi <- 0.3 + rnorm(k, sd = 0.15) + rnorm(k, sd = 0.20)
#' vi <- runif(k, 0.02, 0.20)
#' adaptive_robust_pooling(yi, vi)
#'
#' @importFrom metafor rma
#' @importFrom stats qnorm pnorm
#' @export
adaptive_robust_pooling <- function(yi, vi, alpha = 0.05) {

  k <- length(yi)

  if (k < 3) {
    return(list(
      estimate = mean(yi),
      se = sqrt(mean(vi)),
      method = "ARP",
      message = "Insufficient studies"
    ))
  }

  estimators <- list()

  tryCatch({
    fit_reml <- metafor::rma(yi = yi, vi = vi, method = "REML")
    estimators$REML <- list(estimate = fit_reml$beta[1], se = fit_reml$se,
                            tau2 = fit_reml$tau2, I2 = fit_reml$I2,
                            pval = fit_reml$pval)
  }, error = function(e) NULL)

  tryCatch({
    fit_dl <- metafor::rma(yi = yi, vi = vi, method = "DL")
    estimators$DL <- list(estimate = fit_dl$beta[1], se = fit_dl$se,
                          tau2 = fit_dl$tau2, I2 = fit_dl$I2,
                          pval = fit_dl$pval)
  }, error = function(e) NULL)

  tryCatch({
    fit_pm <- metafor::rma(yi = yi, vi = vi, method = "PM")
    estimators$PM <- list(estimate = fit_pm$beta[1], se = fit_pm$se,
                          tau2 = fit_pm$tau2, I2 = fit_pm$I2,
                          pval = fit_pm$pval)
  }, error = function(e) NULL)

  tryCatch({
    fit_hksj <- metafor::rma(yi = yi, vi = vi, method = "REML", test = "knha")
    estimators$HKSJ <- list(estimate = fit_hksj$beta[1], se = fit_hksj$se,
                            tau2 = fit_hksj$tau2, I2 = fit_hksj$I2,
                            pval = fit_hksj$pval)
  }, error = function(e) NULL)

  if (length(estimators) == 0) {
    return(list(method = "ARP", estimate = NA, se = NA,
                message = "All estimators failed"))
  }

  I2_mean <- mean(sapply(estimators, function(x) x$I2), na.rm = TRUE)

  weights <- list()
  if (I2_mean < 25) {
    weights$REML <- 0.50; weights$DL <- 0.20
    weights$PM   <- 0.10; weights$HKSJ <- 0.20
  } else if (I2_mean < 50) {
    weights$REML <- 0.30; weights$DL <- 0.25
    weights$PM   <- 0.20; weights$HKSJ <- 0.25
  } else if (I2_mean < 75) {
    weights$REML <- 0.15; weights$DL <- 0.20
    weights$PM   <- 0.30; weights$HKSJ <- 0.35
  } else {
    weights$REML <- 0.10; weights$DL <- 0.15
    weights$PM   <- 0.35; weights$HKSJ <- 0.40
  }

  if (k < 10) {
    weights$HKSJ <- weights$HKSJ + 0.15
    weights$REML <- weights$REML - 0.10
    weights$DL   <- weights$DL   - 0.05
  }

  available_weights <- unlist(weights[names(estimators)])
  available_weights <- available_weights / sum(available_weights)

  estimates <- sapply(estimators, function(x) x$estimate)
  ses <- sapply(estimators, function(x) x$se)

  estimate_arp <- sum(available_weights * estimates)
  var_within <- sum(available_weights * ses^2)
  var_between <- sum(available_weights * (estimates - estimate_arp)^2)
  se_arp <- sqrt(var_within + var_between)

  z <- stats::qnorm(1 - alpha / 2)
  ci_lb <- estimate_arp - z * se_arp
  ci_ub <- estimate_arp + z * se_arp
  z_stat <- estimate_arp / se_arp
  pval <- 2 * stats::pnorm(-abs(z_stat))

  list(
    method = "ARP (Adaptive Robust Pooling)",
    estimate = round(estimate_arp, 4),
    se = round(se_arp, 4),
    ci_lb = round(ci_lb, 4),
    ci_ub = round(ci_ub, 4),
    pval = round(pval, 4),
    k = k,
    I2_mean = round(I2_mean, 1),
    estimator_weights = round(available_weights, 3),
    estimator_estimates = round(estimates, 4),
    estimator_ses = round(ses, 4),
    var_within = round(var_within, 6),
    var_between = round(var_between, 6)
  )
}
