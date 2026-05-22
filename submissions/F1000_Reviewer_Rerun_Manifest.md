# HTA Evidence Integrity Suite: reviewer rerun manifest

This manifest is the shortest reviewer-facing rerun path for the local software package. It lists the files that should be sufficient to recreate one worked example, inspect saved outputs, and verify that the manuscript claims remain bounded to what the repository actually demonstrates.

## Reviewer Entry Points
- Project directory: `C:\Models\HTA_Evidence_Integrity_Suite`.
- Preferred documentation start points: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Detected public repository root: `https://github.com/mahmood726-cyber/hta-evidence-integrity`.
- Detected public source snapshot: Fixed public commit snapshot available at `https://github.com/mahmood726-cyber/hta-evidence-integrity/tree/82f222c11c527666fd2c0207ba7019310353cbbb`.
- Detected public archive record: No project-specific DOI or Zenodo record URL was detected locally; archive registration pending.
- Environment capture files: `environment.yml`.
- Validation/test artifacts: `f1000_artifacts/validation_summary.md`, `analysis/Quick_Validation_V2.R`, `analysis/unified_hta_validation.R`, `tests/verify_manuscript_numbers.py`, `tests/run_tests.R`, `tests/test_pipeline.R`.

## Worked Example Inputs
- Manuscript-named example paths: `PLOS_ONE_Final_Manuscript.md` and `RSM_Manuscript_Final.md` for project-specific narrative sources; `HTA_Dashboard.html` for the browser-facing decision dashboard; `f1000_artifacts/validation_summary.md` and `f1000_artifacts/tutorial_walkthrough.md` for reviewer guidance; analysis/research_output/Table1_Sample_Characteristics.csv.
- Auto-detected sample/example files: `analysis/research_output/Table1_Sample_Characteristics.csv`.

## Expected Outputs To Inspect
- Information adequacy classes and fragility labels.
- Bias-corrected summaries and rare-disease guardrail routing.
- An HTA dashboard for prioritization and decision support.

## Minimal Reviewer Rerun Sequence
- Start with the README/tutorial files listed below and keep the manuscript paths synchronized with the public archive.
- Create the local runtime from the detected environment capture files if available: `environment.yml`.
- Run at least one named example path from the manuscript and confirm that the generated outputs match the saved validation materials.
- Quote one concrete numeric result from the local validation snippets below when preparing the final software paper.
- Open the browser deliverable and confirm that the embedded WebR validation panel completes successfully after the page finishes initializing.

## Local Numeric Evidence Available
- `analysis/SESSION_SUMMARY.md` reports % Robust, 36.0% Low, 25.1% Moderate, 9.7% High.
- `analysis/transportability/transportability_cv_summary.md` reports 465 reviews modeled; reported: RMSE = 6.344, MAE = 1.096 (n = 3854); or: RMSE = 0.708, MAE = 0.451 (n = 8509).
- `analysis/transportability/transportability_domain_cv_summary.md` reports endocrine_metabolic: 293 rows, 8 reviews, 10 reviews_in_list.

## Browser Deliverables
- HTML entry points: `HTA_Dashboard.html`.
- The shipped HTML applications include embedded WebR self-validation and should be checked after any UI or calculation change.
