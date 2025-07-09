#' Creates README sheet in first sheet
#'
#' @param wb Workbook object from openxlsx package
#' @importFrom openxlsx addWorksheet
#'
#' @examples
#' \notrun {
#' add_readme(wb)
#' }
add_readme <- function(wb){

  # Create a readme sheet
  addWorksheet(wb, sheetName = "README")

}
