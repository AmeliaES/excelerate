spreadsheet <- function(..., title, filename){
  sheets <- c(...)
  list(sheets = sheets, title = title, filename = filename)
}
