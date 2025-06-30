#' Read in file paths and return a list of dataframes
#'
#' @param path path to directory where files for supplementary tables exist
#' @param pattern pattern to subset files in the directory
#'
#' @returns a list of data frames
#' @importFrom data.table fread
#'
read_files_to_list <- function(path, pattern = NULL, sheet_names){

  # Get paths to all the files
  file_paths <- get_file_paths(path, pattern)

  # Read each file and return a list of dataframes
  dataframes <- lapply(file_paths, read_results)

  # Name the dataframes by the supplied sheet names
  names(dataframes) <- sheet_names

  dataframes
}
