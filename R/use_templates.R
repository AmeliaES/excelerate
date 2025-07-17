# Functions to append enumeration string eg. "S1" to file name and legend
# and "A1" to sheet names
# called in excelerate()


use_spreadsheet_template <- function(spreadsheet_template,
                                     spreadsheet,
                                     n) {
  if (!is.character(spreadsheet_template)) {
    stop("spreadsheet_template must be a character string")
  }

  if (spreadsheet_template != "" && !stringr::str_detect(
    spreadsheet_template, "\\{n\\}"
  )) {
    stop('spreadsheet_template character string must contain "\\{n\\}"')
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

    # remove spaces from file and replace with "_"
    new_file <- stringr::str_replace_all(new_file, " ", "_")

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


use_sheet_template <- function(sheet_template,
                               spreadsheet,
                               n) {
  # Use guard clauses to exit function early if conditions met
  if (is.null(sheet_template) || sheet_template == "") {
    return(spreadsheet)
  }

  # if there are more than 26 sheets then warn user that the sheet will not
  # be labeled with a prefix letter and exit function early
  sheets <- spreadsheet$sheets

  if (length(sheets) > 26) {
    warning(
      "More than 26 sheets in spreadsheet.",
      "Sheets will not be labelled with a letter prefix."
    )
    return(spreadsheet)
  }

  if (!stringr::str_detect(sheet_template, "\\{n\\}")) {
    stop('sheet_template character string must contain "\\{n\\}"')
  }

  if (sheet_template != "" && !stringr::str_detect(sheet_template, "\\{l\\}")) {
    stop('sheet_template character string must contain "\\{l\\}"')
  }

  # Append prefix to sheet names for each sheet
  prefixed_names <- lapply(seq_along(sheets), function(i) {
    append_sheet_prefix(i, sheet_template, sheets, n)
  })

  names(sheets) <- prefixed_names

  spreadsheet$sheets <- sheets

  spreadsheet
}


append_sheet_prefix <- function(i, sheet_template, sheets, n) {
  l <- LETTERS[i]
  sheet_prefix <- glue::glue(sheet_template)
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
}
