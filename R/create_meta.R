#' Create .cols Sidecar Metadata File
#'
#' This function creates a .cols sidecar metadata file with column name
#' descriptions for a given table. It checks if all column names in the table
#' are described. The `.cols` file is saved in the same directory as the data
#' file, appending `.cols` to the original file name (e.g.,
#' `your_file.csv.cols`).
#'
#' @param file_name A character string specifying the absolute path
#'  and file name for the file for which metadata is being generated.
#' @param table_variable_name A data frame for which metadata is being
#'   generated.
#' @param colname_descriptions A named character vector where names match column
#'   names of `table_variable_name` and values are their descriptions.
#'
#' @return Invisibly returns \code{NULL}. The function performs file creation as
#'   a side effect.
#' @importFrom tibble tibble
#' @importFrom glue glue
#' @importFrom utils write.csv
#' @examples
#' temp_dir <- tempdir()
#' temp_file <- file.path(temp_dir, "example.csv")
#' write.csv(mtcars, temp_file, row.names = FALSE)
#'
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
#' # Clean up the temporary files
#' unlink(c(temp_file, paste0(temp_file, ".cols")))
#' @export
create_meta <- function(file_name, table_variable_name, colname_descriptions) {
  colname_descriptions_table <- tibble(
    column = names(colname_descriptions),
    description = colname_descriptions
  )

  if (any(colname_descriptions_table$column != colnames(table_variable_name))) {
    stop(glue("Column names in {file_name}
              are not all described in colname_descriptions"))
  }

  write.csv(colname_descriptions_table,
            paste0(file_name, ".cols"),
            row.names = FALSE)
}
