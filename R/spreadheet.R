spreadsheet <- function(..., title, filename){
  sheets <- c(...)
  spreadsheet <- list(sheets = sheets, title = title, filename = filename)
  class(spreadsheet) <- "spreadsheet"
  spreadsheet
}
