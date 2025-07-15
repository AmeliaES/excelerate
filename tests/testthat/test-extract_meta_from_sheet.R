test_that("extract_meta_from_sheet works", {
  # generate some test data
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

  test_sheet <- list(results = results)

  output <- extract_meta_from_sheet(test_sheet)

  expect_equal(colnames(output), c("Column_Name", "Description"))
  expect_equal(nrow(output), ncol(results))
  expect_equal(output$Column_Name, colnames(results))
  expect_equal(output$Description[1], "Miles/(US) gallon")
})
