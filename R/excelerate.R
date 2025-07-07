#' Create and save supplementary tables as excel files
#'
#' @param ... One or more spreadsheet objects returned from the `spreadsheet()` function.
#'
#' @export
#' @importFrom openxlsx createWorkbook
#'
excelerate <- function(...){
  # Check input to function are all of class "spreadsheet"
  spreadsheets <- list(...)

  if(any(sapply(spreadsheets, class) != "spreadsheet")){
    stop("Non spreadsheet class used as input to excelerate")
  }

  # For each spreadsheet object create an excel table
  lapply(spreadsheets, function(spreadsheet){

    # Function that creates excel table
    wb <- createWorkbook()

      # Function that creates README sheet:
      add_readme(wb, spreadsheet)

      # Insert into README sheet:
        # Function that writes legend title for the excel table (using "title" from spreadsheet())
        add_legend_title(wb, spreadsheet$title)

        # Function that writes the sheet summary (using "sheet_legend" from sheet() )
        nextFreeRow <- add_sheet_legend(wb, spreadsheet)

        # Function that writes column meta data (using "meta" from sheet() )
        add_meta(wb, spreadsheet, nextFreeRow)

      # Function that creates data sheets (using "main" from sheet(), and name of sheet from sheet())

  })
}
