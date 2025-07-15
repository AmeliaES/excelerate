#' Resize Excel Column Widths Based on Content
#'
#' Adjusts the column widths in an Excel worksheet to fit the content based on
#' the number of characters, plus some padding.
#'
#' @param wb A `Workbook` object where the data resides.
#' @param data A data frame containing the data to be written to the Excel
#'   sheet.
#' @param sheet_name A string specifying the name of the sheet where the data is
#'   located.
#'
#' @return No return value. The function modifies the workbook's column widths
#'   directly.
#'
#' @importFrom openxlsx setColWidths
#' @noRd
autofit_cols <- function(wb, data, sheet_name) {
  # Go through each column and get the maximum number of characters in that col
  # add a small number to that to add a bit of extra spacing
  extra_char_n <- 4
  for (col in seq_len(ncol(data))) {
    col_max_width <- max(nchar(as.character(data[[col]])),
      na.rm = TRUE
    ) + extra_char_n
    openxlsx::setColWidths(wb,
      sheet = sheet_name, cols = col,
      widths = col_max_width
    )
  }
}
