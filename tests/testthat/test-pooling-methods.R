skip_if_not_installed("metafor")

make_data <- function() {
  set.seed(42)
  k <- 12
  mu <- 0.30
  tau <- 0.15
  vi <- runif(k, min = 0.02, max = 0.20)
  yi <- mu + rnorm(k, sd = tau) + rnorm(k, sd = sqrt(vi))
  list(yi = yi, vi = vi)
}

test_that("mafi_weighted_ma returns a finite estimate and a valid CI", {
  d <- make_data()
  res <- mafi_weighted_ma(d$yi, d$vi)
  expect_true(is.finite(res$estimate))
  expect_true(is.finite(res$se) && res$se > 0)
  expect_lt(res$ci_lb, res$ci_ub)
  expect_equal(res$k, length(d$yi))
  expect_length(res$study_stability_scores, length(d$yi))
})

test_that("mafi_weighted_ma short-circuits when k < 3", {
  res <- mafi_weighted_ma(c(0.1, 0.2), c(0.01, 0.02))
  expect_true(grepl("Insufficient", res$message))
})

test_that("adaptive_robust_pooling combines estimators and reports I2", {
  d <- make_data()
  res <- adaptive_robust_pooling(d$yi, d$vi)
  expect_true(is.finite(res$estimate))
  expect_true(res$I2_mean >= 0 && res$I2_mean <= 100)
  expect_true(all(res$estimator_weights >= 0))
  expect_equal(sum(res$estimator_weights), 1, tolerance = 1e-6)
})

test_that("sequential_influence_trimming converges and tracks history", {
  d <- make_data()
  res <- sequential_influence_trimming(d$yi, d$vi)
  expect_true(is.finite(res$estimate))
  expect_true(res$iterations >= 1)
  expect_length(res$final_weights, length(d$yi))
  expect_true(all(res$final_weights >= 0))
})

test_that("unified_bias_stability returns bias and stability diagnostics", {
  d <- make_data()
  res <- unified_bias_stability(d$yi, d$vi)
  expect_true(is.finite(res$estimate))
  expect_true(is.logical(res$bias_detected))
  expect_true(is.logical(res$direction_fragile))
  expect_true(res$se_inflation >= 1)
})

test_that("ensemble_meta_analysis blends multiple methods", {
  d <- make_data()
  res <- ensemble_meta_analysis(d$yi, d$vi, include_rve = FALSE)
  expect_true(is.finite(res$estimate))
  expect_true(res$n_methods >= 2)
  expect_equal(sum(res$method_weights), 1, tolerance = 1e-6)
})

test_that("compare_pooling_methods returns one row per method", {
  d <- make_data()
  cmp <- compare_pooling_methods(d$yi, d$vi)
  expect_s3_class(cmp, "data.frame")
  expect_true(nrow(cmp) >= 5)
  expect_named(cmp, c("Method", "Estimate", "SE",
                      "CI_Lower", "CI_Upper", "PValue"))
  expect_true(all(cmp$CI_Lower <= cmp$CI_Upper, na.rm = TRUE))
})

test_that("compare_all_methods is an alias for compare_pooling_methods", {
  expect_identical(compare_all_methods, compare_pooling_methods)
})
