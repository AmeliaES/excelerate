#' Create and Save Excel Files with Supplementary Tables
#'
#' This function creates and saves Excel files from given spreadsheet objects.
#'
#' @param ... One or more `spreadsheet` objects created with [spreadsheet()].
#'
#' @importFrom openxlsx createWorkbook saveWorkbook
#' @examples
#' temp_dir <- tempdir()
#'
#' results <- append_meta(
#'   results = mtcars,
#'   colname_descriptions = c(
#'     "mpg" = "Miles/(US) gallon",
#'     "cyl" = "Number of cylinders",
#'     "disp" = "Displacement (cu.in.)",
#'     "hp" = "Gross horsepower",
#'     "drat" = "Rear axle ratio",
#'     "wt" = "Weight (1000 lbs)",
#'     "qsec" = "1/4 mile time",
#'     "vs" = "Engine (0 = V-shaped, 1 = straight)",
#'     "am" = "Transmission (0 = automatic, 1 = manual)",
#'     "gear" = "Number of forward gears",
#'     "carb" = "Number of carburetors"
#'   )
#' )
#'
#' sheet1 <- sheet(results, "Sheet A", "Legend A")
#' sheet2 <- sheet(results, "Sheet B", "Legend B")
#'
#' sp <- spreadsheet(
#'   "Supplementary Table X",
#'   file.path(temp_dir, "example.xlsx"),
#'   sheet1, sheet2)
#'
#' excelerate(sp)
#'
#' # Clean up the temporary files
#' unlink(paste0(temp_dir, "/example.xlsx"))
#' @export
excelerate <- function(...) {
  # Check input to function are all of class "spreadsheet"
  spreadsheets <- list(...)

  if (any(sapply(spreadsheets, class) != "spreadsheet")) {
    stop("Non spreadsheet class used as input to excelerate")
  }

  # For each spreadsheet object create an excel table
  lapply(spreadsheets, function(spreadsheet) {
    # Function that creates excel table
    wb <- createWorkbook()

    # Function that creates README sheet:
    add_readme(wb)

    # Insert into README sheet:
    # Function that writes legend title for the excel table
    # (using "title" from spreadsheet())
    add_legend_title(wb, spreadsheet$title)

    # Function that writes the sheet summary
    # (using "sheet_legend" from sheet() )
    next_free_row <- add_sheet_legend(wb, spreadsheet)

    # Function that writes column meta data to README sheet
    # (using "meta" from sheet() )
    add_meta_to_readme(wb, spreadsheet, next_free_row)

    # Function that creates data sheets
    # (using "main" from sheet(), and name of sheet from sheet())
    add_main_sheets(wb, spreadsheet)

    # Write the spreadsheet to excel file
    saveWorkbook(wb, spreadsheet$filename, overwrite = TRUE)
  })
}
