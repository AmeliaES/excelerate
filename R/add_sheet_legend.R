#' Add Legends for Sheets Below Main Legend
#'
#' This function adds legends for each sheet in a given spreadsheet to the
#' README worksheet of an openxlsx workbook.
#'
#' @param wb An `openxlsx` workbook object.
#' @param spreadsheet A spreadsheet object returned from `spreadsheet()`.
#'
#' @return Numeric value with the row index for the next empty cell.
#' @importFrom openxlsx writeData createStyle addStyle
#' @noRd
add_sheet_legend <- function(wb, spreadsheet) {
  # Get all sheet legends and their names
  sheet_names <- names(spreadsheet$sheets)
  legends <- sapply(spreadsheet$sheets, function(sheet) sheet$sheet_legend)

  # Create a data frame with sheet names and legends
  legends_df <- data.frame(
    "Sheet_Name" = sheet_names,
    "Legend" = legends,
    stringsAsFactors = FALSE
  )

  # Define styles
  bold_style <- createStyle(textDecoration = "bold")
  italic_style <- createStyle(textDecoration = "italic")

  # Define the heading row
  header_row <- 3

  # Write the header
  writeData(wb,
    sheet = "README",
    legends_df,
    startRow = header_row, startCol = 1,
    colNames = TRUE, headerStyle = italic_style
  )

  # Style the legends with bold
  addStyle(wb,
    sheet = "README", style = bold_style,
    rows = (header_row + 1):(header_row + nrow(legends_df)), cols = 1:2,
    gridExpand = TRUE
  )

  # Return the next free row
  next_free_row <- header_row + nrow(legends_df) + 1

  next_free_row
}
