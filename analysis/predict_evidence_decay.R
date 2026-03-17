#!/usr/bin/env Rscript

################################################################################
# ADVANCED PREDICTIVE MODELING (RSM VERSION)
# Predicts evidence reversal using outcome-type and raw stats (prevents circularity)
################################################################################

suppressPackageStartupMessages({
  library(data.table)
  library(metafor)
  library(caret)
  library(pROC)
})

cat("================================================================================\n")
cat("HTA ADVANCED ML: EVIDENCE DECAY (RSM TIER)\n")
cat("================================================================================\n\n")

# Load Data
unified_dt <- fread(file.path(dirname(getwd()), "analysis/output/unified_hta_validation.csv"))
source("../config_paths.R")
fragility_dt <- fread(file.path(PAIRWISE70_ROOT, "analysis/output/fragility_analysis_results.csv"))

# Standardize keys and Merge
unified_dt[, dataset := dataset_name]
unified_dt[, analysis_id := as.character(sub("::.*", "", analysis_key))]
fragility_dt[, analysis_id := as.character(analysis_id)]
model_data <- merge(unified_dt, fragility_dt[, .(dataset, analysis_id, sig_fragile)], by = c("dataset", "analysis_id"), all.x = TRUE)

# Target: Sig Reversal (Sig but Fragile)
model_data[, decay_risk := as.factor(ifelse(sig_fragile == TRUE, "HighRisk", "Stable"))]

# Subgroup: Premature conclusions (the group we care about)
premature_data <- model_data[grade_certainty == "LOW (Downgrade: Imprecision)"]

# Feature Engineering (Avoid circularity with IF)
premature_data[, `:=`(
  log_k = log(k),
  I2_val = I2,
  z_mag = pmin(10, abs(orig_estimate / pmax(1e-6, abs(orig_estimate)/pmax(1e-6, qnorm(1-pmax(1e-10, orig_p)/2))))),
  outcome_bin = as.numeric(outcome_type == "binary"),
  n_per_study = total_n / k
)]

# Remove rows with non-finite values before training
premature_data <- premature_data[is.finite(log_k) & is.finite(I2_val) & is.finite(z_mag) & is.finite(n_per_study)]

cat(sprintf("Training model on %d valid premature cases...\n", nrow(premature_data)))

set.seed(42)
train_idx <- createDataPartition(premature_data$decay_risk, p = 0.7, list = FALSE)
train_set <- premature_data[train_idx]
test_set <- premature_data[-train_idx]

# Logistic Regression with Outcome Type
decay_model <- glm(decay_risk ~ log_k + I2_val + z_mag + outcome_bin + n_per_study, 
                   data = train_set, family = "binomial")

test_probs <- predict(decay_model, newdata = test_set, type = "response")
test_auc <- roc(test_set$decay_risk, test_probs)$auc

cat(sprintf("RSM Model AUC: %.3f\n", test_auc))

# Output High Risk
premature_data$decay_probability <- predict(decay_model, newdata = premature_data, type = "response")
fwrite(premature_data, file.path(dirname(getwd()), "analysis/output/evidence_decay_predictions.csv"))
cat("\nML Refinement Complete.\n")