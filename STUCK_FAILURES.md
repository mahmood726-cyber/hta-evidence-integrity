# STUCK_FAILURES.md

*Written by Sentinel — BLOCK-tier violations.*

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/DOCUMENTATION_ADVANCED_POOLING_METHODS.md:277`
- **Detail:** pattern matched: devtools::load_all("C:/Users/user/OneDrive - NHS/Documents/Pairwise70")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-15T02:02:39.900605+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `config_paths.R:9`
- **Detail:** pattern matched: normalizePath("C:/Users/user/OneDrive - NHS/Documents/Pairwise70", mustWork = FALSE),
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-15T02:02:42.112107+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:27`
- **Detail:** pattern matched: mafi <- fread("C:/Users/user/OneDrive - NHS/Documents/Pairwise70/analysis/output/MAFI_all_variants.csv")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-15T02:02:46.135693+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:35`
- **Detail:** pattern matched: C:/Users/user/OneDrive - NHS/Documents/Pairwise70/MAFI-Calculator-Complete.html
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-15T02:02:46.135715+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:40`
- **Detail:** pattern matched: python C:/Users/user/mafi_functional_test.py
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-15T02:02:46.135725+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:84`
- **Detail:** pattern matched: | `C:/Users/user/mafi_selenium_test.py` | Basic Selenium test |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-15T02:02:46.135759+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:85`
- **Detail:** pattern matched: | `C:/Users/user/mafi_detailed_test.py` | Detailed test (older) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-15T02:02:46.135765+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:86`
- **Detail:** pattern matched: | `C:/Users/user/mafi_functional_test.py` | Comprehensive test (100% pass) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-15T02:02:46.135771+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `RED_TEAM_AUDIT.md:25`
- **Detail:** pattern matched: *   **Hardcoded Paths:** The scripts still point to `C:/Users/user/...`. This works on *your* machine. It will fail on t
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-15T02:02:50.089315+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `config_paths.R:9`
- **Detail:** pattern matched: normalizePath("C:/Users/user/OneDrive - NHS/Documents/Pairwise70", mustWork = FALSE),
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-17T02:04:07.677486+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:27`
- **Detail:** pattern matched: mafi <- fread("C:/Users/user/OneDrive - NHS/Documents/Pairwise70/analysis/output/MAFI_all_variants.csv")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-17T02:04:23.847601+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:35`
- **Detail:** pattern matched: C:/Users/user/OneDrive - NHS/Documents/Pairwise70/MAFI-Calculator-Complete.html
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-17T02:04:23.847621+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:40`
- **Detail:** pattern matched: python C:/Users/user/mafi_functional_test.py
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-17T02:04:23.847628+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:84`
- **Detail:** pattern matched: | `C:/Users/user/mafi_selenium_test.py` | Basic Selenium test |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-17T02:04:23.847688+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:85`
- **Detail:** pattern matched: | `C:/Users/user/mafi_detailed_test.py` | Detailed test (older) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-17T02:04:23.847693+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:86`
- **Detail:** pattern matched: | `C:/Users/user/mafi_functional_test.py` | Comprehensive test (100% pass) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-17T02:04:23.847697+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/DOCUMENTATION_ADVANCED_POOLING_METHODS.md:277`
- **Detail:** pattern matched: devtools::load_all("C:/Users/user/OneDrive - NHS/Documents/Pairwise70")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-17T02:04:27.006697+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `RED_TEAM_AUDIT.md:25`
- **Detail:** pattern matched: *   **Hardcoded Paths:** The scripts still point to `C:/Users/user/...`. This works on *your* machine. It will fail on t
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-17T02:04:33.414151+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `RED_TEAM_AUDIT.md:25`
- **Detail:** pattern matched: *   **Hardcoded Paths:** The scripts still point to `C:/Users/user/...`. This works on *your* machine. It will fail on t
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T02:04:11.262076+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/DOCUMENTATION_ADVANCED_POOLING_METHODS.md:277`
- **Detail:** pattern matched: devtools::load_all("C:/Users/user/OneDrive - NHS/Documents/Pairwise70")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T02:04:11.770725+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `config_paths.R:9`
- **Detail:** pattern matched: normalizePath("C:/Users/user/OneDrive - NHS/Documents/Pairwise70", mustWork = FALSE),
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T02:04:20.235306+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:27`
- **Detail:** pattern matched: mafi <- fread("C:/Users/user/OneDrive - NHS/Documents/Pairwise70/analysis/output/MAFI_all_variants.csv")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T02:04:34.632794+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:35`
- **Detail:** pattern matched: C:/Users/user/OneDrive - NHS/Documents/Pairwise70/MAFI-Calculator-Complete.html
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T02:04:34.632831+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:40`
- **Detail:** pattern matched: python C:/Users/user/mafi_functional_test.py
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T02:04:34.632848+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:84`
- **Detail:** pattern matched: | `C:/Users/user/mafi_selenium_test.py` | Basic Selenium test |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T02:04:34.633005+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:85`
- **Detail:** pattern matched: | `C:/Users/user/mafi_detailed_test.py` | Detailed test (older) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T02:04:34.633014+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:86`
- **Detail:** pattern matched: | `C:/Users/user/mafi_functional_test.py` | Comprehensive test (100% pass) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T02:04:34.633024+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `RED_TEAM_AUDIT.md:25`
- **Detail:** pattern matched: *   **Hardcoded Paths:** The scripts still point to `C:/Users/user/...`. This works on *your* machine. It will fail on t
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T20:11:47.782219+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/DOCUMENTATION_ADVANCED_POOLING_METHODS.md:277`
- **Detail:** pattern matched: devtools::load_all("C:/Users/user/OneDrive - NHS/Documents/Pairwise70")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T20:12:17.755245+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `config_paths.R:9`
- **Detail:** pattern matched: normalizePath("C:/Users/user/OneDrive - NHS/Documents/Pairwise70", mustWork = FALSE),
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T20:12:36.431196+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:27`
- **Detail:** pattern matched: mafi <- fread("C:/Users/user/OneDrive - NHS/Documents/Pairwise70/analysis/output/MAFI_all_variants.csv")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T20:12:42.794403+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:35`
- **Detail:** pattern matched: C:/Users/user/OneDrive - NHS/Documents/Pairwise70/MAFI-Calculator-Complete.html
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T20:12:42.794443+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:40`
- **Detail:** pattern matched: python C:/Users/user/mafi_functional_test.py
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T20:12:42.794457+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:84`
- **Detail:** pattern matched: | `C:/Users/user/mafi_selenium_test.py` | Basic Selenium test |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T20:12:42.794540+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:85`
- **Detail:** pattern matched: | `C:/Users/user/mafi_detailed_test.py` | Detailed test (older) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T20:12:42.794545+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:86`
- **Detail:** pattern matched: | `C:/Users/user/mafi_functional_test.py` | Comprehensive test (100% pass) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-19T20:12:42.794550+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `RED_TEAM_AUDIT.md:25`
- **Detail:** pattern matched: *   **Hardcoded Paths:** The scripts still point to `C:/Users/user/...`. This works on *your* machine. It will fail on t
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-20T02:03:05.545327+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `config_paths.R:9`
- **Detail:** pattern matched: normalizePath("C:/Users/user/OneDrive - NHS/Documents/Pairwise70", mustWork = FALSE),
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-20T02:03:09.096610+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/DOCUMENTATION_ADVANCED_POOLING_METHODS.md:277`
- **Detail:** pattern matched: devtools::load_all("C:/Users/user/OneDrive - NHS/Documents/Pairwise70")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-20T02:03:16.061908+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:27`
- **Detail:** pattern matched: mafi <- fread("C:/Users/user/OneDrive - NHS/Documents/Pairwise70/analysis/output/MAFI_all_variants.csv")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-20T02:03:25.620706+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:35`
- **Detail:** pattern matched: C:/Users/user/OneDrive - NHS/Documents/Pairwise70/MAFI-Calculator-Complete.html
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-20T02:03:25.620727+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:40`
- **Detail:** pattern matched: python C:/Users/user/mafi_functional_test.py
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-20T02:03:25.620736+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:84`
- **Detail:** pattern matched: | `C:/Users/user/mafi_selenium_test.py` | Basic Selenium test |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-20T02:03:25.620803+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:85`
- **Detail:** pattern matched: | `C:/Users/user/mafi_detailed_test.py` | Detailed test (older) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-20T02:03:25.620808+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:86`
- **Detail:** pattern matched: | `C:/Users/user/mafi_functional_test.py` | Comprehensive test (100% pass) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-20T02:03:25.620812+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/DOCUMENTATION_ADVANCED_POOLING_METHODS.md:277`
- **Detail:** pattern matched: devtools::load_all("C:/Users/user/OneDrive - NHS/Documents/Pairwise70")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-21T02:05:59.046388+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:27`
- **Detail:** pattern matched: mafi <- fread("C:/Users/user/OneDrive - NHS/Documents/Pairwise70/analysis/output/MAFI_all_variants.csv")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-21T02:06:02.134913+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:35`
- **Detail:** pattern matched: C:/Users/user/OneDrive - NHS/Documents/Pairwise70/MAFI-Calculator-Complete.html
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-21T02:06:02.134958+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:40`
- **Detail:** pattern matched: python C:/Users/user/mafi_functional_test.py
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-21T02:06:02.134980+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:84`
- **Detail:** pattern matched: | `C:/Users/user/mafi_selenium_test.py` | Basic Selenium test |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-21T02:06:02.135157+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:85`
- **Detail:** pattern matched: | `C:/Users/user/mafi_detailed_test.py` | Detailed test (older) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-21T02:06:02.135170+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:86`
- **Detail:** pattern matched: | `C:/Users/user/mafi_functional_test.py` | Comprehensive test (100% pass) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-21T02:06:02.135181+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `RED_TEAM_AUDIT.md:25`
- **Detail:** pattern matched: *   **Hardcoded Paths:** The scripts still point to `C:/Users/user/...`. This works on *your* machine. It will fail on t
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-21T02:06:03.564117+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `config_paths.R:9`
- **Detail:** pattern matched: normalizePath("C:/Users/user/OneDrive - NHS/Documents/Pairwise70", mustWork = FALSE),
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-21T02:06:16.785857+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `RED_TEAM_AUDIT.md:25`
- **Detail:** pattern matched: *   **Hardcoded Paths:** The scripts still point to `C:/Users/user/...`. This works on *your* machine. It will fail on t
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:33:27.868078+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:27`
- **Detail:** pattern matched: mafi <- fread("C:/Users/user/OneDrive - NHS/Documents/Pairwise70/analysis/output/MAFI_all_variants.csv")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:33:31.685802+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:35`
- **Detail:** pattern matched: C:/Users/user/OneDrive - NHS/Documents/Pairwise70/MAFI-Calculator-Complete.html
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:33:31.685828+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:40`
- **Detail:** pattern matched: python C:/Users/user/mafi_functional_test.py
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:33:31.685839+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:84`
- **Detail:** pattern matched: | `C:/Users/user/mafi_selenium_test.py` | Basic Selenium test |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:33:31.685926+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:85`
- **Detail:** pattern matched: | `C:/Users/user/mafi_detailed_test.py` | Detailed test (older) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:33:31.685932+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:86`
- **Detail:** pattern matched: | `C:/Users/user/mafi_functional_test.py` | Comprehensive test (100% pass) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:33:31.685937+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/DOCUMENTATION_ADVANCED_POOLING_METHODS.md:277`
- **Detail:** pattern matched: devtools::load_all("C:/Users/user/OneDrive - NHS/Documents/Pairwise70")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:33:46.517658+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `config_paths.R:9`
- **Detail:** pattern matched: normalizePath("C:/Users/user/OneDrive - NHS/Documents/Pairwise70", mustWork = FALSE),
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:33:52.769048+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `RED_TEAM_AUDIT.md:25`
- **Detail:** pattern matched: *   **Hardcoded Paths:** The scripts still point to `C:/Users/user/...`. This works on *your* machine. It will fail on t
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:35:43.187967+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:27`
- **Detail:** pattern matched: mafi <- fread("C:/Users/user/OneDrive - NHS/Documents/Pairwise70/analysis/output/MAFI_all_variants.csv")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:35:47.698390+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:35`
- **Detail:** pattern matched: C:/Users/user/OneDrive - NHS/Documents/Pairwise70/MAFI-Calculator-Complete.html
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:35:47.698477+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:40`
- **Detail:** pattern matched: python C:/Users/user/mafi_functional_test.py
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:35:47.698507+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:84`
- **Detail:** pattern matched: | `C:/Users/user/mafi_selenium_test.py` | Basic Selenium test |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:35:47.698773+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:85`
- **Detail:** pattern matched: | `C:/Users/user/mafi_detailed_test.py` | Detailed test (older) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:35:47.698789+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:86`
- **Detail:** pattern matched: | `C:/Users/user/mafi_functional_test.py` | Comprehensive test (100% pass) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:35:47.698798+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/DOCUMENTATION_ADVANCED_POOLING_METHODS.md:277`
- **Detail:** pattern matched: devtools::load_all("C:/Users/user/OneDrive - NHS/Documents/Pairwise70")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:36:11.113207+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `config_paths.R:9`
- **Detail:** pattern matched: normalizePath("C:/Users/user/OneDrive - NHS/Documents/Pairwise70", mustWork = FALSE),
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:36:13.982571+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:27`
- **Detail:** pattern matched: mafi <- fread("C:/Users/user/OneDrive - NHS/Documents/Pairwise70/analysis/output/MAFI_all_variants.csv")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:42:00.329476+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:35`
- **Detail:** pattern matched: C:/Users/user/OneDrive - NHS/Documents/Pairwise70/MAFI-Calculator-Complete.html
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:42:00.329512+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:40`
- **Detail:** pattern matched: python C:/Users/user/mafi_functional_test.py
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:42:00.329526+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:84`
- **Detail:** pattern matched: | `C:/Users/user/mafi_selenium_test.py` | Basic Selenium test |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:42:00.329620+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:85`
- **Detail:** pattern matched: | `C:/Users/user/mafi_detailed_test.py` | Detailed test (older) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:42:00.329627+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/SESSION_SUMMARY.md:86`
- **Detail:** pattern matched: | `C:/Users/user/mafi_functional_test.py` | Comprehensive test (100% pass) |
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:42:00.329633+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `RED_TEAM_AUDIT.md:25`
- **Detail:** pattern matched: *   **Hardcoded Paths:** The scripts still point to `C:/Users/user/...`. This works on *your* machine. It will fail on t
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:42:08.318765+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `analysis/DOCUMENTATION_ADVANCED_POOLING_METHODS.md:277`
- **Detail:** pattern matched: devtools::load_all("C:/Users/user/OneDrive - NHS/Documents/Pairwise70")
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:42:10.261023+00:00

## [BLOCK] P0-hardcoded-local-path
- **Location:** `config_paths.R:9`
- **Detail:** pattern matched: normalizePath("C:/Users/user/OneDrive - NHS/Documents/Pairwise70", mustWork = FALSE),
- **Fix hint:** Replace absolute paths with relative paths, config-driven roots, or environment variables. Use candidate-root discovery for data snapshots.

- **Source:** lessons.md#code-quality
- **When:** 2026-04-23T12:42:21.363985+00:00
