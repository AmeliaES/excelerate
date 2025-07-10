#' Add Legends for Sheets Below Main Legend
#'
#' This function adds legends for each sheet in a given spreadsheet to the
#' README worksheet of an openxlsx workbook.
#'
#' @param wb An `openxlsx` workbook object.
#' @param spreadsheet A spreadsheet object returned from `spreadsheet()`.
#'
#' @return Numeric value with the row index for the next empty cell.
#' @importFrom openxlsx writeData
#' @noRd
add_sheet_legend <- function(wb, spreadsheet) {
  # Get all sheet legends
  legends <- sapply(spreadsheet$sheets, function(sheet) sheet$sheet_legend)

  # Write each legend to a new row in the README sheet
  for (i in seq_along(legends)) {
    writeData(wb, sheet = "README", legends[i], startRow = i + 1, startCol = 1)
    # Define variable with row index for next empty cell
    nextFreeRow <- i + 2
  }

  nextFreeRow
}
