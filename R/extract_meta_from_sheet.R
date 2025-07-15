#' Extract Metadata from Excel Sheet
#'
#' Retrieves metadata, specifically comments, for each column in a given Excel
#' sheet.
#'
#' @param sheet A list containing the `results` data frame, typically
#'   representing an Excel sheet.
#'
#' @return A data frame containing the column names and their respective
#'   comments.
#' @noRd
extract_meta_from_sheet <- function(sheet) {
  # Extract column names
  column_names <- colnames(sheet$results)

  # Initialize a list to store comments
  description <- sapply(column_names, function(col) {
    comment(sheet$results[[col]])
  })

  # Create a dataframe from the comments
  metadata <- data.frame(
    Column_Name = column_names,
    Description = description,
    stringsAsFactors = FALSE
  )

  rownames(metadata) <- NULL

  metadata
}
