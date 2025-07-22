#' Create and Save Excel Files for Supplementary Tables
#'
#' This function processes one or more `spreadsheet` objects (created with
#' [spreadsheet()]) and produces Excel files according to a set of customisable
#' naming templates. It applies user-specified patterns to rename data sheets
#' as well as update the spreadsheet title and file name.
#'
#' @param ... One or more `spreadsheet` objects created with [spreadsheet()].
#' @param sheet_template A character string template used to append prefix to
#' `sheet_name` supplied to [sheet()].
#'   The default is `"{n}{l} "`, where:
#'   \itemize{
#'     \item `"{n}"` is replaced with the sheet sequence number.
#'     \item `"{l}"` is replaced with a letter in order from A to Z.
#'   }
#'   eg. Sheet names will be prefixed with "A1 ", "B1 ", "C1 " etc.
#'   Note that if you have more than 26 sheets then `sheet_template` is ignored.
#' @param spreadsheet_template A character string template to append prefix to
#' spreadsheet `title` and `file` (supplied to [spreadsheet()]). The default
#' is `"S{n}"`, where `"{n}"` is replaced with the spreadsheet sequence number.
#' eg. "S1_filename.xlsx" for and "S1. Legend title" in README sheet. Note that
#' by default if spaces are detected in this string they are converted to
#' underscores for the file name, this is to aid file naming best practices.
#'
#' @importFrom openxlsx createWorkbook saveWorkbook loadWorkbook
#' @importFrom stringr str_detect str_replace_all
#' @importFrom magrittr %>%
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
#' # List files in tmp dir to see file created
#' list.files(temp_dir, pattern = "\\.xlsx$", full.names = TRUE)
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

  # if any spreadsheets have the same file name then stop with an error
  duplicated_file_names <- lapply(spreadsheets, function(spreadsheet) {
    spreadsheet$file
  }) %>% duplicated()

  if (any(duplicated_file_names) && spreadsheet_template == "") {
    stop(
      "Multiple spreadsheets cannot have the same filename ",
      "and missing spreadsheet_template."
    )
  }

  # For each spreadsheet object create an excel table
  for (n in seq_along(spreadsheets)) {
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
    # Remove white space from user supplied file name
    spreadsheets[[n]]$file <- stringr::str_replace_all(
      spreadsheets[[n]]$file, "\\s+", "_"
    )

    # Remove file if it exists before overwriting
    # this ensures success message to user is based on writting new file
    file_path <- file.path(spreadsheets[[n]]$path, spreadsheets[[n]]$file)

    if (file.exists(file_path)) {
      message("Removing existing file at: ", file_path)
      if (file.remove(file_path)) {
        message("Success. File removed.")
      } else {
        message("Failed to remove the file.")
      }
    }

    # Save spreadsheet to file
    saveWorkbook(wb, file_path, overwrite = FALSE)

    # if workbook saved successfully print a message to the user with the path
    # and file name
    if (file.exists(file_path)) {
      message(paste0("Excel file saved successfuly at: ", file_path))
    }
  }
}
