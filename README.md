# Pairwise70: Advanced Pooling Methods for Pairwise Meta-Analysis

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![R Version](https://img.shields.io/badge/R-%3E%3D%204.0.0-blue.svg)](https://www.r-project.org/)
[![R-CMD-check](https://github.com/mahmood726-cyber/hta-evidence-integrity/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mahmood726-cyber/hta-evidence-integrity/actions/workflows/R-CMD-check.yaml)

## Repository layout

This repository contains:

- **`R/`** — the `Pairwise70` R package source: six advanced pooling
  estimators (`mafi_weighted_ma`, `adaptive_robust_pooling`,
  `sequential_influence_trimming`, `unified_bias_stability`,
  `ensemble_meta_analysis`, `compare_pooling_methods`).
- **`tests/testthat/`** — `testthat` unit tests for the package and for the
  HTA evidence-integrity heuristics (OIS, GRADE mapping, evidence
  classification).
- **`analysis/`** — research scripts, simulation pipelines, and reports that
  produced the methods. Not part of the package build.
- **`submissions/`** — F1000, PLOS ONE, RSM and E156 manuscript drafts,
  reviews and audit notes. Not part of the package build.
- **`e156-submission/`**, **`f1000_artifacts/`**, **`docs/`** — venue-specific
  artefacts and the GitHub Pages site.

The companion **Pairwise70 dataset package** (501 Cochrane meta-analysis
datasets) lives at <https://github.com/mahmood789/Pairwise70>; the pooling
methods here were developed against it.

## Overview

**Pairwise70** (this repository) provides a small family of robust pooling
estimators developed against the Pairwise70 collection of Cochrane pairwise
meta-analyses, intended to complement standard random-effects meta-analysis
with stability-aware, influence-aware, and bias-corrected variants.

## Key features

- **Six advanced pooling estimators** that drop in next to `metafor::rma()` —
  MAFI-weighted pooling, adaptive robust pooling, sequential influence
  trimming, a unified bias-stability framework, an ensemble across all of the
  above, and a side-by-side comparison helper.
- **Stability-aware weighting** — studies whose removal would flip the sign or
  significance of the pooled estimate are downweighted relative to studies
  that only contribute precision.
- **Heterogeneity-driven model averaging** — REML, DerSimonian–Laird,
  Paule–Mandel and Hartung–Knapp–Sidik–Jonkman are combined with weights that
  shift as `I^2` increases and as `k` shrinks.
- **Influence trimming** — iterative Cook's-distance-based downweighting with
  convergence and full per-study weight trace.
- **Bias + stability** — Egger's regression, trim-and-fill, leave-one-out
  fragility and CI inflation reported in one call.
- **Tested cross-platform** — `R CMD check --as-cran` runs on Ubuntu /
  macOS / Windows × R release + oldrel-1 on every push.

## Installation

```r
# install.packages("remotes")
remotes::install_github("mahmood726-cyber/hta-evidence-integrity")
```

The companion **Pairwise70 dataset package** (the 501 Cochrane meta-analysis
datasets the methods were developed against) installs separately:

```r
remotes::install_github("mahmood789/Pairwise70")
```

## Quick start

```r
library(Pairwise70)
library(metafor)

# Example data: BCG vaccine trials
dat <- escalc(measure = "RR", ai = tpos, bi = tneg, ci = cpos, di = cneg,
              data = dat.bcg)

# Side-by-side: standard REML + every advanced method on this dataset
compare_pooling_methods(dat$yi, dat$vi)
#>                 Method Estimate     SE CI_Lower CI_Upper PValue
#> 1      REML (Standard)  -0.7144 0.1797  -1.0667  -0.3622 0.0001
#> 2                  HKSJ -0.7144 0.2380  -1.2331  -0.1958 0.0118
#> 3             RVE (CR2) -0.7144 0.1797  -1.0667  -0.3622 0.0001
#> 4   MWM (MAFI-Weighted) -0.6841 0.1842  -1.0451  -0.3231 0.0002
#> 5        ARP (Adaptive) -0.7144 0.1894  -1.0856  -0.3431 0.0002
#> 6  SIT (Influence Trim) -0.6997 0.1701  -1.0331  -0.3662 0.0000
#> 7 UBSF (Bias-Stability) -0.7141 0.1797  -1.0664  -0.3618 0.0001
#> 8        EMA (Ensemble) -0.7027 0.1820  -1.0594  -0.3461 0.0001
```

For a closer look at any one method:

```r
mwm <- mafi_weighted_ma(dat$yi, dat$vi)
mwm$study_stability_scores   # per-study fragility scores
mwm$adjustment               # shift relative to REML

ubsf <- unified_bias_stability(dat$yi, dat$vi)
ubsf$bias_detected           # Egger p < 0.10?
ubsf$direction_fragile       # does any leave-one-out flip the sign?
ubsf$se_inflation            # SE multiplier applied for that fragility
```

## Function reference

| Function | One-line summary |
| --- | --- |
| `mafi_weighted_ma()` | Convex combination of inverse-variance and leave-one-out stability weights. |
| `adaptive_robust_pooling()` | REML + DL + PM + HKSJ blend with weights that depend on `I^2` and `k`. |
| `sequential_influence_trimming()` | Iterative Cook's-distance downweighting until influence drops below threshold. |
| `unified_bias_stability()` | Trim-and-fill bias adjustment combined with a leave-one-out stability adjustment; CI inflated by detected fragility. |
| `ensemble_meta_analysis()` | Weighted ensemble across REML, MWM, ARP, SIT, UBSF (and optionally RVE, RoBMA). |
| `compare_pooling_methods()` | One-row-per-method comparison table for side-by-side reporting. |

See `?mafi_weighted_ma` etc. for full argument documentation.

## Repository contents beyond the package

- **`analysis/`** — the research scripts and simulation pipelines used to
  develop and validate the methods. Not part of the package build (listed in
  `.Rbuildignore`).
- **`submissions/`** — F1000, PLOS ONE, RSM and E156 manuscript drafts plus
  review/audit notes.
- **`e156-submission/`**, **`f1000_artifacts/`**, **`docs/`** — venue-specific
  artefacts and the GitHub Pages site.

## Contributing

Found a bug or want to add a method?

- [Open an issue](https://github.com/mahmood726-cyber/hta-evidence-integrity/issues)
- Submit a pull request — `R-CMD-check` runs automatically on every push.
- See `CONTRIBUTING.md` for development guidelines.

## License

MIT — see `LICENSE.md` for the full text and `LICENSE` for the CRAN-format
stub. The companion datasets are derived from Cochrane Reviews and remain
subject to their original licences.

## Citation

If you use these methods, please cite:

```
Arai M. (2026). Pairwise70: Advanced Pooling Methods for Pairwise
Meta-Analysis. R package version 2.0.0.
https://github.com/mahmood726-cyber/hta-evidence-integrity
```

`CITATION.cff` is provided for automatic citation tooling.

## Author

Mahmood Arai — mahmood726@gmail.com

## Acknowledgments

- **Cochrane Collaboration**, for maintaining the systematic review database
  that the methods were validated against.
- **The `metafor` developers**, on whose excellent foundation everything here
  rests.
