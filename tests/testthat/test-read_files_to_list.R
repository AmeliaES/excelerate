test_that("read_files_to_list works", {
  # Generate tmp directory to test function against
  tmp_dir <- withr::local_tempdir()

  # Create csv files that match the pattern
  pattern <- "test_data"
  test_data_frame <- data.frame(x = 1:5)
  write.csv(test_data_frame, file.path(tmp_dir, paste0(pattern, "_1.csv")))
  write.csv(test_data_frame, file.path(tmp_dir, paste0(pattern, "_2.csv")))

  # Expect read_files_to_list returns a list of dataframes
  output <- read_files_to_list(tmp_dir, pattern)
  expect_identical(output[[1]][1], test_data_frame)
  expect_identical(length(output), 2)
  expect_type(output, "list")
  expect_s3_class(output[[1]][1], "data.frame")

})
