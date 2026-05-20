# HTA Evidence Integrity Suite: multi-persona peer review

This memo applies the recurring concerns in the supplied peer-review document to the current F1000 draft for this project (`HTA_Evidence_Integrity_Suite`). It distinguishes changes already made in the draft from repository-side items that still need to hold in the released repository and manuscript bundle.

## Detected Local Evidence
- Detected documentation files: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Detected environment capture or packaging files: `environment.yml`.
- Detected validation/test artifacts: `f1000_artifacts/validation_summary.md`, `analysis/Quick_Validation_V2.R`, `analysis/unified_hta_validation.R`, `tests/verify_manuscript_numbers.py`, `tests/run_tests.R`, `tests/test_pipeline.R`.
- Detected browser deliverables: `HTA_Dashboard.html`.
- Detected public repository root: `https://github.com/mahmood726-cyber/hta-evidence-integrity`.
- Detected public source snapshot: Fixed public commit snapshot available at `https://github.com/mahmood726-cyber/hta-evidence-integrity/tree/82f222c11c527666fd2c0207ba7019310353cbbb`.
- Detected public archive record: No project-specific DOI or Zenodo record URL was detected locally; archive registration pending.

## Reviewer Rerun Companion
- `F1000_Reviewer_Rerun_Manifest.md` consolidates the shortest reviewer-facing rerun path, named example files, environment capture, and validation checkpoints.

## Detected Quantitative Evidence
- `analysis/SESSION_SUMMARY.md` reports % Robust, 36.0% Low, 25.1% Moderate, 9.7% High.
- `analysis/transportability/transportability_cv_summary.md` reports 465 reviews modeled; reported: RMSE = 6.344, MAE = 1.096 (n = 3854); or: RMSE = 0.708, MAE = 0.451 (n = 8509).
- `analysis/transportability/transportability_domain_cv_summary.md` reports endocrine_metabolic: 293 rows, 8 reviews, 10 reviews_in_list.

## Current Draft Strengths
- States the project rationale and niche explicitly: HTA review teams often assess information size, fragility, and publication bias in parallel but with separate scripts or qualitative checklists. That separation makes it difficult to understand when a significant pooled effect is also underpowered, directionally fragile, or unstable under correction.
- Names concrete worked-example paths: `PLOS_ONE_Final_Manuscript.md` and `RSM_Manuscript_Final.md` for project-specific narrative sources; `HTA_Dashboard.html` for the browser-facing decision dashboard; `f1000_artifacts/validation_summary.md` and `f1000_artifacts/tutorial_walkthrough.md` for reviewer guidance.
- Points reviewers to local validation materials: `tests/test_pipeline.R` and `tests/verify_manuscript_numbers.py` for regression and consistency checking; `analysis/unified_hta_validation.R` and companion simulation scripts for method comparisons; Local review files documenting red-team, editorial, and impact assessments.
- Moderates conclusions and lists explicit limitations for HTA Evidence Integrity Suite.

## Remaining High-Priority Fixes
- Keep one minimal worked example public and ensure the manuscript paths match the released files.
- Ensure README/tutorial text, software availability metadata, and public runtime instructions stay synchronized with the manuscript.
- Confirm that the cited repository root resolves to the same fixed public source snapshot used for the submission package.
- Mint and cite a Zenodo DOI or record URL for the tagged release; none was detected locally.
- Reconfirm the quoted benchmark or validation sentence after the final rerun so the narrative text stays synchronized with the shipped artifacts.
- Keep the embedded WebR validation panel enabled in public HTML releases and rerun it after any UI or calculation changes.

## Persona Reviews

### Reproducibility Auditor
- Review question: Looks for a frozen computational environment, a fixed example input, and an end-to-end rerun path with saved outputs.
- What the revised draft now provides: The revised draft names concrete rerun assets such as `PLOS_ONE_Final_Manuscript.md` and `RSM_Manuscript_Final.md` for project-specific narrative sources; `HTA_Dashboard.html` for the browser-facing decision dashboard and ties them to validation files such as `tests/test_pipeline.R` and `tests/verify_manuscript_numbers.py` for regression and consistency checking; `analysis/unified_hta_validation.R` and companion simulation scripts for method comparisons.
- What still needs confirmation before submission: Before submission, freeze the public runtime with `environment.yml` and keep at least one minimal example input accessible in the external archive.

### Validation and Benchmarking Statistician
- Review question: Checks whether the paper shows evidence that outputs are accurate, reproducible, and compared against known references or stress tests.
- What the revised draft now provides: The manuscript now cites concrete validation evidence including `tests/test_pipeline.R` and `tests/verify_manuscript_numbers.py` for regression and consistency checking; `analysis/unified_hta_validation.R` and companion simulation scripts for method comparisons; Local review files documenting red-team, editorial, and impact assessments and frames conclusions as being supported by those materials rather than by interface availability alone.
- What still needs confirmation before submission: Concrete numeric evidence detected locally is now available for quotation: `analysis/SESSION_SUMMARY.md` reports % Robust, 36.0% Low, 25.1% Moderate, 9.7% High; `analysis/transportability/transportability_cv_summary.md` reports 465 reviews modeled; reported: RMSE = 6.344, MAE = 1.096 (n = 3854); or: RMSE = 0.708, MAE = 0.451 (n = 8509).

### Methods-Rigor Reviewer
- Review question: Examines modeling assumptions, scope conditions, and whether method-specific caveats are stated instead of implied.
- What the revised draft now provides: The architecture and discussion sections now state the method scope explicitly and keep caveats visible through limitations such as Bias-correction prevalence estimates are based on a stratified sample for some modules rather than the full corpus; High heterogeneity combined with publication bias remains challenging for all compared methods.
- What still needs confirmation before submission: Retain method-specific caveats in the final Results and Discussion and avoid collapsing exploratory thresholds or heuristics into universal recommendations.

### Comparator and Positioning Reviewer
- Review question: Asks what gap the tool fills relative to existing software and whether the manuscript avoids unsupported superiority claims.
- What the revised draft now provides: The introduction now positions the software against an explicit comparator class: Relevant comparators include stand-alone TSA/OIS tools, publication-bias methods such as trim-and-fill and PET-PEESE, and generic dashboarding layers. The contribution is integration and traceability rather than a claim that one index supersedes all other appraisal frameworks.
- What still needs confirmation before submission: Keep the comparator discussion citation-backed in the final submission and avoid phrasing that implies blanket superiority over better-established tools.

### Documentation and Usability Reviewer
- Review question: Looks for a README, tutorial, worked example, input-schema clarity, and short interpretation guidance for outputs.
- What the revised draft now provides: The revised draft points readers to concrete walkthrough materials such as `PLOS_ONE_Final_Manuscript.md` and `RSM_Manuscript_Final.md` for project-specific narrative sources; `HTA_Dashboard.html` for the browser-facing decision dashboard; `f1000_artifacts/validation_summary.md` and `f1000_artifacts/tutorial_walkthrough.md` for reviewer guidance and spells out expected outputs in the Methods section.
- What still needs confirmation before submission: Make sure the public archive exposes a readable README/tutorial bundle: currently detected files include `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.

### Software Engineering Hygiene Reviewer
- Review question: Checks for evidence of testing, deployment hygiene, browser/runtime verification, secret handling, and removal of obvious development leftovers.
- What the revised draft now provides: The draft now foregrounds regression and validation evidence via `f1000_artifacts/validation_summary.md`, `analysis/Quick_Validation_V2.R`, `analysis/unified_hta_validation.R`, `tests/verify_manuscript_numbers.py`, `tests/run_tests.R`, `tests/test_pipeline.R`, and browser-facing projects are described as self-validating where applicable.
- What still needs confirmation before submission: Before submission, remove any dead links, exposed secrets, or development-stage text from the public repo and ensure the runtime path described in the manuscript matches the shipped code.

### Claims-and-Limitations Editor
- Review question: Verifies that conclusions are bounded to what the repository actually demonstrates and that limitations are explicit.
- What the revised draft now provides: The abstract and discussion now moderate claims and pair them with explicit limitations, including Bias-correction prevalence estimates are based on a stratified sample for some modules rather than the full corpus; High heterogeneity combined with publication bias remains challenging for all compared methods; Decision thresholds and GRADE mappings are operational heuristics, not immutable clinical truth.
- What still needs confirmation before submission: Keep the conclusion tied to documented functions and artifacts only; avoid adding impact claims that are not directly backed by validation, benchmarking, or user-study evidence.

### F1000 and Editorial Compliance Reviewer
- Review question: Checks for manuscript completeness, software/data availability clarity, references, and reviewer-facing support files.
- What the revised draft now provides: The revised draft is more complete structurally and now points reviewers to software availability, data availability, and reviewer-facing support files.
- What still needs confirmation before submission: Confirm repository/archive metadata, figure/export requirements, and supporting-file synchronization before release.
