#' Create .cols Sidecar Metadata File
#'
#' This function creates a .cols sidecar metadata file with column name
#' descriptions for a given table. It checks if all column names in the table
#' are described. The `.cols` file is saved in the same directory as the data
#' file, appending `.cols` to the original file name (e.g.,
#' `your_file.csv.cols`).
#'
#' @param results A data.frame to be marked up with comments for each column.
#'   generated.
#' @param colname_descriptions A named character vector where names match column
#'   names of `results` and values are their descriptions.
#'
#' @return A data.frame marked up with comments for each column.
#' @importFrom tibble tibble
#' @importFrom glue glue
#' @importFrom utils write.csv
#' @examples
#'
#' append_meta(
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
#'
#' @export
append_meta <- function(results, colname_descriptions) {
  # Check for missing descriptions
  if (any(!colnames(results) %in% names(colname_descriptions))) {
    missing_cols_idx <- which(!colnames(results) %in% names(colname_descriptions))
    missing_cols <- colnames(results)[missing_cols_idx]
    stop(glue::glue("Column names {paste(missing_cols, collapse = ', ')} in
                    the dataset are not all described in colname_descriptions"))
  }

  # Add comments to columns
  for (colname in names(colname_descriptions)) {
    if (colname %in% colnames(results)) {
      comment(results[[colname]]) <- colname_descriptions[[colname]]
    }
  }

  results
}
