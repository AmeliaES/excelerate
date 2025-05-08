# `excelerate` R package

This package provides a set of functions to easily create and export Excel spreadsheets for supplementary tables required when preparing research manuscripts for scientific journals. It helps accelerate the process of generating well-organised, publication-ready tables directly from raw csv or tsv files. There is the option to use the functions in the package as they are, or if you'd rather you can customise the functions to suit your needs.

## 1. Using the Functions in the Package

### Installation

``` r
install.packages("devtools")
devtools::install_github("yourusername/excel-recipes")
library(excelrecipes)
```

### Example: Create an Excel Table

The main function in the package is ...

``` r
```

### 2. Customising the Functions

If you want to modify the behavior of the existing functions or add your own, you can customise the functions by modifying or extending them without touching the core package code.

### Installation of package to develop custom functions

If you want to install the entire package along with the ability to modify and add your own functions, follow these steps:

1.  Clone or Download the Repo:

```         
git clone https://github.com/ameliaes/excelerate.git
```

Or download the ZIP file from the GitHub page and extract it.

2.  Install the Package Locally In RStudio, you can install the package locally by running:

```         
devtools::install_local("path/to/excelerate")
```

3.  Customise Functions

After installation, you can make your own custom versions of any function.

### Customizing via `ext/` Folder

1.  Copy the function you want to modify from the R/ folder into the ext/ folder.
2.  Edit the function to suit your needs.
3.  Load the custom function using the `load_custom_functions()` function.

For example, you might copy create_excel_table.R into ext/ and modify it to add additional arguments:

``` r
# Example of custom modification in ext/

```

## Folder Structure

```         
excelerate/
├── R/                    # Core functions
├── ext/                  # Custom functions (user-defined)
├── DESCRIPTION           # Package metadata
├── NAMESPACE             # Exports and imports
└── README.md             # This documentation
```

## Contributing

If you want to contribute improvements to the package (or add your own customisations), feel free to:

1.  Fork the repo.
2.  Make your changes.
3.  Open a pull request to contribute your changes.

For internal modifications (without pushing changes to GitHub), simply edit the `ext/` folder with your personal functions and use the load_custom_functions() function to load them.

## Notes

The `ext/` folder is designed to let you extend or modify the core functions without touching the package’s internal code in the `R/` folder.

If you make changes to your own custom functions, remember to save them and source them again using `load_custom_functions()` before running.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
