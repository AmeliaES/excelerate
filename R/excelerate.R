#' Create and Save Excel Files with Supplementary Tables
#'
#' This function creates and saves Excel files from given spreadsheet objects.
#'
#' @param ... One or more `spreadsheet` objects created with [spreadsheet()].
#' @param sheet_template Enumerate sheet name with table number and a letter
#' @param spreadsheet_template Enumerate spreadsheet title and file.
#'
#' @importFrom openxlsx createWorkbook saveWorkbook loadWorkbook
#' @importFrom stringr str_detect str_replace_all
#' @examples
#' temp_dir <- tempdir()
#'
#' results <- append_meta(
#'   results = iris,
#'   colname_descriptions = c(
#'     "Sepal.Length" = "Length of the sepal in cm",
#'     "Sepal.Width" = "Width of the sepal in cm",
#'     "Petal.Length" = "Length of the petal in cm",
#'     "Petal.Width" = "Width of the petal in cm",
#'     "Species" = "Species of iris"
#'   )
#' )
#'
#' sheet1 <- sheet(results, "Sheet A", "Legend A")
#' sheet2 <- sheet(results, "Sheet B", "Legend B")
#'
#' sp <- spreadsheet(
#'   sheet1, sheet2,
#'   title = "Supplementary Table X",
#'   path = tempdir(),
#'   file = "example_file.xlsx"
#' )
#'
#' excelerate(sp)
#'
#' # Clean up the temporary files
#' unlink(file.path(temp_dir, "example.xlsx"))
#' @export
excelerate <- function(...,
                       sheet_template = "{n}{l} ",
                       spreadsheet_template = "S{n}") {
  # Check input to function are all of class "spreadsheet"
  spreadsheets <- list(...)

  if (any(sapply(spreadsheets, class) != "spreadsheet")) {
    stop("Non spreadsheet class used as input to excelerate")
  }

  # For each spreadsheet object create an excel table
  lapply(seq_along(spreadsheets), function(n) {
    # Update spreadsheet title and file name
    spreadsheets[[n]] <- use_spreadsheet_template(
      spreadsheet_template,
      spreadsheets[[n]],
      n
    )

    spreadsheets[[n]] <- use_sheet_template(
      sheet_template,
      spreadsheets[[n]],
      n
    )

    # Function that creates excel table
    wb <- createWorkbook()

    # Function that creates README sheet:
    add_readme(wb)

    # Insert into README sheet:
    # Function that writes the sheet summary
    # (using "sheet_legend" from sheet() )
    next_free_row <- add_sheet_legend(wb, spreadsheets[[n]])

    # Function that writes column meta data to README sheet
    # (using "meta" from sheet() )
    add_meta_to_readme(wb, spreadsheets[[n]], next_free_row)

    # Function that creates data sheets
    # (using "main" from sheet(), and name of sheet from sheet())
    add_main_sheets(wb, spreadsheets[[n]])

    # Function that writes legend title for the excel table
    # (using "title" from spreadsheet())
    add_legend_title(wb, spreadsheets[[n]]$title)

    # If .xlsx is not at the end of the file then
    # Append .xlsx to end of file
    if (!grepl("\\.xlsx$", spreadsheets[[n]]$file, ignore.case = TRUE)) {
      spreadsheets[[n]]$file <- paste0(spreadsheets[[n]]$file, ".xlsx")
    }

    # Write the spreadsheet to excel file
    saveWorkbook(wb, file.path(spreadsheets[[n]]$path, spreadsheets[[n]]$file),
      overwrite = TRUE
    )
  })
}
