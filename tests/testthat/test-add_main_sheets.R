test_that("check add_main_sheets works as expected", {
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
  add_main_sheets(wb, spreadsheet1)

  # Save to a temporary file
  temp_file <- tempfile(fileext = ".xlsx")
  openxlsx::saveWorkbook(wb, temp_file, overwrite = TRUE)

  # Read in the excel file, with sheet_name = A
  sheetA <- openxlsx::read.xlsx(temp_file, sheet = "A", colNames = TRUE)

  expect_equal(sheetA, test_data_frame)
})
