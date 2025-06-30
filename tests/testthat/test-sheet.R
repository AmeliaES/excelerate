test_that("sheet works", {
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

  # Sheet returns a list item with two dataframes named main and meta
  output <- sheet(tmp_dir, paste0(pattern,"_1"), sheet_name = "A")
  expect_identical(as.data.frame(output[[1]]$main), as.data.frame(test_data_frame))
  expect_equal(length(output), 1)
  expect_type(output, "list")
  expect_s3_class(output[[1]]$main, "data.frame")
  expect_s3_class(output[[1]]$meta, "data.frame")

})

test_that("sheet names the sheets correctly",{
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

  # Sheet returns a list item with two dataframes named main and meta
  output <- sheet(tmp_dir, paste0(pattern,"_1") , sheet_name = "A")
  expect_identical(names(output), "A")
})
