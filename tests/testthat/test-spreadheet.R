test_that("spreadsheet function works", {
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
  output <- spreadsheet(
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

  # a list of dataframes in the sheets part
  expect_type(output$sheets, "list")
  expect_s3_class(output$sheets$A$results, "data.frame")
  expect_equal(output$title, "Supplementary Table 1")
  expect_equal(output$filename, "SuppTab1")
})

test_that("output of spreadsheet function is spreadsheet class", {
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

  output <- spreadsheet(
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

  # class spreadsheet
  expect_s3_class(output, "spreadsheet")
})

test_that("spreadhseet() throws error if not given sheet objects", {
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
  expect_error(
    spreadsheet(
      "Supplementary Table 1",
      "SuppTab1",
      "another string"
    ),
    "All additional arguments must be 'sheet' objects."
  )
})

test_that("spreadhseet() throws error if sheets missing", {
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
  expect_error(
    spreadsheet(
      "Supplementary Table 1",
      "SuppTab1"
    ),
    "At least one sheet must be provided."
  )
})


test_that("spreadhseet() error if 1st arg is not character string for title", {
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
  expect_error(
    spreadsheet(
      sheet(results,
        sheet_name = "B",
        sheet_legend = "Legend for table"
      ),
      "Supplementary Table 1",
      "SuppTab1"
    ),
    "Title must be a single character string."
  )
})

test_that("spreadhseet() error if 2nd arg is not character string filename", {
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
  expect_error(
    spreadsheet(
      "Supplementary Table 1",
      sheet(results,
        sheet_name = "B",
        sheet_legend = "Legend for table"
      ),
      "SuppTab1"
    ),
    "Filename must be a single character string."
  )
})
