% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spreadheet.R
\name{spreadsheet}
\alias{spreadsheet}
\title{Combine Sheets into a List for an Excel Spreadsheet}
\usage{
spreadsheet(..., title, path = getwd(), file = "")
}
\arguments{
\item{...}{Sheet objects created using \code{\link[=sheet]{sheet()}}.}

\item{title}{A character string with the legend title for the spreadsheet.}

\item{path}{A character string with the path to save the Excel files in.
Defaults to current working directory.}

\item{file}{A character string with the file name to save the Excel file.
spreadsheet. By default spaces will be converted to underscores.}
}
\value{
A list of sheets, with title and path for saving the Excel file.
}
\description{
Combines multiple sheets into a single structure with supplementary table
legend and file name for saving as Excel.
}
\examples{
results <- append_meta(
  results = iris,
  colname_descriptions = c(
    "Sepal.Length" = "Length of the sepal in cm",
    "Sepal.Width" = "Width of the sepal in cm",
    "Petal.Length" = "Length of the petal in cm",
    "Petal.Width" = "Width of the petal in cm",
    "Species" = "Species of iris"
  )
)
sheet1 <- sheet(results, "Sheet A", "Legend A")
sheet2 <- sheet(results, "Sheet B", "Legend B")
spreadsheet(
  sheet1, sheet2,
  title = "Supplementary Table X",
  path = tempdir(),
  file = "example_file.xlsx"
)
}
