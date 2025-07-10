#' Create README Sheet in Workbook
#'
#' This function adds a README sheet as the first sheet in an openxlsx workbook.
#'
#' @param wb A workbook object from the openxlsx package.
#' @importFrom openxlsx addWorksheet
#' @noRd
add_readme <- function(wb) {
  # Create a readme sheet
  addWorksheet(wb, sheetName = "README")
}
