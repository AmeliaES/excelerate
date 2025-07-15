test_that("the width of the column is max n chars in each col + extra_char_n", {
  # Use iris dataset
  data <- iris

  # Create a workbook and add a worksheet
  wb_expected <- createWorkbook()
  sheet_name <- "Sheet1"
  addWorksheet(wb_expected, sheet_name)
  writeData(wb_expected, sheet_name, data)

  # Set expected widths manually
  extra_char_n <- 4
  expected_widths <- sapply(data, function(column) {
    max(nchar(as.character(column))) + extra_char_n
  })

  for (col in seq_len(ncol(data))) {
    setColWidths(wb_expected,
      sheet = sheet_name, cols = col,
      widths = expected_widths[col]
    )
  }

  # Create another workbook and apply autofit
  wb_actual <- createWorkbook()
  addWorksheet(wb_actual, sheet_name)
  writeData(wb_actual, sheet_name, data)
  autofit_cols(wb_actual, data, sheet_name)

  # Compare the files
  expect_equal(wb_actual$colWidths, wb_expected$colWidths)
})
