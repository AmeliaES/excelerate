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
  # Get all sheet legends
  legends <- lapply(spreadsheet$sheets, function(sheet){
    sheet$sheet_legend
  })

  # Name the legend with the sheet name it applies to
  names(legends) <- names(spreadsheet$sheets)

  # Define bold and italc styles
  bold_style <- createStyle(textDecoration = "bold")
  italic_style <- createStyle(textDecoration = "italic")

  # Define the heading row
  header_row <- 2

  # Add a heading
  writeData(wb, sheet = "README", "Sheet Name",
            startRow = header_row, startCol = 1)

  writeData(wb, sheet = "README", "Legend",
            startRow = header_row, startCol = 2)

  # Style heading with italics
  addStyle(wb, sheet = "README", style = italic_style,
           rows = header_row, cols = 1:2)

  # Write each legend to a new row in the README sheet
  for (i in seq_along(legends)) {

    # Write the sheet name and legend to the README sheet
    writeData(wb, sheet = "README", names(legends[i]),
              startRow = i + header_row, startCol = 1)
    writeData(wb, sheet = "README", legends[[i]],
              startRow = i + header_row, startCol = 2)

    # Style the sheet legend in bold
    addStyle(wb, sheet = "README", style = bold_style,
             rows = i + header_row, cols = 1:2)

    # Define variable with row index for next empty cell
    nextFreeRow <- i + header_row + 1
  }

  nextFreeRow
}
