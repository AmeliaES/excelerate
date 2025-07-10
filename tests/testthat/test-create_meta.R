test_that("create_meta works", {

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

  # Check if all columns have comments
  expect_true(all(sapply(results, function(x) !is.null(comment(x)))))

})

test_that("create_meta stops on missing description", {

  expect_error(
    results <- create_meta(
      results = mtcars,
      colname_descriptions = c(
        "mpg" = "Miles/(US) gallon",
        "cyl" = "Number of cylinders",
        "disp" = "Displacement (cu.in.)",
        "hp" = "Gross horsepower",
        "drat" = "Rear axle ratio"
      )
    ),
    "Column names .+ in"
  )
})
