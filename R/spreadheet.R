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
#' results <- create_meta(
#'   results = mtcars,
#'   colname_descriptions = c(
#'     "mpg" = "Miles/(US) gallon",
#'     "cyl" = "Number of cylinders",
#'     "disp" = "Displacement (cu.in.)",
#'     "hp" = "Gross horsepower",
#'     "drat" = "Rear axle ratio",
#'     "wt" = "Weight (1000 lbs)",
#'     "qsec" = "1/4 mile time",
#'     "vs" = "Engine (0 = V-shaped, 1 = straight)",
#'     "am" = "Transmission (0 = automatic, 1 = manual)",
#'     "gear" = "Number of forward gears",
#'     "carb" = "Number of carburetors"
#'   )
#' )
#' sheet1 <- sheet(results, "Sheet A", "Legend A")
#' sheet2 <- sheet(results, "Sheet B", "Legend B")
#' spreadsheet("Example Title", "example.xlsx", sheet1, sheet2)
#' @export
spreadsheet <- function(title, filename, ...) {
  sheets <- c(...)
  spreadsheet <- list(sheets = sheets, title = title, filename = filename)
  class(spreadsheet) <- "spreadsheet"
  spreadsheet
}
