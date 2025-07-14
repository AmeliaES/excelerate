test_that("add_legend_title adds text into first cell of first sheet", {
  wb <- createWorkbook()
  addWorksheet(wb, sheetName = "README")
  title <- "test title"

  add_legend_title(wb, title)

  # Save to a temporary file
  temp_file <- tempfile(fileext = ".xlsx")
  openxlsx::saveWorkbook(wb, temp_file, overwrite = TRUE)

  # Read the first cell of the first sheet
  cell_value <- openxlsx::read.xlsx(temp_file,
    sheet = "README",
    cols = 1, rows = 1, colNames = FALSE
  )

  # Check if the title was added correctly
  expect_equal(cell_value[[1, 1]], title)
})
