#!/usr/bin/env Rscript

################################################################################
# UNIFIED HTA VALIDATION (RED TEAM APPROVED)
# Features: Heterogeneity Penalty, Unadjusted OIS, Discordance Check
################################################################################

suppressPackageStartupMessages({
  library(data.table)
  library(dplyr)
})

# RELATIVE PATH SETUP
get_script_dir <- function() {
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- "--file="
  match <- grep(file_arg, args)
  if (length(match) > 0) {
    return(dirname(normalizePath(sub(file_arg, "", args[match]))))
  } else {
    return(getwd())
  }
}
base_dir <- get_script_dir()
project_root <- normalizePath(file.path(base_dir, ".."), mustWork = FALSE)

# PATHS (With Fallback)
input_csv <- file.path(project_root, "analysis/output/bias_corrected_results.csv")
output_csv <- file.path(project_root, "analysis/output/unified_hta_validation.csv")

if (!file.exists(input_csv)) {
  # Fallback: try parent directory
  project_root <- normalizePath(file.path(getwd(), ".."), winslash = "/")
  input_csv <- file.path(project_root, "analysis/output/bias_corrected_results.csv")
  output_csv <- file.path(project_root, "analysis/output/unified_hta_validation.csv")
}

cat("================================================================================\n")
cat("UNIFIED HTA VALIDATION: RED TEAM APPROVED\n")
cat(sprintf("Input: %s\n", input_csv))
cat("================================================================================\n\n")

bias_results <- fread(input_csv)

# 1. CALCULATE BASE OIS (Fixed Effect Requirement)
calculate_base_ois <- function(p_control) {
  if (is.na(p_control) || p_control <= 0 || p_control >= 1) p_control <- 0.1
  # HTA Standard: 80% Power, 20% RRR, alpha 0.05
  z_alpha <- qnorm(1 - 0.05/2); z_beta <- qnorm(0.80)
  p_treat <- p_control * 0.80
  var_c <- 1/(p_control*(1-p_control)); var_t <- 1/(p_treat*(1-p_treat))
  log_or <- log((p_treat/(1-p_treat))/(p_control/(1-p_control)))
  D <- ((z_alpha + z_beta)^2 * (var_c + var_t)) / log_or^2
  return(2 * D)
}

bias_results[, ois_base := mapply(calculate_base_ois, p_control)]

# 2. CALCULATE HETEROGENEITY PENALTY
bias_results[, het_penalty := 1 / (1 - min(0.95, max(0, I2 / 100)))]
bias_results[, ois_adjusted := ois_base * het_penalty]

# 3. INFORMATION FRACTION & RARE DISEASE GUARDRAIL
bias_results[, is_rare_disease := total_n < 250]
bias_results[, inf_frac := total_n / ois_adjusted]

# 4. CLASSIFICATION (With Rare Disease & Discordance Flags)
bias_results[, evidence_class := case_when(
  discordant == TRUE ~ "Critical Warning (Sign Reversal)",
  is_rare_disease == TRUE & orig_p < 0.05 ~ "Small Population / Rare Disease (Qualitative Assessment)",
  bias_detected == FALSE & inf_frac >= 1.0 & orig_p < 0.05 ~ "Gold Standard",
  bias_detected == TRUE & tf_p < 0.05 & inf_frac >= 1.0 ~ "Robust (Bias-Corrected)",
  inf_frac < 1.0 & orig_p < 0.05 ~ "Premature",
  orig_p >= 0.05 ~ "Inconclusive",
  TRUE ~ "Low Quality"
)]

bias_results[, grade_certainty := case_when(
  evidence_class == "Gold Standard" ~ "HIGH",
  evidence_class == "Small Population / Rare Disease (Qualitative Assessment)" ~ "MODERATE (Contextual Exception)",
  evidence_class == "Robust (Bias-Corrected)" ~ "MODERATE (Downgrade: Bias)",
  evidence_class == "Premature" ~ "LOW (Downgrade: Imprecision)",
  evidence_class == "Inconclusive" ~ "VERY LOW",
  TRUE ~ "VERY LOW"
)]

# Summary
cat("\n--- EVIDENCE CLASS DISTRIBUTION ---\n")
print(bias_results[, .N, by = evidence_class])

cat("\n--- HETEROGENEITY PENALTY STATS ---\n")
print(summary(bias_results$het_penalty))

fwrite(bias_results, output_csv)
cat(sprintf("\nValidation results saved to: %s\n", output_csv))