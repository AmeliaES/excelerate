#' Function to add column description metadata to README file
#'
#' @param wb openxlsx workbook object.
#' @param spreadsheet `spreadsheet` object created with [spreadsheet()].
#' @param nextFreeRow index of row with empty cell after writing sheet legends.
#'
#' @importFrom dplyr bind_rows
#' @noRd
add_meta <- function(wb, spreadsheet, nextFreeRow) {

  # extract the meta data from each results item
  meta_list <- lapply(spreadsheet$sheets, function(sheet) {

    # Extract column names
    column_names <- colnames(sheet$results)

    # Initialize a list to store comments
    Description <- sapply(column_names, function(col) comment(sheet$results[[col]]))

    # Create a dataframe from the comments
    metadata <- data.frame(Column_Name = column_names, Description = Description, stringsAsFactors = FALSE)

    rownames(metadata) <- NULL

    metadata

  })

  # combine all meta data into a single data frame and add id column
  col_name_descriptions <- bind_rows(meta_list, .id = "Sheet_Name")

  writeData(wb, sheet = "README", col_name_descriptions, startRow = nextFreeRow, startCol = 1)
}
