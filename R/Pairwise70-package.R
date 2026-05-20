#' Pairwise70: Advanced Pooling Methods for Pairwise Meta-Analysis
#'
#' Implements a small family of robust pooling estimators developed against the
#' Pairwise70 collection of Cochrane pairwise meta-analyses:
#'
#' \itemize{
#'   \item [mafi_weighted_ma()] — MAFI-weighted pooling (stability + precision).
#'   \item [adaptive_robust_pooling()] — multi-estimator weighting by `I^2`.
#'   \item [sequential_influence_trimming()] — iterative influence downweighting.
#'   \item [unified_bias_stability()] — trim-and-fill + leave-one-out blend.
#'   \item [ensemble_meta_analysis()] — weighted ensemble across the above.
#'   \item [compare_pooling_methods()] — side-by-side comparison table.
#' }
#'
#' @keywords internal
"_PACKAGE"
