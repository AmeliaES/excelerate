#' @title Create .cols sidecar meta data file
#' @description This function creates a .cols sidecar meta data file of column name descriptions for a given table.
#' It checks if all column names in the table variable name are described in the colname_descriptions and stops with an error message if not.
#' The .cols file is saved in the same directory as the table variable name with the same name as the file name.
#'
#' @importFrom tibble tibble
#' @importFrom here here
#' @importFrom glue glue
#' @param file_name A character string specifying the path and file name (including the .csv part) of the corresponding table meta data is created for.
#' @param table_variable_name A data frame for which metadata is being generated.
#' @param colname_descriptions A named character vector where names correspond to column names of `table_variable_name` and values are their descriptions.
#'
#' @return Writes a `.cols` metadata file as a side effect. No object is returned.

create_meta <- function(file_name, table_variable_name, colname_descriptions){
  colname_descriptions_table <- tibble(column = names(colname_descriptions), description = colname_descriptions)

  if(any(colname_descriptions_table$column != colnames(table_variable_name))){
    stop(glue("Column names in {file_name} are not all described in colname_descriptions"))
  }

  write.csv(colname_descriptions_table, here::here(glue("{file_name}.cols")), row.names = FALSE)
}
