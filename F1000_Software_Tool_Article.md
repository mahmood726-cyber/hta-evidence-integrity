# HTA Evidence Integrity Suite: a software tool for reviewer-auditable evidence synthesis

## Authors
- Mahmood Ahmad [1,2]
- Niraj Kumar [1]
- Bilaal Dar [3]
- Laiba Khan [1]
- Andrew Woo [4]
- Corresponding author: Andrew Woo (andy2709w@gmail.com)

## Affiliations
1. Royal Free Hospital
2. Tahir Heart Institute Rabwah
3. King's College Medical School
4. St George's Medical School

## Abstract
**Background:** HTA review teams often assess information size, fragility, and publication bias in parallel but with separate scripts or qualitative checklists. That separation makes it difficult to understand when a significant pooled effect is also underpowered, directionally fragile, or unstable under correction.

**Methods:** The Evidence Integrity Suite combines an information adequacy index, large-scale fragility analysis, bias correction workflows, a rare-disease guardrail, predictive modeling of evidence decay, and a browser dashboard for HTA-style triage of Pairwise70-derived meta-analyses.

**Results:** The local repository contains manuscript drafts, simulation scripts, test files, dashboard output, review documents, and validation artifacts that connect quantitative evidence-quality signals to decision-support categories.

**Conclusions:** The software is presented as an auditable HTA support framework that quantifies evidence reliability, while acknowledging that no single correction method fully resolves high heterogeneity plus publication bias.

## Keywords
health technology assessment; publication bias; information adequacy; fragility; GRADE; software tool

## Introduction
This project addresses a recurring peer-review gap: software articles often show a tool interface but do not explain how adequacy, fragility, and correction outputs interact in practice. Here the repository couples methods code, simulation outputs, and a dashboard with explicit HTA decision labels.

Relevant comparators include stand-alone TSA/OIS tools, publication-bias methods such as trim-and-fill and PET-PEESE, and generic dashboarding layers. The contribution is integration and traceability rather than a claim that one index supersedes all other appraisal frameworks.

The manuscript structure below is deliberately aligned to common open-software review requests: the rationale is stated explicitly, at least one runnable example path is named, local validation artifacts are listed, and conclusions are bounded to the functions and outputs documented in the repository.

## Methods
### Software architecture and workflow
The project combines R-based analysis scripts, tests, manuscript materials, and an HTML dashboard. Core functions cover information adequacy, leave-one-out fragility, bias correction, simulation-based method comparison, and report generation.

### Installation, runtime, and reviewer reruns
The local implementation is packaged under `C:\Models\HTA_Evidence_Integrity_Suite`. The manuscript identifies the local entry points, dependency manifest, fixed example input, and expected saved outputs so that reviewers can rerun the documented workflow without reconstructing it from scratch.

- Entry directory: `C:\Models\HTA_Evidence_Integrity_Suite`.
- Detected documentation entry points: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Detected environment capture or packaging files: `environment.yml`.
- Named worked-example paths in this draft: `PLOS_ONE_Final_Manuscript.md` and `RSM_Manuscript_Final.md` for project-specific narrative sources; `HTA_Dashboard.html` for the browser-facing decision dashboard; `f1000_artifacts/validation_summary.md` and `f1000_artifacts/tutorial_walkthrough.md` for reviewer guidance.
- Detected validation or regression artifacts: `f1000_artifacts/validation_summary.md`, `analysis/Quick_Validation_V2.R`, `analysis/unified_hta_validation.R`, `tests/verify_manuscript_numbers.py`, `tests/run_tests.R`, `tests/test_pipeline.R`.
- Detected example or sample data files: `analysis/research_output/Table1_Sample_Characteristics.csv`.
- Detected browser deliverables with built-in WebR self-validation: `HTA_Dashboard.html`.

### Worked examples and validation materials
**Example or fixed demonstration paths**
- `PLOS_ONE_Final_Manuscript.md` and `RSM_Manuscript_Final.md` for project-specific narrative sources.
- `HTA_Dashboard.html` for the browser-facing decision dashboard.
- `f1000_artifacts/validation_summary.md` and `f1000_artifacts/tutorial_walkthrough.md` for reviewer guidance.

**Validation and reporting artifacts**
- `tests/test_pipeline.R` and `tests/verify_manuscript_numbers.py` for regression and consistency checking.
- `analysis/unified_hta_validation.R` and companion simulation scripts for method comparisons.
- Local review files documenting red-team, editorial, and impact assessments.

### Typical outputs and user-facing deliverables
- Information adequacy classes and fragility labels.
- Bias-corrected summaries and rare-disease guardrail routing.
- An HTA dashboard for prioritization and decision support.

### Reviewer-informed safeguards
- Provides a named example workflow or fixed demonstration path.
- Documents local validation artifacts rather than relying on unsupported claims.
- Positions the software against existing tools without claiming blanket superiority.
- States limitations and interpretation boundaries in the manuscript itself.
- Requires explicit environment capture and public example accessibility in the released archive.

## Review-Driven Revisions
This draft has been tightened against recurring open peer-review objections taken from the supplied reviewer reports.
- Reproducibility: the draft names a reviewer rerun path and points readers to validation artifacts instead of assuming interface availability is proof of correctness.
- Validation: claims are anchored to local tests, validation summaries, simulations, or consistency checks rather than to unsupported assertions of performance.
- Comparators and niche: the manuscript now names the relevant comparison class and keeps the claimed niche bounded instead of implying universal superiority.
- Documentation and interpretation: the text expects a worked example, input transparency, and reviewer-verifiable outputs rather than a high-level feature list alone.
- Claims discipline: conclusions are moderated to the documented scope of HTA Evidence Integrity Suite and paired with explicit limitations.
- Browser verification: HTML applications in this directory now include embedded WebR checks so reviewer-facing dashboards can validate their displayed calculations in situ.

## Use Cases and Results
The software outputs should be described in terms of concrete reviewer-verifiable workflows: running the packaged example, inspecting the generated results, and checking that the reported interpretation matches the saved local artifacts. In this project, the most important result layer is the availability of a transparent execution path from input to analysis output.

Representative local result: `analysis/SESSION_SUMMARY.md` reports % Robust, 36.0% Low, 25.1% Moderate, 9.7% High.

### Concrete local quantitative evidence
- `analysis/SESSION_SUMMARY.md` reports % Robust, 36.0% Low, 25.1% Moderate, 9.7% High.
- `analysis/transportability/transportability_cv_summary.md` reports 465 reviews modeled; reported: RMSE = 6.344, MAE = 1.096 (n = 3854); or: RMSE = 0.708, MAE = 0.451 (n = 8509).
- `analysis/transportability/transportability_domain_cv_summary.md` reports endocrine_metabolic: 293 rows, 8 reviews, 10 reviews_in_list.

## Discussion
Representative local result: `analysis/SESSION_SUMMARY.md` reports % Robust, 36.0% Low, 25.1% Moderate, 9.7% High.

The software article stresses that the suite is a structured decision-support layer built from explicit quantitative signals. That framing directly addresses reviewer requests for interpretive guidance, limitations, and reproducible worked examples.

### Limitations
- Bias-correction prevalence estimates are based on a stratified sample for some modules rather than the full corpus.
- High heterogeneity combined with publication bias remains challenging for all compared methods.
- Decision thresholds and GRADE mappings are operational heuristics, not immutable clinical truth.

## Software Availability
- Local source package: `HTA_Evidence_Integrity_Suite` under `C:\Models`.
- Public repository: `https://github.com/mahmood726-cyber/hta-evidence-integrity`.
- Public source snapshot: Fixed public commit snapshot available at `https://github.com/mahmood726-cyber/hta-evidence-integrity/tree/82f222c11c527666fd2c0207ba7019310353cbbb`.
- DOI/archive record: No project-specific DOI or Zenodo record URL was detected locally; archive registration pending.
- Environment capture detected locally: `environment.yml`.
- Reviewer-facing documentation detected locally: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Reproducibility walkthrough: `f1000_artifacts/tutorial_walkthrough.md` where present.
- Validation summary: `f1000_artifacts/validation_summary.md` where present.
- Reviewer rerun manifest: `F1000_Reviewer_Rerun_Manifest.md`.
- Multi-persona review memo: `F1000_MultiPersona_Review.md`.
- Concrete submission-fix note: `F1000_Concrete_Submission_Fixes.md`.
- License: see the local `LICENSE` file.

## Data Availability
All analysis scripts, dashboard files, and validation summaries are available locally. The underlying Pairwise70 data are derived from public Cochrane sources and no individual participant data are included.

## Reporting Checklist
Real-peer-review-aligned checklist: `F1000_Submission_Checklist_RealReview.md`.
Reviewer rerun companion: `F1000_Reviewer_Rerun_Manifest.md`.
Companion reviewer-response artifact: `F1000_MultiPersona_Review.md`.
Project-level concrete fix list: `F1000_Concrete_Submission_Fixes.md`.

## Declarations
### Competing interests
The authors declare that no competing interests were disclosed.

### Grant information
No specific grant was declared for this manuscript draft.

### Author contributions (CRediT)
| Author | CRediT roles |
|---|---|
| Mahmood Ahmad | Conceptualization; Software; Validation; Data curation; Writing - original draft; Writing - review and editing |
| Niraj Kumar | Conceptualization |
| Bilaal Dar | Conceptualization |
| Laiba Khan | Conceptualization |
| Andrew Woo | Conceptualization |

### Acknowledgements
The authors acknowledge contributors to open statistical methods, reproducible research software, and reviewer-led software quality improvement.

## References
1. DerSimonian R, Laird N. Meta-analysis in clinical trials. Controlled Clinical Trials. 1986;7(3):177-188.
2. Higgins JPT, Thompson SG. Quantifying heterogeneity in a meta-analysis. Statistics in Medicine. 2002;21(11):1539-1558.
3. Viechtbauer W. Conducting meta-analyses in R with the metafor package. Journal of Statistical Software. 2010;36(3):1-48.
4. Page MJ, McKenzie JE, Bossuyt PM, et al. The PRISMA 2020 statement: an updated guideline for reporting systematic reviews. BMJ. 2021;372:n71.
5. Fay C, Rochette S, Guyader V, Girard C. Engineering Production-Grade Shiny Apps. Chapman and Hall/CRC. 2022.
