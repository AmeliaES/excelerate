autofit_cols <- function(wb, data, sheet_name) {
  # Apply autofit for the data
  for (col in seq_len(ncol(data))) {
    col_max_width <- max(nchar(as.character(data[[col]])), na.rm = TRUE) + 4
    setColWidths(wb, sheet = sheet_name, cols = col, widths = col_max_width)
  }
}
