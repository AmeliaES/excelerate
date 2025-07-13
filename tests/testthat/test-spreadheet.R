test_that("spreadsheet function works", {

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
  output <- spreadsheet(
    sheet(results,
          sheet_name = "A",
          sheet_legend = "Legend for table"),
    sheet(results,
          sheet_name = "B",
          sheet_legend = "Legend for table"),
    title = "Supplementary Table 1",
    filename = "SuppTab1"
  )

  # a list of dataframes in the sheets part
  expect_type(output$sheets, "list")
  expect_s3_class(output$sheets$A$results, "data.frame")
  expect_equal(output$title, "Supplementary Table 1")
  expect_equal(output$filename, "SuppTab1")

})

test_that("output of spreadsheet function is spreadsheet class", {
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

  output <- spreadsheet(
    sheet(results,
          sheet_name = "A",
          sheet_legend = "Legend for table"),
    sheet(results,
          sheet_name = "B",
          sheet_legend = "Legend for table"),
    title = "Supplementary Table 1",
    filename = "SuppTab1"
  )

  # class spreadsheet
  expect_s3_class(output, "spreadsheet")

})
