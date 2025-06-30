#' Function to read in the results tables and sidecar .cols files
#'
#' @param full_path full path to csv
#'
#' @importFrom data.table fread
#' @importFrom readr read_csv
#'
read_results <- function(full_path) {
  # Sometimes fread does not read csvs correctly eg. if there is an extraneous comma at the end of a line
  # in this case read_csv() can be used instead, however it is slower

  # Use gaurd clauses to exit function early if error
  if(!file.exists(paste0(full_path, ".cols"))){
    stop(paste0('Cannot find meta data file with ".cols" extension for:', full_path))
  }

  main <- fread(full_path)

  # Read in sidecar .cols files
  meta <- read_csv(paste0(full_path, ".cols"))

  # Return an error if these are not data frames
  stopifnot(is.data.frame(main), is.data.frame(meta))

  # Combine into a list
  results <- list(main = main, meta = meta)

  return(results)
}
