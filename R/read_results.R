#' Read Results and Sidecar Metadata Files
#'
#' This function reads CSV or TSV results files and their corresponding `.cols`
#' metadata files (created using [create_meta()]), returning them as a list.
#'
#' @details This function is called in [sheet()].
#'
#' @param full_path A character string with the full path to the CSV or TSV
#'   file.
#' @param sheet_legend A character string containing the table legend.
#'
#' @return A list containing: \item{main}{A data frame with the main results.}
#'   \item{meta}{A data frame with the metadata.} \item{sheet_legend}{A
#'   character string of the table legend.}
#'
#' @importFrom data.table fread
#' @importFrom readr read_csv
#'
#' @examples
#' # Create a temporary file for the example
#' temp_file <- tempfile(fileext = ".csv")
#'
#' # Write the mtcars dataset to the temporary file
#' write.csv(mtcars, temp_file, row.names = FALSE)
#'
#' # Use create_meta to generate a .cols file for mtcars
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
#'
#' # Read results using read_results
#' results <- read_results(temp_file, "Car dataset analysis")
#'
#' @noRd
read_results <- function(full_path, sheet_legend) {
  csv_path <- grep("\\.csv$|\\.tsv$", full_path, value = TRUE)

  # Use guard clauses to exit function early if error
  if (!file.exists(paste0(csv_path, ".cols"))) {
    stop(paste0('Cannot find meta data file with ".cols" extension for:',
                full_path))
  }

  main <- fread(csv_path)

  # Read in sidecar .cols files
  meta <- read_csv(paste0(csv_path, ".cols"), show_col_types = FALSE)

  # Return an error if these are not data frames
  stopifnot(is.data.frame(main), is.data.frame(meta))

  # Combine into a list
  results <- list(main = main, meta = meta, sheet_legend = sheet_legend)

  results
}
