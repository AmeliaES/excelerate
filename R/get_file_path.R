#' Retrieve Matching Files from a Directory
#'
#' This function retrieves files from a specified directory that match a given
#' pattern and returns their full paths.
#'
#' @details Output from this function is used as input to [read_results()].
#' Called in [sheet()].
#'
#' @param path A character string specifying the path to the directory
#'   containing the files.
#' @param pattern A regular expression pattern to filter files within the
#'   directory.
#' @return A character vector of the full paths to the files that match the
#'   pattern.
#' @importFrom stringr str_subset
#'
#' @examples
#' # Example usage with a temporary directory
#' temp_dir <- tempdir()
#' file.create(file.path(temp_dir, "example_file.csv"))
#' get_file_path(temp_dir, "example")
#'
#' @noRd
get_file_path <- function(path, pattern) {
  # Check dir exists at path
  if (!dir.exists(path)) {
    stop(paste0("No directory at path: ", path))
  }

  files <- list.files(path, full.names = TRUE)
  files <- str_subset(files, pattern)

  # If there are no files stop with error
  if (length(files) == 0) {
    stop(paste0("No file found at: ", path, " with pattern: ", pattern))
  }

  # If files are found, check if they all end with .csv, .tsv or .cols
  # If they are not csv or tsv, stop with error
  if (!any(grepl("\\.csv$", files)) &&
        !any(grepl("\\.tsv$", files)) &&
        !any(grepl("\\.col$", files))) {
    stop(paste0(
      "No csv or tsv files found at: ",
      path, " with pattern: ", pattern
    ))
  }

  # Subset to only return .tsv or .csv file
  file <- str_subset(files, "\\.csv$|\\.tsv$")

  # Stop if more than one file is found
  if (length(file) > 1) {
    stop(paste0(
      "More than one file is found at: ",
      path, " with pattern: ", pattern
    ))
  }

  # Print message to user of files that match
  message("File that match pattern: \n", paste0(file, collapse = "\n"))

  files
}
