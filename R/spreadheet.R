#' Combine Sheets into a List for an Excel Spreadsheet
#'
#' Combines multiple sheets into a single structure with supplementary table
#' legend and file name for saving as Excel.
#'
#' @param title A character string with the legend title for the spreadsheet.
#' @param path A character string with the path to save the Excel files in.
#' Defaults to current working directory.
#' @param file A character string with the file name to save the Excel file.
#'   spreadsheet. By default spaces will be converted to underscores.
#' @param ... Sheet objects created using [sheet()].
#'
#' @return A list of sheets, with title and path for saving the Excel file.
#' @examples
#' results <- append_meta(
#'   results = iris,
#'   colname_descriptions = c(
#'     "Sepal.Length" = "Length of the sepal in cm",
#'     "Sepal.Width" = "Width of the sepal in cm",
#'     "Petal.Length" = "Length of the petal in cm",
#'     "Petal.Width" = "Width of the petal in cm",
#'     "Species" = "Species of iris"
#'   )
#' )
#' sheet1 <- sheet(results, "Sheet A", "Legend A")
#' sheet2 <- sheet(results, "Sheet B", "Legend B")
#' spreadsheet(
#'   sheet1, sheet2,
#'   title = "Supplementary Table X",
#'   path = tempdir(),
#'   file = "example_file.xlsx"
#' )
#' @export
spreadsheet <- function(...,
                        title,
                        path = getwd(),
                        file = "") {
  # Validate title, path and file
  if (!is.character(title) || length(title) != 1 || title == "") {
    stop("title must be a single character string.")
  }
  if (!is.character(path) || length(path) != 1) {
    stop("path must be a single character string.")
  }

  if (!is.character(file) || length(file) != 1) {
    stop("file must be a single character string.")
  }

  if (!dir.exists(path)) {
    stop("Directory specified to path does not exist.")
  }

  # Validate sheets
  sheets <- list(...)

  if (length(sheets) == 0) {
    stop("At least one sheet must be provided.")
  }

  if (!all(sapply(sheets, function(s) inherits(s, "sheet")))) {
    stop(
      "All additional arguments must be 'sheet' objects.",
      "Ensure you pass valid sheets."
    )
  }

  spreadsheet <- list(
    sheets = unlist(sheets, recursive = FALSE),
    title = title, path = path, file = file
  )
  class(spreadsheet) <- "spreadsheet"
  spreadsheet
}
