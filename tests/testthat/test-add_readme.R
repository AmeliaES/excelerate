test_that("add_readme inserts a sheet called README", {
  expected_wb <- createWorkbook()
  addWorksheet(expected_wb, sheetName = "README")

  wb <- createWorkbook()
  add_readme(wb)

  expect_equal(wb, expected_wb)
})
