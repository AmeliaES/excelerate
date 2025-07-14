test_that("sheet works", {
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

  # Sheet returns a list item with two dataframes named main and meta
  output <- sheet(results, sheet_name = "A", sheet_legend = "Summary of what sheet A contains")

  expect_identical(as.data.frame(output[[1]]$results), as.data.frame(results))
  expect_equal(length(output), 1)
  expect_type(output, "list")
  expect_s3_class(output[[1]]$results, "data.frame")
  expect_equal(names(output), "A")
  expect_equal(names(output[[1]]), c("results", "sheet_legend"))
})
