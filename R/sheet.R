#' Read File Path, Pattern, Sheet Name, and Legend
#'
#' This function reads a file matching a pattern from a given directory and
#' returns supplementary table data.
#'
#' @param results A data.frame marked up with comments for each column.
#' @param sheet_name A character string for naming the sheet.
#' @param sheet_legend A character string containing the table legend.
#'
#' @return A named nested list containing the main results (data frame),
#'   metadata (data frame), and sheet legend. Named by `sheet_name`.
#' @importFrom data.table fread
#' @examples
#'
#' create_meta(
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
#' sheet(mtcars, "Example Sheet", "An example legend")
#'
#' @export
sheet <- function(results, sheet_name, sheet_legend) {

  # Create nested list so function returns sheet_name$results and sheet_name$sheet_legend
  output <- list()
  output[[sheet_name]] <- list(results = results, sheet_legend = sheet_legend)

  output
}
