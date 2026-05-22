#' Compare Pooling Methods
#'
#' Runs the standard REML model, HKSJ, optional RVE, and each of the advanced
#' pooling methods on the same dataset and returns a single data frame with
#' point estimates, standard errors, 95% CIs, and p-values for side-by-side
#' comparison.
#'
#' @param yi Numeric vector of effect sizes.
#' @param vi Numeric vector of sampling variances.
#' @param include_robma If `TRUE`, also fit `RoBMA::RoBMA()` (slow, requires
#'   the `RoBMA` package). Default `FALSE`.
#'
#' @return A `data.frame` with one row per method and columns `Method`,
#'   `Estimate`, `SE`, `CI_Lower`, `CI_Upper`, `PValue`.
#'
#' @examples
#' set.seed(1)
#' k  <- 10
#' yi <- 0.3 + rnorm(k, sd = 0.15) + rnorm(k, sd = 0.20)
#' vi <- runif(k, 0.02, 0.20)
#' compare_pooling_methods(yi, vi)
#'
#' @importFrom metafor rma
#' @importFrom stats pnorm
#' @export
compare_pooling_methods <- function(yi, vi, include_robma = FALSE) {

  k <- length(yi)
  sei <- sqrt(vi)

  results <- data.frame(
    Method = character(),
    Estimate = numeric(),
    SE = numeric(),
    CI_Lower = numeric(),
    CI_Upper = numeric(),
    PValue = numeric(),
    stringsAsFactors = FALSE
  )

  tryCatch({
    fit <- metafor::rma(yi = yi, vi = vi, method = "REML")
    results <- rbind(results, data.frame(
      Method = "REML (Standard)",
      Estimate = round(fit$beta[1], 4),
      SE = round(fit$se, 4),
      CI_Lower = round(fit$ci.lb, 4),
      CI_Upper = round(fit$ci.ub, 4),
      PValue = round(fit$pval, 4)
    ))
  }, error = function(e) NULL)

  tryCatch({
    fit <- metafor::rma(yi = yi, vi = vi, method = "REML", test = "knha")
    results <- rbind(results, data.frame(
      Method = "HKSJ",
      Estimate = round(fit$beta[1], 4),
      SE = round(fit$se, 4),
      CI_Lower = round(fit$ci.lb, 4),
      CI_Upper = round(fit$ci.ub, 4),
      PValue = round(fit$pval, 4)
    ))
  }, error = function(e) NULL)

  if (requireNamespace("clubSandwich", quietly = TRUE)) {
    tryCatch({
      fit <- metafor::rma(yi = yi, vi = vi, method = "REML")
      vcov_rve <- clubSandwich::vcovCR(fit, type = "CR2")
      se_rve <- sqrt(diag(vcov_rve))
      ci_lb <- fit$beta[1] - 1.96 * se_rve
      ci_ub <- fit$beta[1] + 1.96 * se_rve
      pval <- 2 * stats::pnorm(-abs(fit$beta[1] / se_rve))
      results <- rbind(results, data.frame(
        Method = "RVE (CR2)",
        Estimate = round(fit$beta[1], 4),
        SE = round(se_rve, 4),
        CI_Lower = round(ci_lb, 4),
        CI_Upper = round(ci_ub, 4),
        PValue = round(pval, 4)
      ))
    }, error = function(e) NULL)
  }

  for (entry in list(
    list(name = "MWM (MAFI-Weighted)",   fn = mafi_weighted_ma),
    list(name = "ARP (Adaptive)",        fn = adaptive_robust_pooling),
    list(name = "SIT (Influence Trim)",  fn = sequential_influence_trimming),
    list(name = "UBSF (Bias-Stability)", fn = unified_bias_stability),
    list(name = "EMA (Ensemble)",        fn = ensemble_meta_analysis)
  )) {
    tryCatch({
      r <- entry$fn(yi, vi)
      results <- rbind(results, data.frame(
        Method = entry$name,
        Estimate = r$estimate,
        SE = r$se,
        CI_Lower = r$ci_lb,
        CI_Upper = r$ci_ub,
        PValue = r$pval
      ))
    }, error = function(e) NULL)
  }

  if (include_robma && requireNamespace("RoBMA", quietly = TRUE) && k >= 4) {
    tryCatch({
      robma_fit <- RoBMA::RoBMA(d = yi, se = sei, parallel = FALSE,
                                seed = 123, chains = 2, iter = 2000)
      robma_summary <- summary(robma_fit)
      results <- rbind(results, data.frame(
        Method = "RoBMA (Bayesian)",
        Estimate = round(robma_summary$estimates$Mean[1], 4),
        SE = round(robma_summary$estimates$SD[1], 4),
        CI_Lower = round(robma_summary$estimates$`2.5%`[1], 4),
        CI_Upper = round(robma_summary$estimates$`97.5%`[1], 4),
        PValue = NA
      ))
    }, error = function(e) NULL)
  }

  results
}

#' @rdname compare_pooling_methods
#' @export
compare_all_methods <- compare_pooling_methods
