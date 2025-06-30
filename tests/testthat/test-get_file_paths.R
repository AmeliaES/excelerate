# get_file_paths:
# Get all the files in a directory from the path that match a pattern
# returns a list of file paths
# -----------------------------------
test_that("get_file_paths returns a list of file paths", {
  # Generate tmp directory to test function against
  tmp_dir <- withr::local_tempdir()

  # Create csv files that match the pattern
  pattern <- "test_data"
  test_data_frame <- data.frame(x = 1:5)
  write.csv(test_data_frame, file.path(tmp_dir, paste0(pattern, "_1.csv")))
  write.csv(test_data_frame, file.path(tmp_dir, paste0(pattern, "_2.csv")))

  # Expect get_file_paths to return a list of file paths
  output <- get_file_paths(tmp_dir, pattern)
  expect_type(output, "list")
  expect_type(output[[1]][1], "character")
  expect_type(output[[1]][2], "character")
})

test_that("get_file_paths fails if dir does not exist at path", {
  expect_error(
    get_file_paths("non_existent_path", pattern = NULL),
    "No directory at path"
  )
})

test_that("get_file_paths fails if no matching files", {
  # Generate tmp directory to test function against
  tmp_dir <- withr::local_tempdir()

  # Create csv files that do not match the pattern
  pattern <- "test_data"
  test_data_frame <- data.frame(x = 1:5)
  write.csv(test_data_frame, file.path(tmp_dir, "test_file.csv"))

  expect_error(get_file_paths(tmp_dir, pattern),
               "No files found at")

})

test_that("list of matching files is returned as a message to the user", {
  # Generate tmp directory to test function against
  tmp_dir <- withr::local_tempdir()

  # Create csv files that match the pattern
  pattern <- "test_data"
  test_data_frame <- data.frame(x = 1:5)
  file_names <- file.path(tmp_dir, paste0(pattern, "_", 1:2 ,".csv"))
  for(path in file_names){
    write.csv(test_data_frame, path)
  }

  expect_message(get_file_paths(tmp_dir, pattern),
                 regexp = cat("Files that match pattern:\n", file_names[1],"\n", file_names[2]))
})

test_that("non matching files are not included in message to the user", {

})

test_that("get_file_paths errors if no files in dir match pattern", {

})

test_that("error if file paths returned are not all .csv or .tsv",{

})


