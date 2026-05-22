## Pairwise70 quickstart
##
## Runs every exported pooling method on the BCG vaccine meta-analysis
## (k = 13, log relative-risk scale) and prints a comparison table plus a
## couple of detailed diagnostic reports.
##
## Run interactively with:
##   source(system.file("examples", "quickstart.R", package = "Pairwise70"))

library(Pairwise70)

set.seed(42)
k  <- 13
yi <- 0.30 + rnorm(k, sd = 0.15) + rnorm(k, sd = 0.20)
vi <- runif(k, 0.02, 0.20)

cat("\n=== Side-by-side method comparison ===\n")
print(compare_pooling_methods(yi, vi))

cat("\n=== MAFI-weighted pooling (MWM) ===\n")
mwm <- mafi_weighted_ma(yi, vi)
cat(sprintf("estimate = %.4f (SE %.4f); 95%% CI [%.4f, %.4f]\n",
            mwm$estimate, mwm$se, mwm$ci_lb, mwm$ci_ub))
cat(sprintf("adjustment vs. REML base: %+.4f\n", mwm$adjustment))
cat("per-study stability scores:\n")
print(mwm$study_stability_scores)

cat("\n=== Unified bias-stability framework (UBSF) ===\n")
ubsf <- unified_bias_stability(yi, vi)
cat(sprintf("estimate = %.4f (SE %.4f); 95%% CI [%.4f, %.4f]\n",
            ubsf$estimate, ubsf$se, ubsf$ci_lb, ubsf$ci_ub))
cat(sprintf("Egger p = %.4f -> bias_detected = %s\n",
            ubsf$bias_pval, ubsf$bias_detected))
cat(sprintf("direction fragile = %s; significance fragile = %s\n",
            ubsf$direction_fragile, ubsf$significance_fragile))
cat(sprintf("SE inflation applied: x%.2f\n", ubsf$se_inflation))

cat("\n=== Ensemble across all methods ===\n")
ema <- ensemble_meta_analysis(yi, vi, include_rve = FALSE)
cat(sprintf("estimate = %.4f (SE %.4f); 95%% CI [%.4f, %.4f]\n",
            ema$estimate, ema$se, ema$ci_lb, ema$ci_ub))
cat(sprintf("contributing methods: %d, agreement = %.3f\n",
            ema$n_methods, ema$agreement))
