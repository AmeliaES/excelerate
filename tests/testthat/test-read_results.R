test_that("read_results works", {
  # Generate tmp directory to test function against
  tmp_dir <- withr::local_tempdir()

  # Create csv files that match the pattern
  pattern <- "test_data"
  test_data_frame <- data.frame(x = 1:5)
  test_meta <- data.frame("Col_name" = "X", "description" = "description of the column here")
  write.csv(test_data_frame, file.path(tmp_dir, paste0(pattern, "_1.csv")), row.names = FALSE)
  write.csv(test_meta, file.path(tmp_dir, paste0(pattern, "_1.csv.cols")), row.names = FALSE)

  # Expect read_results to return a list of file paths
  output <- read_results(file.path(tmp_dir, paste0(pattern, "_1.csv")), "Summary of what sheet A contains")
  expect_type(output, "list")
  expect_equal(names(output), c("main", "meta", "sheet_legend"))
  expect_s3_class(output$main, "data.frame")
  expect_s3_class(output$meta, "data.frame")
})


test_that("read_results produces an error if the user has not supplied meta data in a .col file", {
  # Generate tmp directory to test function against
  tmp_dir <- withr::local_tempdir()

  # Create csv files that match the pattern
  pattern <- "test_data"
  test_data_frame <- data.frame(x = 1:5)
  write.csv(test_data_frame, file.path(tmp_dir, paste0(pattern, "_1.csv")), row.names = FALSE)

  # Expect error if meta data not supplied
  expect_error(
    read_results(file.path(tmp_dir, paste0(pattern, "_1.csv")), "Summary of what sheet A contains"),
    'Cannot find meta data file with ".cols" extension'
  )
})
