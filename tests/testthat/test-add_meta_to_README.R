test_that("check add_meta_to_readme works", {
  # Generate tmp directory to test function against
  tmp_dir <- withr::local_tempdir()

  results <- append_meta(
    results = mtcars,
    colname_descriptions = c(
      "mpg" = "Miles/(US) gallon",
      "cyl" = "Number of cylinders",
      "disp" = "Displacement (cu.in.)",
      "hp" = "Gross horsepower",
      "drat" = "Rear axle ratio",
      "wt" = "Weight (1000 lbs)",
      "qsec" = "1/4 mile time",
      "vs" = "Engine (0 = V-shaped, 1 = straight)",
      "am" = "Transmission (0 = automatic, 1 = manual)",
      "gear" = "Number of forward gears",
      "carb" = "Number of carburetors"
    )
  )

  # Check spreadsheet returns expected object
  spreadsheet1 <- spreadsheet(
    sheet(results,
      sheet_name = "A",
      sheet_legend = "Legend for table"
    ),
    sheet(results,
      sheet_name = "B",
      sheet_legend = "Legend for table"
    ),
    title = "Supplementary Table 1",
    filename = "SuppTab1"
  )

  wb <- createWorkbook()
  addWorksheet(wb, sheetName = "README")
  writeData(wb, sheet = "README", "a test string", startRow = 1, startCol = 1)
  writeData(wb, sheet = "README", "a test string 1", startRow = 2, startCol = 1)
  writeData(wb, sheet = "README", "a test string 2", startRow = 3, startCol = 1)

  add_meta_to_readme(wb, spreadsheet1, nextFreeRow = 4)

  # Save to a temporary file
  temp_file <- tempfile(fileext = ".xlsx")
  openxlsx::saveWorkbook(wb, temp_file, overwrite = TRUE)

  # Read the README sheet
  readme <- openxlsx::read.xlsx(temp_file, sheet = "README", colNames = FALSE)

  # Check if the metadata were added
  expect_equal(readme[[4, 1]], "Sheet_Name")
  expect_equal(readme[[4, 2]], "Column_Name")
  expect_equal(readme[[4, 3]], "Description")
  expect_equal(readme[[5, 1]], "A")
  expect_equal(readme[[5, 2]], "mpg")
  expect_equal(readme[[5, 3]], "Miles/(US) gallon")
})
