#' Function to combine sheets into a list, with supplementary table legend and filename to save excel.
#'
#' @param ... A list of sheets
#' @param title Character string with legend title for spreadsheet
#' @param filename Character string with path and file name for excel spreadsheet
#'
#' @returns List of sheets, with title and path for saving excel file
#' @export
#'
#' @examples
#' \dontrun{
#' spreadsheet(
#' sheet("path/to/data/", "file_name_for_first_sheet", "sheet name A", "Table legend A"),
#' sheet("path/to/data/second_file", "file_name_for_second_sheet", "sheet name B", "Table legend B"),
#' "Supplementary Table Legend Title",
#' "path/to/save/excel/file_name")
#' }
spreadsheet <- function(..., title, filename){
  sheets <- c(...)
  spreadsheet <- list(sheets = sheets, title = title, filename = filename)
  class(spreadsheet) <- "spreadsheet"
  spreadsheet
}
