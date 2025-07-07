#' Adds legend title to first cell in README sheet
#'
#' @param wb Workbook object from openxlsx package
#' @param title Character string with title from spreadsheet()
#' @importFrom openxlsx writeData
#'
add_legend_title <- function(wb, title) {

  # Update legend_title
  legend_title <- title

  # Write the table legend title
  writeData(wb, sheet = "README", legend_title, startRow = 1, startCol = 1)
}
