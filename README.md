# `excelerate` R package

This package provides a set of functions to easily create and export Excel spreadsheets for supplementary tables required when preparing research manuscripts for scientific journals. It helps accelerate the process of generating well-organised, publication-ready tables directly from raw csv or tsv files. There is the option to use the functions in the package as they are, or if you'd rather you can customise the functions to suit your needs.

## Using the Functions in the Package

### Installation

``` r
install.packages("devtools")
devtools::install_github("ameliaes/excelerate")
library(excelerate)
```

### Example: Create an Excel Table

``` r
# Create spreadsheet objects
table_foo = spreadsheet(
  sheet("path_to_foo_results", "Foo_file_name", "Sheet Name Foo"),
  sheet("path_to_too_results", "Too_file_name", "Sheet Name Too"),
  title = "Data Foo and Data Too",
  filename = "footoo"
)
table_bar = spreadsheet(
  sheet("path_to_fizz_results", "Fizz_file_name", "Sheet Name Fizz"),
  sheet("path_to_buzz_results", "Buzz_file_name", "Sheet Name Buzz"),
  title = "Data Fizz and Data Buzz",
  filename = "fizzbuzz"
)

# Write spreadsheets based on the spreadsheet objects
excelerate(table_foo, table_bar)
```

### Requirements

*Add comment about including a .cols metadata file*



