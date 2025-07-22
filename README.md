# excelerate <a href="https://ameliaes.github.io/excelerate/"><img src="man/figures/logo.png" align="right" height="120" alt="excelerate website" /></a>

<!-- badges: start -->
  [![R-CMD-check](https://github.com/AmeliaES/excelerate/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/AmeliaES/excelerate/actions/workflows/R-CMD-check.yaml) [![Codecov test coverage](https://codecov.io/gh/AmeliaES/excelerate/graph/badge.svg)](https://app.codecov.io/gh/AmeliaES/excelerate)
  
<!-- badges: end -->

The excelerate package accelerates the creation of supplementary tables for research papers.

- **Data Frame Conversion**: Easily insert supplementary results as ordered, numbered sheets in Excelspreadsheets.
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

Use `append_meta()` to add column descriptions to your data frame. This function annotates your data frame with descriptions for each column, which is then inserted as a table in the first sheet (the "README" sheet) of your Excelspreadsheet.

``` r
# Create metadata for iris dataset
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
```

### 2. Generate ExcelFiles

Use the `sheet()`, `spreadsheet()` and `excelerate()` functions to create and save the tables.

`sheet()` takes the output from `append_meta()` (ie. a data frame where each column has an associated description explaining its contents), the name of the sheet (which appears in the tabs in Excelfiles) and a table legend for each sheet.

```r
sheet1 <- sheet(
  results,
  "Sheet name 1",
  "Specific legends for each table can go here."
)

sheet2 <- sheet(
  sheet_2_dataframe,
  "Sheet name 2",
  "Sheet legend 2"
)

sheet3 <- sheet(
  sheet_3_dataframe,
  "Sheet name 3",
  "Sheet legend 3"
)
```

`spreadsheet()` combines the sheets together into a `spreadsheet` object. Taking the main `title` legend, the `path` and `file` for where to save the Excelfile. The last argument contains the `sheet` objects from `sheet()`.

``` r
# Create spreadsheet specifying tables for each sheet
supplementary_table1 <- spreadsheet(
  title = "This is space for a legend title describing generally the contents of the file.",
  path = "path/to/save/results",
  file = "example_file_name1",
  sheet1,
  sheet2
)

supplementary_table2 <- spreadsheet(
  title = "Results from a fabulous analysis about something amazing",
  path = "path/to/save/results",
  file = "example_file_name2",
  sheet3
)
```

`excelerate()` generates an Excel file for each spreadsheet. It creates a README sheet with the title legend, sheet legends and column descriptions for each sheet. By default it prefixes a letter and number to each Excel file name, title legend and sheet name. For example, in the below code "S1" and "S2" will be appended as a prefix to the file name and title legend. "A1" and "B1" will be appended to the sheet names of `supplementary_table1` (as this has two sheets) and "A2" will be appended to the sheet names of `supplementary_table2` (as this has one sheet). See the [package vignette](https://ameliaes.github.io/excelerate/articles/excelerate.html) for further details on how to customise this.

```r
excelerate(
  supplementary_table1,
  supplementary_table2
)
```
### Output

The output is an Excelfile with multiple sheets. 

- The first sheet is called "README" by default.
  The README sheet cells contain the following in order:
  - The `title` specified in `spreadsheet()`.
  - The `sheet_legend`s, specified in `sheet()`, for each sheet.
  - The meta data supplied to `append_meta()`, for each sheet.
- The remaining sheets are the data frames supplied to `sheet()`. In the order each sheet object was supplied to `spreadsheet()`.


Example output from the package vignette at [`Get Started`](https://ameliaes.github.io/excelerate/articles/excelerate.html):

<p align="center">
  <video src="https://github.com/user-attachments/assets/194eeb37-7f04-4453-bd80-5b4b3a84f38e" controls width="100%">
  </video>
</p>


### Contributing

This package is in the early stages of development. If you encounter any issues or have feature requests, please contact me at [amelia.edmondson-stait@ed.ac.uk](mailto:amelia.edmondson-stait@ed.ac.uk) or open a [GitHub issue](https://github.com/AmeliaES/excelerate/issues/new). I've aimed to write comprehensive tests, but this may not be enough. I encourage you to try and break this package and let me know what you find ([pull requests](https://happygitwithr.com/fork-and-clone) [are welcome](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork)). User insights are crucial for creating robust software :-)
