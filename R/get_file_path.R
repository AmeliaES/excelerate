#' Get all the files in a directory from the path that match a pattern
#'
#' @param path path to directory where files for supplementary tables exist
#' @param pattern pattern to subset files in the directory
#'
#' @return Character vector of full paths to files
#' @importFrom stringr str_subset
#'
#' @examples
#' get_file_path("path/to/data/", "extract_matching_files")
get_file_path <- function(path, pattern){
  # Check dir exists at path
  if(!dir.exists(path)){
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
  if (!any(grepl("\\.csv$", files)) & !any(grepl("\\.tsv$", files)) & !any(grepl("\\.col$", files))) {
    stop(paste0("No csv or tsv files found at: ", path, " with pattern: ", pattern))
  }

  # Subset to only return .tsv or .csv file
  file <- str_subset(files, "\\.csv$|\\.tsv$")

  # Stop if more than one file is found
  if(length(file) > 1){
    stop(paste0("More than one file is found at: ", path, " with pattern: ", pattern))
  }

  # Print message to user of files that match
  message("File that match pattern: \n", paste0(file, collapse = "\n"))

  files

}

