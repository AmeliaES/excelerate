test_that("spreadsheet function works", {
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

  # Check spreadsheet returns expected object
  output <- spreadsheet(
    sheet(tmp_dir, paste0(pattern,"_1"), sheet_name = "A"),
    sheet(tmp_dir, paste0(pattern,"_2"), sheet_name = "B"),
    title = "Supplementary Table 1",
    filename = "SuppTab1"
  )

  # a list of dataframes
  expect_type(output$sheets, "list")
  expect_s3_class(output$sheets[[1]], "data.frame")
  expect_equal(output$title, "Supplementary Table 1")
  expect_equal(output$filename, "SuppTab1")

})
