# Pairwise70 (development version)

## 2.0.0

### Breaking changes

- The package now exports only the six pooling estimators that actually have
  source in `R/`: `mafi_weighted_ma()`, `adaptive_robust_pooling()`,
  `sequential_influence_trimming()`, `unified_bias_stability()`,
  `ensemble_meta_analysis()`, and `compare_pooling_methods()` (with
  `compare_all_methods()` retained as a documented alias).
- The previously claimed but unimplemented exports — the V4 family
  (`wrd_meta`, `cbm_meta`, `rbm_meta`, `swa_meta`, `tas_meta`, `eve_meta`,
  `pvm_meta`, `aem_meta`, `spe_meta`, `sms_meta`, `compare_methods_v4`) and
  the GRMA family (`grma_meta`, `grma_loo`) — have been removed from the
  `NAMESPACE`. They were not present in the source tree.

### Package infrastructure

- Real `R/` directory containing one file per exported function, with
  roxygen-style docs and namespace-qualified imports.
- `License: MIT + file LICENSE` is now matched by a CRAN-format 2-line stub
  in `LICENSE`; the full MIT text moved to `LICENSE.md`.
- `clubSandwich` and `RoBMA` are declared as `Suggests` and accessed via
  `requireNamespace()`; both are optional.
- `testthat` edition 3, with tests covering every exported method on a
  self-contained synthetic dataset plus regression tests for the HTA
  evidence-integrity heuristics (OIS, GRADE mapping, evidence classification).
- Continuous integration via `.github/workflows/R-CMD-check.yaml` running
  `R CMD check --as-cran` on Ubuntu / macOS / Windows × R release +
  oldrel-1; `roxygen2::roxygenise()` is run as part of the workflow so
  `man/*.Rd` is generated from source.

### Bug fixes

- `sequential_influence_trimming()` now calls `stats::influence()` instead of
  trying to import `metafor::influence`, which is an S3 method and not an
  exported object.
