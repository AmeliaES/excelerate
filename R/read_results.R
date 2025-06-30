#' Function to read in the results tables and sidecar .cols files
#'
#' @param full_path full path to csv
#'
#' @importFrom data.table fread
#' @importFrom readr read_csv
#'
read_results <- function(full_path) {
  csv_path <- grep("\\.csv$", full_path, value = TRUE)

  # Use guard clauses to exit function early if error
  if(!file.exists(paste0(csv_path, ".cols"))){
    stop(paste0('Cannot find meta data file with ".cols" extension for:', full_path))
  }

  main <- fread(csv_path)

  # Read in sidecar .cols files
  meta <- read_csv(paste0(csv_path, ".cols"), show_col_types = FALSE)

  # Return an error if these are not data frames
  stopifnot(is.data.frame(main), is.data.frame(meta))

  # Combine into a list
  results <- list(main = main, meta = meta)

  return(results)
}
