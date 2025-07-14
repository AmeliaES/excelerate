#' Annotate Data Frame with Column Descriptions
#'
#' Adds descriptions as comments to all columns in a given data frame.
#'
#' @param results A data.frame to be marked up with comments for each column.
#'   generated.
#' @param colname_descriptions A named character vector where names match column
#'   names of `results` and values are their descriptions.
#'
#' @return The input data.frame with comments added to each column.
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
    idx <- which(!colnames(results) %in% names(colname_descriptions))
    missing_cols <- colnames(results)[idx]
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
