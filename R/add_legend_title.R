#' Add Legend Title to README Sheet
#'
#' This function writes a legend title to the first cell in the README sheet of
#' a workbook.
#'
#' @param wb A workbook object from the openxlsx package.
#' @param title A character string with the legend title from [spreadsheet()].
#'
#' @importFrom openxlsx writeData
#' @noRd
add_legend_title <- function(wb, title) {
  # Update legend_title
  legend_title <- title

  # Write the table legend title
  writeData(wb, sheet = "README", legend_title, startRow = 1, startCol = 1)

  # Change style to bold
  bold_style <- createStyle(textDecoration = "bold")

  # Add style to the first cell (main table legend) of the README sheet
  addStyle(wb, sheet = "README", bold_style, rows = 1, cols = 1)

}
