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
#'   "Supplementary Table X",
#'   file.path(temp_dir, "example.xlsx"),
#'   sheet1, sheet2
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

  if (!is.character(spreadsheet_template)) {
    stop("spreadsheet_template must be a character string")
  }

  if (!is.character(sheet_template)) {
    stop("sheet_template must be a character string")
  }

  if (spreadsheet_template != "" && !stringr::str_detect(
    spreadsheet_template, "\\{n\\}"
  )) {
    stop('spreadsheet_template character string must contain "{n}"')
  }

  if (sheet_template != "" && !stringr::str_detect(sheet_template, "\\{n\\}")) {
    stop('sheet_template character string must contain "{n}"')
  }

  if (sheet_template != "" && !stringr::str_detect(sheet_template, "\\{l\\}")) {
    stop('sheet_template character string must contain "{l}"')
  }

  # For each spreadsheet object create an excel table
  lapply(seq_along(spreadsheets), function(n) {
    if (spreadsheet_template == "" && spreadsheets[[n]]$file == "") {
      stop("file and spreadsheet_template cannot both be an empty string")
    }

    # First append sheet_template and spreadsheet_template
    # to sheet_name, file and title

    if (spreadsheet_template != "") {
      # Append prefix to file name
      file <- spreadsheets[[n]]$file

      # Don't append _ on end if file empty
      new_file <- paste0(c(glue(spreadsheet_template), file),
        collapse = ifelse(file != "", "_", "")
      )

      # remove spaces from file and replace with "_"
      new_file <- stringr::str_replace_all(new_file, " ", "_")

      spreadsheets[[n]]$file <- new_file

      # Append prefix to title
      spreadsheets[[n]]$title <- paste0(
        glue(spreadsheet_template),
        ". ",
        spreadsheets[[n]]$title
      )
    }

    if (sheet_template != "") {
      # if there are more than 26 sheets then warn user that the sheet will not
      # be labeled with a prefix letter

      sheets <- spreadsheets[[n]]$sheets

      # Append prefix to sheet names for each sheet
      prefixed_names <- lapply(seq_along(sheets), function(i) {
        l <- LETTERS[i]
        sheet_prefix <- glue(sheet_template)
        og_name <- names(sheets[i])
        sheet_name <- paste0(sheet_prefix, og_name)

        # error if sheet names now exceeding max 31 characters
        if (nchar(sheet_name) > 31) {
          stop(
            "The sheet name, combined with the prefix (sheet_template),",
            "exceeds the maximum length of 31 characters.",
            "Please shorten sheet_name or adjust sheet_template."
          )
        }
        sheet_name
      })

      names(sheets) <- prefixed_names

      spreadsheets[[n]]$sheets <- sheets
    }

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
