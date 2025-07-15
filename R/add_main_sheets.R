#' Add Main Sheets to Workbook
#'
#' This function adds main data sheets to an openxlsx workbook object using a
#' spreadsheet object.
#'
#' @param wb An openxlsx workbook object.
#' @param spreadsheet `spreadsheet` object created with [spreadsheet()].
#' @importFrom openxlsx addWorksheet writeData setColWidths
#' @noRd
add_main_sheets <- function(wb, spreadsheet) {
  # Add each table to a new sheet
  for (i in seq_along(spreadsheet$sheets)) {
    openxlsx::addWorksheet(wb, sheetName = names(spreadsheet$sheets)[i])

    openxlsx::writeData(wb,
      sheet = names(spreadsheet$sheets)[i],
      spreadsheet$sheets[[i]]$results,
      startRow = 1,
      colNames = TRUE
    )

    # Autofit the widths of all the columns in the results dataframe
    n_cols <- ncol(spreadsheet$sheets[[i]]$results)

    openxlsx::setColWidths(wb,
      sheet = names(spreadsheet$sheets)[i],
      cols = c(1:n_cols),
      widths = "auto"
    )
  }
}
