#' Function to add column description metadata to README file
#'
#' @param wb openxlsx workbook object.
#' @param spreadsheet `spreadsheet` object created with [spreadsheet()].
#' @param nextFreeRow index of row with empty cell after writing sheet legends.
#'
#' @importFrom dplyr bind_rows
#' @importFrom openxlsx writeData createStyle addStyle
#' @noRd
add_meta_to_readme <- function(wb, spreadsheet, nextFreeRow) {

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

  # Leave an empty row before inserting metadata
  writeData(wb, sheet = "README", col_name_descriptions, startRow = nextFreeRow + 1, startCol = 1)

  # Style heading as italic
  italic_style <- createStyle(textDecoration = "italic")
  addStyle(wb, "README", italic_style, rows = nextFreeRow + 1, cols = 1:3)

  # Autofit cols
  autofit_cols(wb, col_name_descriptions, "README")

}
