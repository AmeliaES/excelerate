# excelerate <a href="https://ameliaes.github.io/excelerate/"><img src="man/figures/logo.png" align="right" height="120" alt="excelerate website" /></a>

<!-- badges: start -->
  [![R-CMD-check](https://github.com/AmeliaES/excelerate/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/AmeliaES/excelerate/actions/workflows/R-CMD-check.yaml) [![Codecov test coverage](https://codecov.io/gh/AmeliaES/excelerate/graph/badge.svg)](https://app.codecov.io/gh/AmeliaES/excelerate)
  
<!-- badges: end -->

The excelerate package accelerates the creation of supplementary tables for research papers.

- **Data Frame Conversion**: Easily insert supplementary results as ordered, numbered sheets in Excel spreadsheets.
- **Metadata Integration**: Include comprehensive metadata with legends and column descriptions in a README sheet.
- **Numbered Supplementary Files**: Automatically organises and numbers sheets and supplementary files for easy reference.
- **Efficient Workflow**: Accelerates the preparation of standardised, publication-ready tables.

This makes excelerate an invaluable tool for researchers looking to efficiently prepare tables that meet journal specifications.

## Installation

``` r
install.packages("devtools")
devtools::install_github("ameliaes/excelerate")
library(excelerate)
```

## Usage

### 1. Append Meta Data

Use `append_meta()` to add column descriptions to your data frame. This function annotates your data frame with descriptions for each column, which is then inserted as a table in the first sheet ("README" sheet) of your Excel spreadsheet.

``` r
# Create metadata for mtcars dataset
mtcars_commented <- append_meta(results = mtcars,
                      colname_descriptions =
                      c(
                      "mpg" = "Miles/(US) gallon",
                      "cyl" = "Number of cylinders",
                      "disp" = "Displacement (cu.in.)",
                      "hp" = "Gross horsepower",
                      "drat" = "Rear axle ratio",
                      "wt" = "Weight (1000 lbs)",
                      "qsec" = "1/4 mile time",
                      "vs" = "Engine (0 = V-shaped, 1 = straight)",
                      "am" = "Transmission (0 = automatic, 1 = manual)",
                      "gear" = "Number of forward gears",
                      "carb" = "Number of carburetors"
                       ))
```

### 2. Generate Excel Files

Use the `sheet()`, `spreadsheet()` and `excelerate()` functions to create and save the tables.

``` r
# Create spreadsheet specifying tables for each sheet
supplementary_table <- spreadsheet(
  title = "Supplementary Table 1. This is space for a legend title describing
  generally the contents of the file.",
  filename = "path/to/save/example_table.xlsx",
  sheet(mtcars_commented, "Sheet name 1", "Specific legends for each table can 
  go here. eg. a description of the mtcars data frame can go here."),
  sheet(sheet_2_dataframe, "Sheet name 2", "Sheet legend 2"),
  sheet(sheet_3_dataframe, "Sheet name 3", "Sheet legend 3"),
)

# Export to Excel
excelerate(supplementary_table)
```

Please see the [`Get Started`](https://ameliaes.github.io/excelerate/articles/excelerate.html) page for more detailed instructions.

### Output

The output is an excel file with multiple sheets. 

- The first sheet is called "README" by default.
  The README sheet cells contain the following in order:
  - The `title` specified in `spreadsheet()`.
  - The `sheet_legend`s, specified in `sheet()`, for each sheet.
  - The meta data supplied to `append_meta()`, for each sheet.
- The remaining sheets are the data frames supplied to `sheet()`. In the order each sheet object was supplied to `spreadsheet()`.
