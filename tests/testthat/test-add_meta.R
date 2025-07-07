test_that("check add_meta works", {
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

  spreadsheet1 <- spreadsheet(
    sheet(tmp_dir, paste0(pattern,"_1"), sheet_name = "A", "sheet legend 1"),
    sheet(tmp_dir, paste0(pattern,"_2"), sheet_name = "B", "sheet legend 2"),
    title = "Supplementary Table 1",
    filename = "SuppTab1"
  )

  wb <- createWorkbook()
  addWorksheet(wb, sheetName = "README")
  writeData(wb, sheet = "README", "a test string", startRow = 1, startCol = 1)
  writeData(wb, sheet = "README", "a test string 1", startRow = 2, startCol = 1)
  writeData(wb, sheet = "README", "a test string 2", startRow = 3, startCol = 1)

  add_meta(wb, spreadsheet1, nextFreeRow = 4)

  # Save to a temporary file
  temp_file <- tempfile(fileext = ".xlsx")
  openxlsx::saveWorkbook(wb, temp_file, overwrite = TRUE)

  # Read the README sheet
  README <- openxlsx::read.xlsx(temp_file, sheet = "README", colNames = FALSE)

  # Check if the metadata were added
  expect_equal(README[[4,1]], "sheet_name")
  expect_equal(README[[4,2]], "Col_name")
  expect_equal(README[[4,3]], "description")
  expect_equal(README[[5,1]], "A")
  expect_equal(README[[5,2]], "X")
  expect_equal(README[[5,3]], "description of the column here")
  expect_equal(README[[6,1]], "B")
  expect_equal(README[[6,2]], "X")
  expect_equal(README[[6,3]], "description of the column here")

})
