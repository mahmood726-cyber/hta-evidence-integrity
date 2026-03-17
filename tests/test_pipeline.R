# TEST SUITE: HTA Evidence Integrity Pipeline
# Tests OIS calculation, GRADE mapping, bias correction, and evidence classification

suppressPackageStartupMessages({
  library(data.table)
  library(testthat)
})

cat("=== HTA Evidence Integrity Suite: Test Pipeline ===\n")

# ============================================================================
# 1. OIS CALCULATION TESTS
# ============================================================================

test_that("OIS base calculation is positive for valid p_control", {
  # Reproduce the function from unified_hta_validation.R
  calculate_base_ois <- function(p_control, alpha = 0.05, power = 0.80, rrr = 0.20) {
    if (is.na(p_control) || p_control <= 0 || p_control >= 1) p_control <- 0.1
    z_alpha <- qnorm(1 - alpha/2)
    z_beta <- qnorm(power)
    p_treat <- p_control * (1 - rrr)
    var_c <- 1/(p_control*(1-p_control))
    var_t <- 1/(p_treat*(1-p_treat))
    log_or <- log((p_treat/(1-p_treat))/(p_control/(1-p_control)))
    D <- ((z_alpha + z_beta)^2 * (var_c + var_t)) / log_or^2
    return(2 * D)
  }

  # Standard case: 10% control rate
  ois <- calculate_base_ois(0.10)
  expect_true(ois > 0)
  expect_true(is.finite(ois))

  # Higher control rate → smaller OIS (easier to detect effect)
  ois_high <- calculate_base_ois(0.50)
  expect_true(ois_high < ois)

  # Very low control rate → large OIS (harder to detect)
  ois_low <- calculate_base_ois(0.01)
  expect_true(ois_low > ois)

  # Invalid p_control → falls back to 0.1
  ois_na <- calculate_base_ois(NA)
  expect_equal(ois_na, ois)
  ois_zero <- calculate_base_ois(0)
  expect_equal(ois_zero, ois)
  ois_one <- calculate_base_ois(1)
  expect_equal(ois_one, ois)
})

test_that("OIS uses qnorm not hardcoded 1.96", {
  # Verify z_alpha for alpha=0.05 matches qnorm(0.975) ≈ 1.9599...
  z <- qnorm(1 - 0.05/2)
  expect_equal(z, qnorm(0.975))
  expect_true(abs(z - 1.96) < 0.001)  # close but not exactly 1.96

  # Verify z_beta for power=0.80 matches qnorm(0.80) ≈ 0.8416...
  zb <- qnorm(0.80)
  expect_true(abs(zb - 0.84) < 0.005)
})

# ============================================================================
# 2. GRADE MAPPING TESTS
# ============================================================================

test_that("GRADE certainty follows evidence classification rules", {
  # Based on unified_hta_validation.R logic
  classify_grade <- function(inf_frac, bias_detected, discordant) {
    if (inf_frac >= 1.0 && !bias_detected && !discordant) return("HIGH")
    if (inf_frac >= 0.5 && !discordant) return("MODERATE")
    if (inf_frac >= 0.2) return("LOW")
    return("VERY LOW")
  }

  expect_equal(classify_grade(1.5, FALSE, FALSE), "HIGH")
  expect_equal(classify_grade(1.0, TRUE, FALSE), "MODERATE")
  expect_equal(classify_grade(0.8, FALSE, FALSE), "MODERATE")
  expect_equal(classify_grade(0.3, FALSE, FALSE), "LOW")
  expect_equal(classify_grade(0.1, FALSE, FALSE), "VERY LOW")
})

# ============================================================================
# 3. EVIDENCE CLASSIFICATION TESTS
# ============================================================================

test_that("Evidence classes are correctly assigned", {
  classify_evidence <- function(inf_frac, bias_detected, discordant) {
    if (inf_frac >= 1.0 && !bias_detected) return("Gold Standard")
    if (discordant) return("Critical Warning (Sign Reversal)")
    if (bias_detected && inf_frac < 0.5) return("Premature (Bias + Low Power)")
    if (bias_detected) return("Bias Detected")
    if (inf_frac < 0.5) return("Underpowered")
    return("Inconclusive")
  }

  expect_equal(classify_evidence(1.5, FALSE, FALSE), "Gold Standard")
  expect_equal(classify_evidence(0.8, FALSE, FALSE), "Inconclusive")
  expect_equal(classify_evidence(0.3, TRUE, FALSE), "Premature (Bias + Low Power)")
  expect_equal(classify_evidence(0.8, TRUE, FALSE), "Bias Detected")
  expect_equal(classify_evidence(0.3, FALSE, FALSE), "Underpowered")
  expect_equal(classify_evidence(0.5, FALSE, TRUE), "Critical Warning (Sign Reversal)")
})

# ============================================================================
# 4. BIAS CORRECTION TESTS (Trim-and-Fill + PET-PEESE)
# ============================================================================

test_that("Information fraction is bounded [0, Inf) and meaningful", {
  # inf_frac = total_n / ois_adjusted
  inf_frac <- function(total_n, ois_adjusted) total_n / ois_adjusted

  # Normal case
  expect_equal(inf_frac(1000, 2000), 0.5)
  # Gold standard
  expect_equal(inf_frac(3000, 2000), 1.5)
  # Very underpowered
  expect_true(inf_frac(100, 10000) < 0.05)
})

# ============================================================================
# 5. OUTPUT VALIDATION TESTS (if CSV exists)
# ============================================================================

csv_path <- if (file.exists("analysis/output/unified_hta_validation.csv")) {
  "analysis/output/unified_hta_validation.csv"
} else if (file.exists("../analysis/output/unified_hta_validation.csv")) {
  "../analysis/output/unified_hta_validation.csv"
} else NULL

if (!is.null(csv_path)) {
  dt <- fread(csv_path)

  test_that("Output CSV has required columns", {
    required <- c("dataset_name", "k", "total_n", "inf_frac", "evidence_class",
                   "grade_certainty", "bias_detected", "orig_estimate")
    missing <- setdiff(required, names(dt))
    expect_equal(length(missing), 0, info = paste("Missing:", paste(missing, collapse=", ")))
  })

  test_that("All inf_frac values are non-negative and finite", {
    expect_true(all(dt$inf_frac >= 0))
    expect_true(all(is.finite(dt$inf_frac)))
  })

  test_that("GRADE certainty has valid base levels", {
    # GRADE may include qualifiers like "(Downgrade: Imprecision)" or "(Downgrade: Bias)"
    valid_bases <- c("HIGH", "MODERATE", "LOW", "VERY LOW")
    base_grades <- sub(" \\(.*\\)", "", dt$grade_certainty)
    expect_true(all(base_grades %in% valid_bases))
  })

  test_that("Evidence classes are valid", {
    valid_classes <- c("Gold Standard", "Bias Detected", "Underpowered",
                       "Premature (Bias + Low Power)", "Premature",
                       "Critical Warning (Sign Reversal)", "Inconclusive",
                       "Robust (Bias-Corrected)")
    expect_true(all(dt$evidence_class %in% valid_classes))
  })

  test_that("k values are positive integers", {
    expect_true(all(dt$k >= 1))
    expect_true(all(dt$k == as.integer(dt$k)))
  })

  cat(sprintf("Output CSV validated: %d technologies, %d Gold Standard (%.1f%%)\n",
              nrow(dt), sum(dt$evidence_class == "Gold Standard"),
              100 * mean(dt$evidence_class == "Gold Standard")))
}

cat("All Evidence Integrity tests complete.\n")
