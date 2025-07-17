test_that("excelerate function works", {
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
    path = file.path(tmp_dir),
    file = ""
  )

  spreadsheet2 <- spreadsheet(
    sheet(results,
      sheet_name = "A",
      sheet_legend = "Legend for table"
    ),
    sheet(results,
      sheet_name = "B",
      sheet_legend = "Legend for table"
    ),
    title = "Supplementary Table 2",
    path = file.path(tmp_dir),
    file = "SuppTab2.xlsx"
  )

  output <- excelerate(spreadsheet1, spreadsheet2)

  # Check excelerate returns expected object
  expect_true(file.exists(file.path(tmp_dir, "S1.xlsx")))
  expect_equal(
    readxl::excel_sheets(file.path(tmp_dir, "S1.xlsx")),
    c("README", "1A A", "1B B")
  )
  expect_true(file.exists(file.path(tmp_dir, "S2_SuppTab2.xlsx")))
  expect_equal(
    readxl::excel_sheets(file.path(tmp_dir, "S2_SuppTab2.xlsx")),
    c("README", "2A A", "2B B")
  )
})

test_that("input to excelerate are spreadsheet class", {
  expect_error(
    excelerate(NULL),
    "Non spreadsheet class used as input to excelerate"
  )
})
