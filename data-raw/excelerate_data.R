## code to prepare example .csv and .xlsx files in `extdata/`

# Read in example datasets
dataset_names <- c("iris", "ChickWeight", "ToothGrowth", "CO2")
for (dataset in dataset_names) {
  data(list = dataset, package = "datasets")
}

# Save datasets as example csv files
for (dataset in dataset_names) {
  write.csv(get(dataset), file = paste0("inst/extdata/", dataset, ".csv"), row.names = FALSE)
}

# Create .cols file for each dataset
create_meta(file_name = "inst/extdata/iris.csv",
            table_variable_name = iris,
            colname_descriptions = c("Sepal.Length" = "Length of the sepal in cm",
                                      "Sepal.Width" = "Width of the sepal in cm",
                                      "Petal.Length" = "Length of the petal in cm",
                                      "Petal.Width" = "Width of the petal in cm",
                                      "Species" = "Species of iris"))

create_meta(file_name = "inst/extdata/ChickWeight.csv",
            table_variable_name = ChickWeight,
            colname_descriptions = c("weight" = "Weight of the chick in grams",
                                      "Time" = "Time in days",
                                      "Chick" = "Chick identifier",
                                      "Diet" = "Diet type"))

create_meta(file_name = "inst/extdata/ToothGrowth.csv",
            table_variable_name = ToothGrowth,
            colname_descriptions = c("len" = "Tooth length in mm",
                                      "supp" = "Supplement type (VC or OJ)",
                                      "dose" = "Dose of the supplement in mg"))

create_meta(file_name = "inst/extdata/CO2.csv",
            table_variable_name = CO2,
            colname_descriptions = c("Plant" = "Identifier for the plant",
                                      "Type" = "Type of plant (Quebec or Mississippi)",
                                      "Treatment" = "Treatment type (nonchilled or chilled)",
                                      "conc" = "Concentration of CO2 in uL/L",
                                      "uptake" = "CO2 uptake in mg"))

# Demonstrate using excelerate() to create supplementary tables
devtools::load_all()

supplementary_table_1 <- spreadsheet(
  sheet(here::here("inst/extdata"), "iris", "iris", "sheet_legend for the iris dataset."),
  sheet(here::here("inst/extdata"), "ChickWeight", "ChickWeight", "sheet_legend for the ChickWeight dataset."),
  title = "Supplementary Table 1. Example of output from excelerate(). This is the legend_title passed to spreadsheet().",
  filename = here::here("inst/extdata/supplementary_table_1.xlsx"))

supplementary_table_2 <- spreadsheet(
  sheet(here::here("inst/extdata"), "ToothGrowth", "ToothGrowth", "sheet_legend for the ToothGrowth dataset."),
  sheet(here::here("inst/extdata"), "CO2", "CO2", "sheet_legend for the CO2 dataset."),
  title = "Supplementary Table 2. Example of output from excelerate(). This is the legend_title passed to spreadsheet().",
  filename = here::here("inst/extdata/supplementary_table_2.xlsx"))

# Save supplementary tables as .xlsx to inst/extdata
excelerate(supplementary_table_1,
           supplementary_table_2)
