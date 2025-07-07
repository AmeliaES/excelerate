test_that("excelerate function works", {
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
    sheet(tmp_dir, paste0(pattern,"_1"), sheet_name = "A", "sheet legend"),
    sheet(tmp_dir, paste0(pattern,"_2"), sheet_name = "B", "sheet legend"),
    title = "Supplementary Table 1",
    filename = file.path(tmp_dir, "SuppTab1.xlsx")
  )

  spreadsheet2 <- spreadsheet(
    sheet(tmp_dir, paste0(pattern,"_1"), sheet_name = "A", "sheet legend"),
    sheet(tmp_dir, paste0(pattern,"_2"), sheet_name = "B", "sheet legend"),
    title = "Supplementary Table 2",
    filename = file.path(tmp_dir, "SuppTab2.xlsx")
  )

  output <- excelerate(spreadsheet1, spreadsheet2)

  # Check excelerate returns expected object
  expect_true(file.exists(file.path(tmp_dir, "SuppTab1.xlsx")))
  expect_equal(readxl::excel_sheets(file.path(tmp_dir, "SuppTab1.xlsx")), c("README", "A", "B"))
  expect_true(file.exists(file.path(tmp_dir, "SuppTab2.xlsx")))
  expect_equal(readxl::excel_sheets(file.path(tmp_dir, "SuppTab2.xlsx")), c("README", "A", "B"))

})

test_that("input to excelerate are spreadsheet class",{
  expect_error(excelerate(NULL),
               "Non spreadsheet class used as input to excelerate")
})

test_that("README sheet contains legend title, sheet legends and metadata",{

})

test_that("non README sheets contain expected data",{

})

