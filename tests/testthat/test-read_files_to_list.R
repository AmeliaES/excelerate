test_that("read_files_to_list works", {
  # Generate tmp directory to test function against
  tmp_dir <- withr::local_tempdir()

  # Create csv files that match the pattern
  pattern <- "test_data"
  test_data_frame <- data.frame(x = 1:5)
  test_meta <- data.frame("Col_name" = "X", "description" = "description of the column here")
  write.csv(test_data_frame, file.path(tmp_dir, paste0(pattern, "_1.csv")), row.names = FALSE)
  write.csv(test_meta, file.path(tmp_dir, paste0(pattern, "_1.csv.cols")), row.names = FALSE)
  write.csv(test_data_frame, file.path(tmp_dir, paste0(pattern, "_2.csv")), row.names = FALSE)
  write.csv(test_meta, file.path(tmp_dir, paste0(pattern, "_2.csv.cols")), row.names = FALSE)

  # Expect read_files_to_list returns a list of dataframes
  output <- read_files_to_list(tmp_dir, pattern, sheet_names = c("A", "B"))
  expect_identical(as.data.frame(output[[1]]$main), as.data.frame(test_data_frame))
  expect_equal(length(output), 2)
  expect_type(output, "list")
  expect_s3_class(output[[1]]$main, "data.frame")

})

test_that("read_files_to_list names the sheets correctly",{

})
