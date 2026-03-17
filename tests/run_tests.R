setwd("C:/Models/HTA_Evidence_Integrity_Suite")
tryCatch(
  testthat::test_file("tests/test_pipeline.R"),
  error = function(e) cat("ERROR:", conditionMessage(e), "\n")
)
