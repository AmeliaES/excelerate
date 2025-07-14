test_that("add_sheet_legend works", {
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
  README <- openxlsx::read.xlsx(temp_file, sheet = "README", colNames = FALSE)

  # Check if the sheet legends were added
  expect_equal(README[[1, 1]], "sheet legend 1")
  expect_equal(README[[2, 1]], "sheet legend 2")
  expect_equal(output, 4)
})
