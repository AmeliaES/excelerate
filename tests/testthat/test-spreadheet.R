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
    file = "SuppTab1",
    path = tempdir()
  )

  # a list of dataframes in the sheets part
  expect_type(output$sheets, "list")
  expect_s3_class(output$sheets$A$results, "data.frame")
  expect_equal(output$title, "Supplementary Table 1")
  expect_equal(output$file, "SuppTab1")
  expect_equal(output$path, tempdir())
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
    file = "SuppTab1",
    path = tempdir()
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
      title = "Supplementary Table 1",
      file = "SuppTab1",
      path = tempdir(),
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
      title = "Supplementary Table 1",
      file = "SuppTab1",
      path = tempdir()
    ),
    "At least one sheet must be provided."
  )
})


test_that("spreadsheet() error if title incorrect or missing", {
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

  expect_error(
    spreadsheet(
      sheet(results,
        sheet_name = "B",
        sheet_legend = "Legend for table"
      ),
      title = "",
      file = "SuppTab1",
      path = tempdir()
    ),
    "title must be a single character string."
  )

  expect_error(
    spreadsheet(
      sheet(results,
        sheet_name = "B",
        sheet_legend = "Legend for table"
      ),
      title = c("", "another string"),
      file = "SuppTab1",
      path = tempdir()
    ),
    "title must be a single character string."
  )
})

test_that("spreadsheet() error if file incorrect or missing", {
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

  expect_error(
    spreadsheet(
      sheet(results,
        sheet_name = "B",
        sheet_legend = "Legend for table"
      ),
      title = "title",
      file = NULL,
      path = tempdir()
    ),
    "file must be a single character string."
  )

  expect_error(
    spreadsheet(
      sheet(results,
        sheet_name = "B",
        sheet_legend = "Legend for table"
      ),
      title = c("", "another string"),
      file = "SuppTab1",
      path = tempdir()
    ),
    "title must be a single character string."
  )
})

test_that("spreadsheet() error if path not a character string", {
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
      title = "a title",
      file = "SuppTab1",
      path = NULL,
    ),
    "path must be a single character string."
  )

  # Check spreadsheet returns expected object
  expect_error(
    spreadsheet(
      sheet(results,
        sheet_name = "B",
        sheet_legend = "Legend for table"
      ),
      title = "a title",
      file = "SuppTab1",
      path = "path/to/nonexistent/dir/",
    ),
    "Directory specified to path does not exist."
  )
})

test_that("no error occurs if file not given", {
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

  expect_no_error(
    spreadsheet(
      sheet(results,
        sheet_name = "A",
        sheet_legend = "Legend for table"
      ),
      sheet(results,
        sheet_name = "B",
        sheet_legend = "Legend for table"
      ),
      title = "Supplementary Table 1",
      path = tempdir()
    )
  )
})
