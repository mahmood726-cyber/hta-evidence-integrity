#!/usr/bin/env Rscript

################################################################################
# NETWORK CONNECTIVITY SCOPING
# Identifying common comparators to build NMAs from pairwise data
################################################################################

suppressPackageStartupMessages({
  library(data.table)
  library(stringr)
})

cat("================================================================================
")
cat("HTA METHODOLOGY: NETWORK CONNECTIVITY SCOPING
")
cat("================================================================================

")

# Path to original metadata summary (standard Cochrane format)
source("../config_paths.R")
metadata_path <- file.path(PAIRWISE70_ROOT, "analysis/output/remediation_analysis_results.csv")

if (!file.exists(metadata_path)) {
  stop("Metadata results not found.")
}

data <- fread(metadata_path)

# Extract Analysis Names which usually contain "A vs B"
cat("Extracting nodes from analysis names...
")

# Simple regex to split "Intervention vs Comparator"
# This is heuristic and would need refinement for specific review styles
extract_nodes <- function(name) {
  parts <- str_split(name, " [vV][sS]\\.? ")[[1]]
  if (length(parts) == 2) {
    return(list(node1 = str_trim(parts[1]), node2 = str_trim(parts[2])))
  }
  return(NULL)
}

# Sample check on unique names
unique_analyses <- unique(data$analysis_name)
cat(sprintf("Scanning %d unique analysis names for connectivity...
", length(unique_analyses)))

nodes_list <- list()
for (name in unique_analyses) {
  nodes <- extract_nodes(name)
  if (!is.null(nodes)) {
    nodes_list[[length(nodes_list) + 1]] <- data.table(name = name, n1 = nodes$node1, n2 = nodes$node2)
  }
}

nodes_dt <- rbindlist(nodes_list)

# Count Node Frequency (Finding the "Hubs")
all_nodes <- c(nodes_dt$n1, nodes_dt$n2)
hubs <- sort(table(all_nodes), decreasing = TRUE)

cat("
TOP 5 POTENTIAL NETWORK HUBS (Common Comparators):
")
print(head(hubs, 5))

cat("
Network scoping completed. This allows linking 'Gold Standard' pairwise evidence into robust networks.
")
