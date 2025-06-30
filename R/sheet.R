#' Read in file paths, pattern and sheet name
#'
#' @param path path to directory where files for supplementary tables exist
#' @param pattern pattern to subset files in the directory
#'
#' @returns a list of data frames
#' @importFrom data.table fread
#'
sheet <- function(path, pattern = NULL, sheet_names){

  # Get path to the results file
  file_path <- get_file_path(path, pattern)

  # Read each file and return a list of dataframes
  dataframes <- read_results(file_path)

  # Create a list item
  dataframes <- list(dataframes)

  # Name the dataframes by the supplied sheet names
  names(dataframes) <- sheet_names

  dataframes
}
