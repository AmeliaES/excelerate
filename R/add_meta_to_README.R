#' Function to add column description metadata to README file
#'
#' @param wb openxlsx workbook object.
#' @param spreadsheet `spreadsheet` object created with [spreadsheet()].
#' @param next_free_row index of row with empty cell after writing sheet
#' legends.
#'
#' @return Numeric value for the index of the next row with empty cells.
#'
#' @importFrom dplyr bind_rows
#' @importFrom openxlsx writeData createStyle addStyle
#' @noRd
add_meta_to_readme <- function(wb, spreadsheet, next_free_row) {
  # extract the meta data from each results item
  meta_list <- lapply(spreadsheet$sheets, extract_meta_from_sheet)

  # combine all meta data into a single data frame and add id column
  col_name_descriptions <- dplyr::bind_rows(meta_list, .id = "Sheet_Name")

  # Leave an empty row before inserting metadata
  openxlsx::writeData(wb,
    sheet = "README", col_name_descriptions,
    startRow = next_free_row, startCol = 1
  )

  # Style heading as italic
  italic_style <- createStyle(textDecoration = "italic")
  addStyle(wb, "README", italic_style, rows = next_free_row + 1, cols = 1:3)

  # Autofit cols based on the max number of characters in each column
  # autofitting based on all rows in the README includes the very long legends
  # we just want to autofit using the rows with sheet names and descriptions
  autofit_cols(wb, col_name_descriptions, "README")

  next_free_row
}
