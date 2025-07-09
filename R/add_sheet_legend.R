#' Add legends for sheets below main legend
#'
#' @param wb openxlsx workbook object
#' @param spreadsheet spreadsheet object returned from spreadsheet()
#'
#' @return numeric value with row index for next empty cell
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
