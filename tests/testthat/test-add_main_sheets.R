test_that("check add_main_sheets works as expected", {
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
  add_main_sheets(wb, spreadsheet1)

  # Save to a temporary file
  temp_file <- tempfile(fileext = ".xlsx")
  openxlsx::saveWorkbook(wb, temp_file, overwrite = TRUE)

  # Read in the excel file, with sheet_name = A
  sheet_a <- openxlsx::read.xlsx(temp_file, sheet = "A", colNames = TRUE)
  sheet_b <- openxlsx::read.xlsx(temp_file, sheet = "B", colNames = TRUE)
  expect_equal(
    as.data.frame(lapply(sheet_a, as.character)),
    as.data.frame(lapply(iris, as.character))
  )
  expect_equal(
    as.data.frame(lapply(sheet_b, as.character)),
    as.data.frame(lapply(iris, as.character))
  )
})
