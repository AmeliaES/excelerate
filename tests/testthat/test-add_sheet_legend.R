test_that("add_sheet_legend works", {
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

  output <- add_sheet_legend(wb, spreadsheet1)

  # Save to a temporary file
  temp_file <- tempfile(fileext = ".xlsx")
  openxlsx::saveWorkbook(wb, temp_file, overwrite = TRUE)

  # Read the README sheet
  README <- openxlsx::read.xlsx(temp_file, sheet = "README", colNames = FALSE)

  # Check if the sheet legends were added
  expect_equal(README[[1,1]], "sheet legend 1")
  expect_equal(README[[2,1]], "sheet legend 2")
  expect_equal(output, 4)
})
