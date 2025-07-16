#' Append column descriptions as comments to data frame
#'
#' This function annotates your data frame with descriptions for each column,
#' which is then inserted as a table in the first sheet ("README" sheet)
#' of your Excel spreadsheet.
#'
#' @param results A data.frame marked up with comments for each column.
#' @param sheet_name A character string for naming the sheet.
#' @param sheet_legend A character string containing the table legend.
#'
#' @return A named nested list containing the main results (data frame),
#'   metadata (data frame), and sheet legend. Named by `sheet_name`.
#' @importFrom data.table fread
#' @examples
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
#' sheet(results, "Example Sheet", "An example legend")
#'
#' @export
sheet <- function(results, sheet_name, sheet_legend) {
  # Return early with errors:
  if (any(rownames(results) != as.character(seq_len(nrow(results))))) {
    stop("Row names of data frame passed to 'results' should be NULL.")
  }

  if (nchar(sheet_name) > 31) {
    stop(paste0(
      "Sheet name '", sheet_name,
      "' exceeds the 31-character limit."
    ))
  }

  for (i in seq_along(results)) {
    if (is.null(comment(results[[i]]))) {
      stop("Each column in the data frame must have a comment attribute.")
    }
  }

  # Create nested list so function returns sheet_name$results and
  # sheet_name$sheet_legend
  sheet <- list()
  sheet[[sheet_name]] <- list(results = results, sheet_legend = sheet_legend)

  class(sheet) <- "sheet"

  sheet
}
