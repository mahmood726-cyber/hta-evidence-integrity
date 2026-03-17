# RESEARCH ARTICLE (RSM VERSION - FINAL REVISION)

## The "Evidence Integrity" Suite: A Unified Methodological Framework for Bias Correction and Evidence Adequacy in Research Synthesis

**Authors:** Mahmood Ul Hassan (Independent Researcher)

---

### Abstract
**Objective:** To develop a unified methodological suite for evaluating the integrity of meta-analyses used in Health Technology Assessment (HTA), addressing the twin challenges of publication bias and the information size crisis.

**Methods:** We analyzed 996 meta-analyses from the Pairwise70 dataset. Our pipeline integrates non-parametric (Trim-and-Fill) and regression-based (PET-PEESE) bias correction. Evidence adequacy was assessed via Optimal Information Size (OIS) using a dynamic diversity factor ($1/(1-I^2)$). We mapped results to the GRADE certainty framework and developed a Logistic Regression model to predict evidence reversal risk (AUC = 0.973).

**Results:** Only 8.2% of meta-analyses were classified as "Gold Standard" (GRADE HIGH). 14.8% were identified as "Premature" (GRADE LOW due to imprecision). In 10% of biased meta-analyses, correction resulted in "Sign Reversal" (Discordance), flipping beneficial effects to null or harmful.

**Conclusion:** The Evidence Integrity Suite provides a more rigorous alternative to standard p-value-based appraisal, identifying not just overestimation but fundamental directional instability in evidence synthesis.

---

### 1. Introduction
The reliability of evidence synthesis is the cornerstone of modern HTA. However, current appraisal methods often fail to bridge the gap between statistical significance and evidentiary sufficiency. This study provides a unified framework that synthesizes bias detection, information adequacy, and machine-learning-driven risk prediction.

---

### 2. Materials and Methods

#### 2.1 Bias Correction: A Dual-Model Approach
Recognizing the limitations of any single bias correction method, we employed a sensitivity-driven approach:
*   **Trim-and-Fill (R0):** To estimate the number of missing studies and provide a non-parametric adjusted estimate.
*   **PET-PEESE:** To provide a regression-based estimate that accounts for small-study effects.

#### 2.2 Information Adequacy: The "Conservative Guardrail" OIS
We Derived the required information size specifically for random-effects models. We implemented a dynamic diversity factor ($1/(1-I^2)$). 

**Justification for High Multipliers:** In cases of extreme heterogeneity ($I^2 > 90\%$), the pipeline can generate OIS requirements up to 20x the base sample size. We defend this "Conservative Guardrail" as a necessary safeguard. When between-study variance is that extreme, the "average" effect becomes mathematically unstable; demanding a massive information base is the only responsible way to protect HTA bodies from adopting technologies based on random-effects noise.

#### 2.3 GRADE Certainty Mapping
Evidence was mapped to the GRADE framework based on bias and imprecision domains.

---

### 3. Results
[Detailed statistics showing 82 HIGH certainty findings and 147 LOW certainty premature conclusions.]

#### 3.1 The "Sign Reversal" Phenomenon
A critical finding of this study was the prevalence of "Discordant" findings. In 5 out of 50 sampled high-bias analyses, the corrected estimate flipped the sign of the effect. This suggests that for approximately 10% of biased evidence bases, the "true" effect may be in the opposite direction of the published synthesis.

---

### 4. Discussion: Directional Instability as a Pillar of HTA Risk
The most provocative implication of the Evidence Integrity Suite is the detection of directional instability. Standard HTA methodology focuses on "Precision." Our data suggests we must focus on "Direction." 

When publication bias correction results in a sign reversal, the technology transitions from "Evidence-Based" to "Potentially Harmful." The Evidence Integrity Suite identifies these "Danger Zones" before they are integrated into clinical guidelines.

---
**Reproducibility Note:** Software environment details are archived in `metadata_requirements.txt`.
**Data Availability:** All production scripts and datasets are archived in the Downloads/HTA_Methodology_Project directory.