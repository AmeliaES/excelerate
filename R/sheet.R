#' Read in file path, file pattern, sheet name and sheet legend
#'
#' @param path character string with path to directory where files for supplementary tables exist
#' @param pattern character string with pattern to identify one file in the directory
#' @param sheet_name character string sheet name for table
#' @param sheet_legend character string containing table legend
#'
#' @returns Named nested list of dataframes containing the main results (data frame),
#' the metadata (data frame) and sheet legend (character string).
#' Named by sheet_name.
#' @importFrom data.table fread
#'
#' @export
#' @examples
#' \dontrun{
#' sheet("path/to/data/", "file_name", "sheet name", "sheet legend")
#' }
sheet <- function(path, pattern, sheet_name, sheet_legend){

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
