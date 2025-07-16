test_that("add_sheet_legend works", {
  # Generate tmp directory to test function against
  tmp_dir <- withr::local_tempdir()

  results <- append_meta(
    results = iris,
    colname_descriptions = c(
      "Sepal.Length" = "Length of the sepal in cm",
      "Sepal.Width" = "Width of the sepal in cm",
      "Petal.Length" = "Length of the petal in cm",
      "Petal.Width" = "Width of the petal in cm",
      "Species" = "Species of iris"
    )
  )

  # Check spreadsheet returns expected object
  spreadsheet1 <- spreadsheet(
    sheet(results,
      sheet_name = "A",
      sheet_legend = "sheet legend 1"
    ),
    sheet(results,
      sheet_name = "B",
      sheet_legend = "sheet legend 2"
    ),
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
  readme <- openxlsx::read.xlsx(temp_file, sheet = "README", colNames = FALSE)

  # Check if the sheet legends were added
  expect_equal(readme[[1, 1]], "Sheet_Name")
  expect_equal(readme[[1, 2]], "Legend")
  expect_equal(readme[[2, 1]], "A")
  expect_equal(readme[[3, 1]], "B")
  expect_equal(readme[[2, 2]], "sheet legend 1")
  expect_equal(readme[[3, 2]], "sheet legend 2")
  expect_equal(output, 6)
})
