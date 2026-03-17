# Final "Red Team" Audit: HTA Evidence Integrity Suite
**Context:** Pre-Deployment Regulatory Audit
**Date:** February 14, 2026
**Reviewers:** Regulatory Statistician, Lead Software Architect, UX/Decision Scientist

---

## 1. Reviewer A: The Regulatory Statistician (FDA/EMA Perspective)
**Focus:** Safety, Conservatism, and "Worst Case" Scenarios

### 🚨 Critical Findings
*   **The "PET-PEESE" Trap:** Your script applies PET-PEESE estimates even when they flip the direction of the effect (e.g., from Beneficial to Harmful). While mathematically correct for bias, in a regulatory context, a sign reversal should trigger a **"Critical Warning"**, not just a new number. We cannot simply accept a corrected estimate that says "actually, the drug kills people" without a massive red flag.
*   **OIS "Explosion":** Your Dynamic Diversity Factor ($1/(1-I^2)$) is theoretically perfect but practically dangerous. At $I^2 = 95\%$, the OIS becomes $20 	imes$ the original. This makes *everything* look premature. You need to report the **"Heterogeneity Penalty"** explicitly so decision-makers know *why* the evidence is rated Low.

### 🛠️ Required Fix
1.  **Flag Sign Reversals:** If the bias-corrected estimate has a different sign than the original, label it **"DISCORDANT"**.
2.  **Separate Penalties:** Calculate and display the `OIS_Base` (Fixed Effect) and `OIS_Adjusted` separately.

---

## 2. Reviewer B: The Lead Software Architect
**Focus:** Portability and Robustness

### 🚨 Critical Findings
*   **Hardcoded Paths:** The scripts still point to `C:/Users/user/...`. This works on *your* machine. It will fail on the CI/CD pipeline or another researcher's laptop.
*   **Output Overwrite Risk:** The scripts overwrite the CSVs silently. In a production audit trail, we need versioning or a "Run Log."

### 🛠️ Required Fix
1.  **Relative Paths:** Refactor all scripts to use relative paths (e.g., `./analysis/output`) derived from the working directory.
2.  **Logging:** Add a simple timestamped log file generation.

---

## 3. Reviewer C: The UX & Decision Scientist
**Focus:** Dashboard Usability

### 🚨 Critical Findings
*   **Information Overload:** The Dashboard is getting crowded. The "Decay Probability" is a complex decimal. Decision-makers prefer categories.
*   **Missing Context:** I see `CD001234`. I don't know if that's Cardiology or Psychiatry.

### 🛠️ Required Fix
1.  **Risk Bins:** Convert Decay Probability to "Low/Med/High" tags in the UI.
2.  **Heterogeneity Visual:** Add a visual indicator for the "Heterogeneity Penalty" (e.g., a bar showing how much larger the sample size needs to be due to $I^2$).

---

## 🏁 Executive Order: "Fix All" Plan

1.  **Update `bias_correction_pipeline.R`**: Add "Discordant" checks for sign reversals.
2.  **Update `unified_hta_validation.R`**: Calculate "Heterogeneity Penalty" multiplier explicitly. Refactor paths to be relative.
3.  **Update `HTA_Dashboard.html`**: Visualize the Heterogeneity Penalty and simplify Risk display.

**Status:** **CONDITIONAL HOLD**. Proceed with fixes immediately.
