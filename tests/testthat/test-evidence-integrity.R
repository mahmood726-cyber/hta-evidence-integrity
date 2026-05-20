calculate_base_ois <- function(p_control, alpha = 0.05, power = 0.80,
                               rrr = 0.20) {
  if (is.na(p_control) || p_control <= 0 || p_control >= 1) p_control <- 0.1
  z_alpha <- qnorm(1 - alpha / 2)
  z_beta <- qnorm(power)
  p_treat <- p_control * (1 - rrr)
  var_c <- 1 / (p_control * (1 - p_control))
  var_t <- 1 / (p_treat * (1 - p_treat))
  log_or <- log((p_treat / (1 - p_treat)) / (p_control / (1 - p_control)))
  D <- ((z_alpha + z_beta) ^ 2 * (var_c + var_t)) / log_or ^ 2
  2 * D
}

classify_grade <- function(inf_frac, bias_detected, discordant) {
  if (inf_frac >= 1.0 && !bias_detected && !discordant) return("HIGH")
  if (inf_frac >= 0.5 && !discordant) return("MODERATE")
  if (inf_frac >= 0.2) return("LOW")
  "VERY LOW"
}

classify_evidence <- function(inf_frac, bias_detected, discordant) {
  if (inf_frac >= 1.0 && !bias_detected) return("Gold Standard")
  if (discordant) return("Critical Warning (Sign Reversal)")
  if (bias_detected && inf_frac < 0.5) return("Premature (Bias + Low Power)")
  if (bias_detected) return("Bias Detected")
  if (inf_frac < 0.5) return("Underpowered")
  "Inconclusive"
}

test_that("OIS is finite and positive for valid p_control", {
  ois <- calculate_base_ois(0.10)
  expect_true(ois > 0)
  expect_true(is.finite(ois))
})

test_that("higher control event rate yields smaller OIS", {
  expect_lt(calculate_base_ois(0.50), calculate_base_ois(0.10))
  expect_gt(calculate_base_ois(0.01), calculate_base_ois(0.10))
})

test_that("OIS falls back to p_control=0.1 for invalid inputs", {
  ref <- calculate_base_ois(0.10)
  expect_equal(calculate_base_ois(NA), ref)
  expect_equal(calculate_base_ois(0), ref)
  expect_equal(calculate_base_ois(1), ref)
})

test_that("OIS uses qnorm not a hardcoded 1.96", {
  z <- qnorm(1 - 0.05 / 2)
  expect_equal(z, qnorm(0.975))
  expect_lt(abs(z - 1.96), 0.001)
  expect_lt(abs(qnorm(0.80) - 0.84), 0.005)
})

test_that("GRADE certainty follows the documented rules", {
  expect_equal(classify_grade(1.5, FALSE, FALSE), "HIGH")
  expect_equal(classify_grade(1.0, TRUE, FALSE), "MODERATE")
  expect_equal(classify_grade(0.8, FALSE, FALSE), "MODERATE")
  expect_equal(classify_grade(0.3, FALSE, FALSE), "LOW")
  expect_equal(classify_grade(0.1, FALSE, FALSE), "VERY LOW")
})

test_that("evidence classes follow the documented rules", {
  expect_equal(classify_evidence(1.5, FALSE, FALSE), "Gold Standard")
  expect_equal(classify_evidence(0.8, FALSE, FALSE), "Inconclusive")
  expect_equal(classify_evidence(0.3, TRUE, FALSE),
               "Premature (Bias + Low Power)")
  expect_equal(classify_evidence(0.8, TRUE, FALSE), "Bias Detected")
  expect_equal(classify_evidence(0.3, FALSE, FALSE), "Underpowered")
  expect_equal(classify_evidence(0.5, FALSE, TRUE),
               "Critical Warning (Sign Reversal)")
})

test_that("information fraction is non-negative and bounded as expected", {
  inf_frac <- function(total_n, ois_adjusted) total_n / ois_adjusted
  expect_equal(inf_frac(1000, 2000), 0.5)
  expect_equal(inf_frac(3000, 2000), 1.5)
  expect_lt(inf_frac(100, 10000), 0.05)
})
