test_that("check add_meta_to_readme works", {
  # Generate tmp directory to test function against
  tmp_dir <- withr::local_tempdir()

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
    file = "SuppTab1",
    path = tmp_dir
  )

  wb <- createWorkbook()
  addWorksheet(wb, sheetName = "README")
  next_free_row <- 4
  add_meta_to_readme(wb, spreadsheet1, next_free_row = next_free_row)

  # Save to a temporary file
  temp_file <- tempfile(fileext = ".xlsx")
  openxlsx::saveWorkbook(wb, temp_file, overwrite = TRUE)

  # Read the README sheet
  readme <- openxlsx::read.xlsx(temp_file,
    sheet = "README",
    colNames = FALSE,
    startRow = next_free_row + 1
  )

  # Check if the metadata were added
  expect_equal(readme[[1, 1]], "Sheet_Name")
  expect_equal(readme[[1, 2]], "Column_Name")
  expect_equal(readme[[1, 3]], "Description")
  expect_equal(readme[[2, 1]], "A")
  expect_equal(readme[[2, 2]], "Sepal.Length")
  expect_equal(readme[[2, 3]], "Length of the sepal in cm")
})


test_that("sheet_name and description labels are in italic", {
  tmp_dir <- withr::local_tempdir()

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
    file = "SuppTab1",
    path = tmp_dir
  )

  wb <- createWorkbook()
  addWorksheet(wb, sheetName = "README")
  next_free_row <- 4
  add_meta_to_readme(wb, spreadsheet1, next_free_row = next_free_row)

  # Check the header rows and cols are contained in the style objects
  # and style contains ITALIC
  expect_equal(wb$styleObjects[[1]]$row, rep(5, 3))
  expect_equal(wb$styleObjects[[1]]$col, c(1, 2, 3))
  expect_contains(
    capture.output(wb$styleObjects[[1]]$style),
    " Font decoration: ITALIC "
  )
})
