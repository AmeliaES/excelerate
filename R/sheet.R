#' Read File Path, Pattern, Sheet Name, and Legend
#'
#' This function reads a file matching a pattern from a given directory and
#' returns supplementary table data.
#'
#' @param path A character string specifying the path to the directory
#'   containing the files.
#' @param pattern A regular expression pattern to filter files within the
#'   directory.
#' @param sheet_name A character string for naming the sheet.
#' @param sheet_legend A character string containing the table legend.
#'
#' @return A named nested list containing the main results (data frame),
#'   metadata (data frame), and sheet legend. Named by `sheet_name`.
#' @importFrom data.table fread
#' @examples
#' temp_dir <- tempdir()
#' temp_file <- file.path(temp_dir, "example.csv")
#' write.csv(mtcars, temp_file, row.names = FALSE)
#' create_meta(
#'   file_name = temp_file,
#'   table_variable_name = mtcars,
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
#' sheet(temp_dir, "example\\.csv$", "Example Sheet", "An example legend")
#'
#' # Clean up the temporary files
#' unlink(c(temp_file, paste0(temp_file, ".cols")))
#' @export
sheet <- function(path, pattern, sheet_name, sheet_legend) {
  # Get path to the results file
  file_path <- get_file_path(path, pattern)

  # Read each file and return a list of dataframes
  dataframes <- read_results(file_path, sheet_legend)

  # Create a list item
  dataframes <- list(dataframes)

  # Name the dataframes by the supplied sheet name
  names(dataframes) <- sheet_name

  dataframes
}
