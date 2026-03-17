# config_paths.R — Portable path configuration for HTA Evidence Integrity Suite
# Source this file at the top of any analysis script that needs Pairwise70 data.

# Pairwise70 root: use environment variable if set, else detect common locations
PAIRWISE70_ROOT <- Sys.getenv("PAIRWISE70_ROOT", unset = "")
if (PAIRWISE70_ROOT == "") {
  candidates <- c(
    file.path(dirname(getwd()), "Pairwise70"),
    normalizePath("C:/Users/user/OneDrive - NHS/Documents/Pairwise70", mustWork = FALSE),
    normalizePath("~/Pairwise70", mustWork = FALSE)
  )
  found <- candidates[dir.exists(candidates)]
  if (length(found) > 0) {
    PAIRWISE70_ROOT <- found[1]
  } else {
    stop("Pairwise70 data directory not found. Set PAIRWISE70_ROOT environment variable.")
  }
}
PAIRWISE70_ROOT <- normalizePath(PAIRWISE70_ROOT, winslash = "/", mustWork = TRUE)

# Project root
PROJECT_ROOT <- normalizePath(file.path(dirname(sys.frame(1)$ofile %||% ".")), winslash = "/")

cat(sprintf("Pairwise70 root: %s\n", PAIRWISE70_ROOT))
