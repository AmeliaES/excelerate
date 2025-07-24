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

  # Save the workbook to a temporary file
  temp_file <- tempfile(fileext = ".xlsx")
  saveWorkbook(wb, temp_file, overwrite = TRUE)

  # Check any of the cells are italic
  # Use tidyxl to inspect styles
  cells <- tidyxl::xlsx_cells(temp_file)
  formats <- tidyxl::xlsx_formats(temp_file)

  # Filter for target labels
  target_labels <- c("sheet_name", "description")
  target_cells <- cells[cells$character %in% target_labels, ]

  # Get the style index for each target cell
  italic_flags <- formats$local$font$italic[target_cells$local_format_id]

  # Assert all targets are italic
  expect_true(all(italic_flags))
})
