test_that("excelerate function works", {
  # Generate tmp directory to test function against
  tmp_dir <- withr::local_tempdir()

  results <- create_meta(
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
          sheet_legend = "Legend for table"),
    sheet(results,
          sheet_name = "B",
          sheet_legend = "Legend for table"),
    title = "Supplementary Table 1",
    filename = file.path(tmp_dir, "SuppTab1.xlsx")
  )

  spreadsheet2 <- spreadsheet(
    sheet(results,
          sheet_name = "A",
          sheet_legend = "Legend for table"),
    sheet(results,
          sheet_name = "B",
          sheet_legend = "Legend for table"),
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
