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

test_that("legend title is in bold font", {
  wb <- createWorkbook()
  addWorksheet(wb, sheetName = "README")
  title <- "test title"

  add_legend_title(wb, title)

  # Save the workbook to a temporary file
  temp_file <- tempfile(fileext = ".xlsx")
  saveWorkbook(wb, temp_file, overwrite = TRUE)

  # Use tidyxl to inspect styles
  cells <- tidyxl::xlsx_cells(temp_file)
  formats <- tidyxl::xlsx_formats(temp_file)

  # Find the cell in the README sheet at row 1, column 1
  cell <- subset(cells, sheet == "README" & row == 1 & col == 1)

  # Extract the format ID (see tidyxl for details)
  fmt_id <- cell$local_format_id

  # Now check the font formatting
  is_bold <- formats$local$font$bold[fmt_id]
  expect_true(is_bold)
})
