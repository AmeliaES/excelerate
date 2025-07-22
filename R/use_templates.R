# Append enumeration eg. "S1" to file name/legend& and "A1" to sheet names This
# script contains 3 functions: use_spreadsheet_template(), use_sheet_template()
# and append_sheet_prefix()


#' Apply Spreadsheet Template to File and Title
#'
#' Appends a formatted prefix to the `file` and `title` fields of a spreadsheet
#' object using the specified `spreadsheet_template`. The template must contain
#' `{n}`, which is replaced by the spreadsheet table number.
#'
#' @param spreadsheet_template A character string template containing `{n}` for
#' numbering.
#' @param spreadsheet A `spreadsheet` object to modify.
#' @param n An integer spreadsheet table number.
#'
#' @return A modified `spreadsheet` object with updated `file` and `title`.
#'
#' @noRd
use_spreadsheet_template <- function(spreadsheet_template,
                                     spreadsheet,
                                     n) {
  if (!is.character(spreadsheet_template)) {
    stop("spreadsheet_template must be a character string")
  }

  if (spreadsheet_template != "" && !stringr::str_detect(
    spreadsheet_template, "\\{n\\}"
  )) {
    stop('spreadsheet_template character string must contain "{n}"')
  }

  if (spreadsheet_template == "" && spreadsheet$file == "") {
    stop("file and spreadsheet_template cannot both be an empty string")
  }

  # First append sheet_template and spreadsheet_template
  # to sheet_name, file and title

  if (spreadsheet_template != "") {
    # Append prefix to file name
    file <- spreadsheet$file

    # Don't append _ on end if file empty
    new_file <- paste0(c(glue(spreadsheet_template), file),
      collapse = ifelse(file != "", "_", "")
    )

    # remove white space from file and replace with "_"
    new_file <- stringr::str_replace_all(new_file, "\\s+", "_")

    spreadsheet$file <- new_file

    # Append prefix to title
    spreadsheet$title <- paste0(
      glue(spreadsheet_template),
      ". ",
      spreadsheet$title
    )
  }

  spreadsheet
}

#' Apply Sheet Template to Sheet Names
#'
#' Appends a prefix to each sheet name in a spreadsheet object using a template
#' that includes `{n}` for the spreadsheet table number and `{l}` for the sheet
#' letter (A–Z).
#'
#' @param sheet_template A character string containing `{n}` and `{l}` to define
#' sheet prefixes.
#' @param spreadsheet A `spreadsheet` object whose sheet names will be updated.
#' @param n An integer representing the spreadsheet table number.
#'
#' @return A modified `spreadsheet` object with updated sheet names.
#'
#' @noRd
use_sheet_template <- function(sheet_template,
                               spreadsheet,
                               n) {
  # Use guard clauses to exit function early if conditions met
  if (is.null(sheet_template) || sheet_template == "") {
    return(spreadsheet)
  }

  if (!stringr::str_detect(sheet_template, "\\{n\\}")) {
    stop('sheet_template character string must contain "{n}"')
  }

  sheets <- spreadsheet$sheets

  template_not_empty <- sheet_template != ""
  detect_l <- !stringr::str_detect(sheet_template, "\\{l\\}")
  multiple_sheets <- length(sheets) > 1

  if (template_not_empty && detect_l && multiple_sheets) {
    stop('sheet_template character string must contain "{l}"')
  }

  # Append prefix to sheet names for each sheet
  prefixed_names <- lapply(seq_along(sheets), function(i) {
    # if there's only one sheet then remove the letter from sheet_template
    if (length(sheets) == 1) {
      sheet_template <- stringr::str_remove(sheet_template, "\\{l\\} ")
    }
    append_sheet_prefix(i, sheet_template, sheets[i], n)
  })

  names(sheets) <- prefixed_names

  spreadsheet$sheets <- sheets

  spreadsheet
}

#' Generate Prefixed Sheet Name
#'
#' Constructs a new sheet name by prepending a formatted prefix (based on
#' `sheet_template`) to the original sheet name. The prefix includes a letter
#' (`{l}`) and index (`{n}`).
#' Checks that the resulting name does not exceed Excel's 31-character limit.
#'
#' @param i Sheet index within the spreadsheet.
#' @param sheet_template A character string template including `{n}` and `{l}`.
#' @param sheets A list of sheets from the spreadsheet object.
#' @param n The spreadsheet index, used in the template.
#'
#' @return A character string containing the new sheet name.
#'
#' @noRd
append_sheet_prefix <- function(i, sheet_template, sheet, n) {
  l <- openxlsx2::int2col(i) # returns "AA" for int2col(27) etc.
  sheet_prefix <- glue::glue(sheet_template)
  sheet_name <- names(sheet)
  numbered_sheet_name <- paste0(sheet_prefix, sheet_name)

  # error if sheet names now exceeding max 31 characters
  if (nchar(numbered_sheet_name) > 31) {
    stop(
      "The sheet name, combined with the prefix (sheet_template),",
      "exceeds the maximum length of 31 characters.",
      "Please shorten sheet_name or adjust sheet_template."
    )
  }
  numbered_sheet_name
}
