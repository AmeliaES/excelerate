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
  output <- sheet(results,
    sheet_name = "A",
    sheet_legend = "Summary of what sheet A contains"
  )

  expect_identical(as.data.frame(output[[1]]$results), as.data.frame(results))
  expect_equal(length(output), 1)
  expect_type(output, "list")
  expect_s3_class(output[[1]]$results, "data.frame")
  expect_equal(names(output), "A")
  expect_equal(names(output[[1]]), c("results", "sheet_legend"))
})

test_that("main results data frames have NULL row names", {
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

  test_row_names <- rownames(results)

  # expect error that row names not NULL
  expect_error(
    sheet(results,
      sheet_name = "A",
      sheet_legend = "Legend for table"
    ),
    "Row names of data frame passed to 'results' should be NULL."
  )
})


test_that("sheet_name does not exceed max characters", {
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

  rownames(results) <- NULL

  sheet_name <- paste0(rep("A", 100), collapse = "")

  # expect error that sheet_name is too long
  expect_error(
    sheet(results,
      sheet_name = sheet_name,
      sheet_legend = "Legend for table"
    ),
    paste0("sheet_name (", sheet_name, ") exceeds maximum 31 characters")
  )
})

test_that("sheet() returns an object of sheet class", {
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

  output <- sheet(results,
    sheet_name = "A",
    sheet_legend = "Legend for table"
  )

  # class sheet
  expect_s3_class(output, "sheet")
})

test_that("sheet() stops if there are no comments attribute on dataframe", {
  # error if no comments attributes assigned to each column
  expect_error(
    sheet(mtcars,
      sheet_name = "A",
      sheet_legend = "Legend for table"
    ),
    "Each column in the data frame must have a comment attribute."
  )
})
