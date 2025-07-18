#' Combine Sheets into a List for an Excel Spreadsheet
#'
#' Combines multiple sheets into a single structure with supplementary table
#' legend and filename for saving as Excel.
#'
#' @param title A character string with the legend title for the spreadsheet.
#' @param filename A character string with the path and file name for the Excel
#'   spreadsheet.
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
#' spreadsheet("Example Title", "example.xlsx", sheet1, sheet2)
#' @export
spreadsheet <- function(title, filename, ...) {
  # Validate title and filename
  if (!is.character(title) || length(title) != 1) {
    stop("Title must be a single character string.")
  }
  if (!is.character(filename) || length(filename) != 1) {
    stop("Filename must be a single character string.")
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
    title = title, filename = filename
  )
  class(spreadsheet) <- "spreadsheet"
  spreadsheet
}
