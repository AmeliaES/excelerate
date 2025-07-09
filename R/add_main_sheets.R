#' Add main sheets to spreadsheet
#'
#' @param wb openxlsx workbook object
#' @param spreadsheet spreadsheet object from spreadsheet()
#'
add_main_sheets <- function(wb, spreadsheet){

  # extract the main data from spreadsheets sheets
  main_list <- lapply(spreadsheet$sheets, function(sheet) {
    sheet$main
  })

  # Add each table to a new sheet
  for (i in seq_along(spreadsheet$sheets)) {
    addWorksheet(wb, sheetName = names(spreadsheet$sheets)[i])
    writeData(wb, sheet = names(spreadsheet$sheets)[i], spreadsheet$sheets[[i]]$main, startRow = 1, colNames = TRUE)
  }
}
