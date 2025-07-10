test_that("create_meta works", {
  # Generate tmp directory to test function against
  tmp_dir <- withr::local_tempdir()

  # Create csv files that match the pattern
  pattern <- "test_data"
  test_data_frame <- data.frame(x = 1:5)
  test_meta <- data.frame("Col_name" = "X", "description" = "description of the column here")
  write.csv(test_data_frame, file.path(tmp_dir, paste0(pattern, "_1.csv")), row.names = FALSE)

  create_meta(file_name = file.path(tmp_dir, paste0(pattern, "_1.csv")),
              table_variable_name = test_data_frame,
              colname_descriptions = c("x" = "description of the column here"))

  # Check if the .cols file was created
  cols_file <- file.path(tmp_dir, paste0(pattern, "_1.csv.cols"))
  expect_true(file.exists(cols_file))
  # Check if the .cols file contains the expected content
  cols_content <- read.csv(cols_file, stringsAsFactors = FALSE)
  expect_equal(nrow(cols_content), 1)
  expect_equal(cols_content$column, "x")
  expect_equal(cols_content$description, "description of the column here")

})

test_that("create_meta stops on missing description", {
  # Generate tmp directory to test function against
  tmp_dir <- withr::local_tempdir()

  # Create csv files that match the pattern
  pattern <- "test_data"
  test_data_frame <- data.frame(x = 1:5, y = 1:5)
  # Miss description of column y to test error
  test_meta <- data.frame("Col_name" = "X", "description" = "description of the column here")
  write.csv(test_data_frame, file.path(tmp_dir, paste0(pattern, "_1.csv")), row.names = FALSE)

  expect_error(
    create_meta(
      file_name = file.path(tmp_dir, paste0(pattern, "_1.csv")),
      table_variable_name = test_data_frame,
      colname_descriptions = c("x" = "description of the column here")
    ),
    "Column names .+ in"
  )
})
