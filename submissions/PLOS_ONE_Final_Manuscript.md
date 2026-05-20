# RESEARCH ARTICLE

## The Evidence Integrity Suite: A Systematic Open-Source Framework for Assessing Information Adequacy, Fragility, and Publication Bias in Health Technology Assessment

**Authors:** Mahmood Ul Hassan (Independent Researcher)
**Correspondence:** Mahmood Ul Hassan (Independent Researcher)
**ORCID:** [To be added]

---

### Abstract

**Background:** Health Technology Assessment (HTA) bodies rely on meta-analyses to determine the clinical and economic value of medical interventions. However, the reliability of these assessments is frequently compromised by publication bias, insufficient information size, and fragile evidence that may not survive the addition of future studies.

**Methods:** We developed the Evidence Integrity Suite, an automated methodological pipeline, and applied it to the Pairwise70 Cochrane dataset (501 systematic reviews). The suite integrates three complementary engines: (1) an Information Adequacy Index (IAI) computed across 492 meta-analyses using heterogeneity-adjusted Optimal Information Size (OIS); (2) a fragility analysis of 4,424 meta-analyses from 474 reviews, quantifying directional and significance stability; and (3) a dual-pronged bias correction framework (Trim-and-Fill and PET-PEESE) applied to a stratified sample of 44 reviews with a Rare Disease Guardrail ($N < 250$). We further trained a logistic regression model to predict evidence decay risk using 10-fold cross-validation.

**Results:** Of 492 meta-analyses assessed for information adequacy, only 36.4% (n=179) met "Adequate" criteria; 24.4% (n=120) were "Marginal," 36.0% (n=177) were "Inadequate," and 3.3% (n=16) were "Critical." Among 4,424 fragility analyses using a composite leave-one-out index, 44.0% (n=1,947) were classified as Robust, 38.4% (n=1,701) as Low Fragility, 14.2% (n=628) as Moderate Fragility, and 0.9% (n=40) as High Fragility; 26.1% exhibited directional fragility. Bias correction identified sign reversals (discordant direction) in 29.5% (13/44) of the sampled reviews. The evidence decay prediction model achieved a 10-fold cross-validated AUC of 0.688 (SD = 0.023). Simulation studies across 8 scenarios and 7 meta-analytic methods (B = 1,000 each) confirmed that the Hartung-Knapp-Sidik-Jonkman (HKSJ) method achieved the best coverage (89.0% overall; 95.0% under no-bias conditions), while all methods severely undercovered under high heterogeneity with publication bias (49.2%--59.7%).

**Conclusion:** The Evidence Integrity Suite provides a reproducible, multi-layered framework for HTA. The finding that only 36.4% of meta-analyses have adequate information, combined with 26.1% exhibiting directional fragility and 29.5% showing directional instability under bias correction, underscores the urgency of incorporating information adequacy metrics into HTA decision-making.

---

### 1. Introduction

The integrity of evidence synthesis is the cornerstone of modern evidence-based medicine. Yet, Health Technology Assessment (HTA) continues to struggle with the "Reproducibility Crisis." A significant portion of published meta-analyses are either skewed by the omission of null results (Publication Bias), are "Premature" --- showing statistical significance before sufficient sample size (Optimal Information Size) has been reached --- or are fragile, meaning their conclusions would change with the addition or removal of a single study.

Current HTA protocols often treat bias detection, power analysis, and fragility as separate, qualitative checklists [7]. This study introduces a unified, open-source methodological suite that quantifies these risks into actionable classifications. By providing a bias-corrected, information-adjusted, and fragility-aware view of evidence, we aim to prevent the adoption of medical technologies based on unreliable findings [8,9].

---

### 2. Materials and Methods

#### 2.1 The Pairwise70 Dataset

We utilized the Pairwise70 dataset, containing systematically extracted pairwise meta-analysis data from 501 Cochrane systematic reviews covering 17 clinical domains. The dataset encompasses approximately 43,000 individual studies across 5,088 unique meta-analyses.

#### 2.2 Information Adequacy Index (IAI)

We computed the IAI for 492 meta-analyses with complete data. The Optimal Information Size (OIS) was calculated using a dynamic diversity factor to account for between-study heterogeneity ($I^2$), following the trial sequential analysis framework [4]:

$$OIS_{adjusted} = OIS_{base} \times \frac{1}{1 - I^2}$$

The Information Fraction was defined as $IF = N_{actual} / OIS_{adjusted}$. The IAI combines heterogeneity-adjusted power, z-score stability, and sequential monitoring status into a composite index (range 0--1), classified as:
- **Adequate** ($IAI \geq 0.7$): Sufficient information for reliable conclusions.
- **Marginal** ($0.5 \leq IAI < 0.7$): Borderline; conclusions should be interpreted cautiously.
- **Inadequate** ($0.3 \leq IAI < 0.5$): Insufficient information; further studies needed.
- **Critical** ($IAI < 0.3$): Severely underpowered; conclusions unreliable.

Classifications were mapped to GRADE certainty levels [5] (Adequate = HIGH, Marginal = MODERATE, Inadequate = LOW, Critical = VERY LOW).

#### 2.3 Fragility Analysis

We assessed the fragility of 4,424 meta-analyses from 474 Cochrane reviews (median $k$ = 9, range 3--494). For each analysis, leave-one-out analysis was performed to evaluate three dimensions of fragility:
- **Directional fragility**: Whether removing any single study reverses the direction of the pooled effect.
- **Significance fragility**: Whether removing any single study changes the statistical significance ($p < 0.05$ threshold).
- **Clinical fragility**: Whether removing any single study changes the clinical interpretation.

A composite fragility index (0--3) was computed from these three dimensions:
- **Robust** (composite = 0): No fragility on any dimension.
- **Low Fragility** (composite = 1): Fragile on one dimension.
- **Moderate Fragility** (composite = 2): Fragile on two dimensions.
- **High Fragility** (composite = 3): Fragile on all three dimensions.

#### 2.4 Dual-Pronged Bias Correction

The pipeline employs two distinct bias models on a diverse sample of 44 reviews, selected by stratifying across clinical domains and outcome types (binary/continuous), with one primary analysis per review (largest subgroup, capped at 50 reviews; 44 yielded valid results):
1. **Trim-and-Fill (R0):** A non-parametric method to estimate missing studies and adjust the pooled estimate [2].
2. **PET-PEESE:** A regression-based approach modeling the relationship between effect sizes and their standard errors (PET) or variances (PEESE) to identify and correct for small-study effects [3].

Analyses where the corrected estimate changed the sign of the effect size were flagged as **"Discordant" (Sign Reversal).**

#### 2.5 The Rare Disease Guardrail

Recognizing that strict OIS requirements could unfairly penalize orphan drug development, we implemented an ethical exception. Meta-analyses with a total sample size ($N$) less than 250 are routed to a "Qualitative Assessment" track and bypass the strict OIS penalty.

#### 2.6 Predictive Modeling of Evidence Decay

We developed a logistic regression model to predict the probability of "evidence decay," defined as a currently significant finding ($p < 0.05$) losing its significance upon reaching full information size (i.e., the pooled estimate's $p$-value crossing the 0.05 threshold when projected to OIS). Predictors included log($k$), observed $I^2$, $\tau^2$, the absolute effect size, and significance status. Model performance was assessed using 10-fold cross-validation at both analysis and review levels [10].

#### 2.7 Simulation Study

To evaluate meta-analytic method performance under controlled conditions, we conducted a simulation study (B = 1,000 replications) across 8 scenarios: Low/High heterogeneity $\times$ No bias/Publication bias, Small meta-analysis ($k = 5$), Large meta-analysis ($k = 30$), Null effect, and Outlier present. Seven methods were compared: Empirical Meta-Analysis (EMA), Restricted Maximum Likelihood (REML), Hartung-Knapp-Sidik-Jonkman (HKSJ) [6], Adaptive Robust Pooling (ARP), Uncertainty-Bounded Small-sample Fix (UBSF), Modified Weighted Mean (MWM), and Sequential Integration Technique (SIT).

---

### 3. Results

#### 3.1 Information Adequacy Landscape

Of 492 meta-analyses with complete data (median $k$ = 71, range 2--3,665; median total $N$ = 11,762; mean $I^2$ = 31.7%):

| IAI Class | n | % |
|:----------|--:|--:|
| Adequate | 179 | 36.4% |
| Marginal | 120 | 24.4% |
| Inadequate | 177 | 36.0% |
| Critical | 16 | 3.3% |

The mean IAI was 0.616 (median 0.554), indicating that a typical Cochrane meta-analysis falls in the Marginal-to-Inadequate range. The mean information fraction was 4.76 (median 1.48), with 45.1% (n=222) of analyses achieving statistical significance.

Sequential monitoring status revealed: 16.7% conclusive benefit, 22.6% conclusive harm, 40.4% continue (information boundary not crossed), 11.0% futile, and 9.3% unknown.

#### 3.2 Fragility Analysis

Across 4,424 meta-analyses from 474 Cochrane reviews (of which 1,072 [24.2%] were statistically significant):

| Composite Fragility | n | % |
|:---------------------|--:|--:|
| Robust (0) | 1,947 | 44.0% |
| Low Fragility (1) | 1,701 | 38.4% |
| Moderate Fragility (2) | 628 | 14.2% |
| High Fragility (3) | 40 | 0.9% |

By individual dimension: 26.1% (n=1,154) exhibited directional fragility, 14.6% (n=648) significance fragility, and 28.8% (n=1,275) clinical fragility. A total of 34.6% (n=1,532) had near-null effects where directional instability is expected.

Prediction models for directional fragility achieved AUC = 0.837; for significance fragility, AUC = 0.773. The number of studies required for less than 10% directional fragility was $k \geq 25$; for significance fragility, $k \geq 35$.

#### 3.3 Bias Correction and Directional Instability

In the stratified sample of 44 reviews (median $k$ = 13.5, range 3--494):

| GRADE Certainty | n | % |
|:----------------|--:|--:|
| VERY LOW | 27 | 61.4% |
| LOW (Imprecision) | 16 | 36.4% |
| MODERATE (Bias) | 1 | 2.3% |

PET-PEESE detected publication bias in 3 of 44 reviews (6.8%). However, sign reversals (discordant direction between original and bias-corrected estimates) occurred in 13 of 44 reviews (29.5%), indicating that even where formal bias tests are non-significant, directional instability is prevalent.

The Rare Disease Guardrail was triggered for 3 of 44 reviews (6.8%), protecting small-population interventions from inappropriate penalization.

#### 3.4 Evidence Decay Prediction

The logistic regression model coefficients (Table 1) reveal that larger meta-analyses (log $k$: OR = 0.53, $p < 0.001$) and larger absolute effects (OR = 0.25, $p < 0.001$) are protective against decay, while higher heterogeneity ($I^2$: OR = 1.02, $p < 0.001$; $\tau^2$: OR = 1.05, $p = 0.001$) increases decay risk.

**Table 1. Evidence Decay Model Coefficients**

| Variable | Coefficient | Odds Ratio | $p$-value |
|:---------|:------------|:-----------|:----------|
| Intercept | 1.150 | 3.16 | $< 0.001$ |
| log($k$) | $-0.631$ | 0.53 | $< 0.001$ |
| $I^2$ | 0.019 | 1.02 | $< 0.001$ |
| $\tau^2$ | 0.045 | 1.05 | 0.001 |
| |Effect| | $-1.389$ | 0.25 | $< 0.001$ |
| Significant | 0.064 | 1.07 | 0.545 |

10-fold cross-validated AUC: **0.688** (SD = 0.023, range 0.651--0.729). Review-level cross-validation: AUC = 0.687 (SD = 0.034).

Among 147 analyses classified as "Premature" (significant but underpowered), the model assigned high decay probability ($> 0.5$) to 71.4% (n=105) and very high decay probability ($> 0.9$) to 61.9% (n=91).

#### 3.5 Simulation Results

Across 8 scenarios (B = 1,000), the HKSJ method achieved the highest overall coverage at 89.0%, outperforming REML (85.0%) and EMA (86.4%). Key findings:

**Table 2. Coverage by Scenario (Selected Methods)**

| Scenario | HKSJ | REML | EMA |
|:---------|:-----|:-----|:----|
| Low Het, No Bias | 95.0% | 93.1% | 94.3% |
| High Het, No Bias | 95.1% | 91.1% | 92.4% |
| Low Het, Pub Bias | 85.0% | 81.8% | 83.9% |
| High Het, Pub Bias | 59.7% | 50.3% | 51.2% |
| Small MA ($k=5$) | 93.0% | 87.6% | 88.8% |
| Large MA ($k=30$) | 94.8% | 94.2% | 94.5% |
| Null Effect | 94.6% | 91.3% | 95.0% |
| Outlier Present | 94.9% | 90.5% | 91.1% |

Under no-bias conditions, HKSJ achieves nominal 95% coverage. However, all seven methods severely undercover when both high heterogeneity and publication bias are present (range across all methods: 49.2% [SIT] to 59.7% [HKSJ]), highlighting an unresolved challenge in evidence synthesis.

---

### 4. Discussion

#### 4.1 The Information Adequacy Crisis

The finding that only 36.4% of assessed Cochrane meta-analyses have adequate information is concerning. Combined with the observation that 40.4% of analyses have not crossed their sequential monitoring boundary (i.e., more data is needed), this suggests that a substantial proportion of HTA decisions may be based on premature evidence.

#### 4.2 Fragility as a Complement to Heterogeneity

Traditional meta-analytic reporting focuses on heterogeneity ($I^2$, $\tau^2$), but our fragility analysis reveals a distinct dimension of evidence quality. Over one-quarter (26.1%) of meta-analyses exhibited directional fragility, meaning the conclusion could change direction with the removal of a single study. Only 44.0% were fully robust across all three fragility dimensions. The finding that $k \geq 25$ studies are needed for less than 10% directional fragility provides a practical threshold for HTA agencies.

#### 4.3 Directional Instability Under Bias Correction

The 29.5% sign reversal rate is substantially higher than anticipated and persists even when formal bias tests (PET-PEESE) are non-significant (bias detected in only 6.8%). This suggests that directional instability may be a more prevalent concern than traditionally recognized, and that absence of formal bias detection does not guarantee directional stability.

#### 4.4 The Rare Disease Guardrail

The ethical exception for small populations (triggered for 6.8% of reviews) prevents the framework from penalizing inherently constrained evidence bases. This ensures the suite functions as a tool for quality improvement rather than a barrier to innovation in neglected clinical areas.

#### 4.5 Method Recommendations

Our simulation results support the use of HKSJ as the default meta-analytic method [6], consistent with recent Cochrane guidance [1]. The severe undercoverage of all methods under combined high heterogeneity and publication bias (49.2%--59.7%) underscores that no statistical method can fully compensate for systematically biased evidence.

#### 4.6 Limitations

1. The bias correction analysis used a stratified sample of 44 reviews (not the full 501), limiting the precision of bias prevalence estimates.
2. The evidence decay model achieved moderate discriminative ability (AUC = 0.688), which may be insufficient for high-stakes individual predictions but is informative for population-level risk stratification.
3. The IAI assumes that heterogeneity-adjusted OIS is an appropriate information threshold; alternative formulations exist.
4. Fragility metrics are sensitive to the choice of leave-one-out vs. leave-$d$-out analysis.
5. Simulation scenarios, while diverse, cannot capture all real-world data-generating mechanisms.

#### 4.7 Policy Recommendations

HTA agencies should:
1. Adopt the Information Fraction as a standard metric alongside $p$-values and $I^2$.
2. Flag findings classified as "Premature" for Managed Access funding, contingent on further real-world evidence.
3. Report fragility indices to contextualize the robustness of pooled estimates.
4. Use HKSJ as the default meta-analytic method, with sensitivity analyses under alternative approaches.

---

### 5. Conclusion

The Evidence Integrity Suite is an open-source, multi-layered framework for assessing the reliability of meta-analytic evidence in HTA. By integrating information adequacy, fragility analysis, bias correction, and evidence decay prediction across 501 Cochrane reviews, the suite transforms meta-analysis from a static report into a dynamic, risk-adjusted decision support engine.

---

### Data Availability Statement

All analysis scripts, configuration files, and the interactive dashboard are available in the project repository. The underlying Pairwise70 dataset is derived from publicly available Cochrane systematic reviews.

### Author Contributions

**Conceptualization:** Mahmood Ul Hassan. **Methodology:** Mahmood Ul Hassan. **Software:** Mahmood Ul Hassan. **Validation:** Mahmood Ul Hassan. **Formal Analysis:** Mahmood Ul Hassan. **Writing -- Original Draft:** Mahmood Ul Hassan. **Writing -- Review & Editing:** Mahmood Ul Hassan.

### Funding

The author received no specific funding for this work.

### Competing Interests

The author declares no competing interests.

### Ethics Statement

This study used publicly available aggregate data from Cochrane systematic reviews and simulated datasets. No human participants were involved and no ethics approval was required.

### Keywords

Meta-analysis, health technology assessment, publication bias, information adequacy, fragility, evidence synthesis, simulation, GRADE

### References

1. Higgins JPT, Thomas J, Chandler J, et al. Cochrane Handbook for Systematic Reviews of Interventions. Version 6.4. Cochrane, 2023.
2. Duval S, Tweedie R. Trim and fill: A simple funnel-plot-based method of testing and adjusting for publication bias in meta-analysis. Biometrics. 2000;56(2):455-463.
3. Stanley TD, Doucouliagos H. Meta-regression approximations to reduce publication selection bias. Research Synthesis Methods. 2014;5(1):60-78.
4. Wetterslev J, Thorlund K, Brok J, Gluud C. Trial sequential analysis may establish when firm evidence is reached in cumulative meta-analysis. J Clin Epidemiol. 2008;61(1):64-75.
5. Guyatt GH, Oxman AD, Vist GE, et al. GRADE: an emerging consensus on rating quality of evidence and strength of recommendations. BMJ. 2008;336(7650):924-926.
6. IntHout J, Ioannidis JPA, Borm GF. The Hartung-Knapp-Sidik-Jonkman method for random effects meta-analysis is straightforward and considerably outperforms the standard DerSimonian-Laird method. BMC Med Res Methodol. 2014;14:25.
7. Ioannidis JPA. The Mass Production of Redundant, Misleading, and Conflicted Systematic Reviews and Meta-analyses. Milbank Q. 2016;94(3):485-514.
8. Borm GF, Donders AR. Updating meta-analyses leads to larger type I errors than publication bias. J Clin Epidemiol. 2009;62(8):825-830.
9. Imberger G, Thorlund K, Gluud C, Wetterslev J. False-positive findings in Cochrane meta-analyses with and without application of trial sequential analysis: an empirical review. BMJ Open. 2016;6:e011890.
10. Carter EC, Schonbrodt FD, Gervais WM, Hilgard J. Correcting for bias in psychology: A comparison of meta-analytic methods. Adv Methods Pract Psychol Sci. 2019;2(2):115-144.
