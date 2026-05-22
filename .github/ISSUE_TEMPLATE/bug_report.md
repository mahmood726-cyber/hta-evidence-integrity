---
name: Bug report
about: Something is producing the wrong result or crashing
title: ''
labels: bug
assignees: ''
---

## What happened

A short description of what went wrong and what you expected instead.

## Reproducible example

```r
library(Pairwise70)
# Minimal yi / vi that triggers the issue:
yi <- c(...)
vi <- c(...)
# Call that misbehaves:
mafi_weighted_ma(yi, vi)
```

## Session info

```r
sessionInfo()
# or, even better:
# sessioninfo::session_info()
```

## Additional context

Anything else that might be relevant (operating system, R version,
`metafor` version, optional packages installed, etc.).
