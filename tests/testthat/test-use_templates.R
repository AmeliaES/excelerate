get_test_data <- function() {
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
  results
}

test_that("use_spreadsheet_template works", {
  results <- get_test_data()

  spreadsheet <- spreadsheet(
    sheet(results,
      sheet_name = "A",
      sheet_legend = "Legend for table"
    ),
    sheet(results,
      sheet_name = "B",
      sheet_legend = "Legend for table"
    ),
    title = "Here is a fabulous title for my table.",
    path = tempdir()
  )

  output <- use_spreadsheet_template("S{n}", spreadsheet, 3)

  expect_equal(output$title, "S3. Here is a fabulous title for my table.")
  expect_equal(output$file, "S3")
})

test_that("use_spreadsheet_template errors if not char str input", {
  results <- get_test_data()

  spreadsheet <- spreadsheet(
    sheet(results,
      sheet_name = "A",
      sheet_legend = "Legend for table"
    ),
    sheet(results,
      sheet_name = "B",
      sheet_legend = "Legend for table"
    ),
    title = "Here is a fabulous title for my table.",
    path = tempdir()
  )

  expect_error(
    use_spreadsheet_template(NULL, spreadsheet, 3),
    "spreadsheet_template must be a character string"
  )
})

test_that("use_spreadsheet_template errors if not containing {n}", {
  results <- get_test_data()

  spreadsheet <- spreadsheet(
    sheet(results,
      sheet_name = "A",
      sheet_legend = "Legend for table"
    ),
    sheet(results,
      sheet_name = "B",
      sheet_legend = "Legend for table"
    ),
    title = "Here is a fabulous title for my table.",
    path = tempdir()
  )

  expect_error(
    use_spreadsheet_template("a string", spreadsheet, 3),
    'spreadsheet_template character string must contain "\\{n\\}"'
  )
})

test_that("use_spreadsheet_template cannot have empty file and template", {
  results <- get_test_data()

  spreadsheet <- spreadsheet(
    sheet(results,
      sheet_name = "A",
      sheet_legend = "Legend for table"
    ),
    sheet(results,
      sheet_name = "B",
      sheet_legend = "Legend for table"
    ),
    title = "Here is a fabulous title for my table.",
    path = tempdir()
  )

  expect_error(
    use_spreadsheet_template("", spreadsheet, 3),
    "file and spreadsheet_template cannot both be an empty string"
  )
})

test_that("use_spreadsheet_template cannot have empty file and template", {
  results <- get_test_data()

  spreadsheet <- spreadsheet(
    sheet(results,
      sheet_name = "A",
      sheet_legend = "Legend for table"
    ),
    sheet(results,
      sheet_name = "B",
      sheet_legend = "Legend for table"
    ),
    title = "Here is a fabulous title for my table.",
    path = tempdir()
  )

  expect_error(
    use_spreadsheet_template("", spreadsheet, 3),
    "file and spreadsheet_template cannot both be an empty string"
  )
})

test_that(
  "use_sheet_template returns unchanged spreadsheet if template is empty",
  {
    results <- get_test_data()

    spreadsheet <- spreadsheet(
      sheet(results,
        sheet_name = "A",
        sheet_legend = "Legend for table"
      ),
      sheet(results,
        sheet_name = "B",
        sheet_legend = "Legend for table"
      ),
      title = "Here is a fabulous title for my table.",
      path = tempdir()
    )

    output <- use_sheet_template("", spreadsheet, 1)

    expect_equal(output, spreadsheet)
  }
)

test_that(
  "use_sheet_template must be a character string",
  {
    results <- get_test_data()

    spreadsheet <- spreadsheet(
      sheet(results,
        sheet_name = "A",
        sheet_legend = "Legend for table"
      ),
      sheet(results,
        sheet_name = "B",
        sheet_legend = "Legend for table"
      ),
      title = "Here is a fabulous title for my table.",
      path = tempdir()
    )

    expect_error(
      use_sheet_template("a string", spreadsheet, 1),
      'sheet_template character string must contain "\\{n\\}"'
    )
  }
)

test_that(
  "use_sheet_template must be a character string",
  {
    results <- get_test_data()

    spreadsheet <- spreadsheet(
      sheet(results,
        sheet_name = "A",
        sheet_legend = "Legend for table"
      ),
      sheet(results,
        sheet_name = "B",
        sheet_legend = "Legend for table"
      ),
      title = "Here is a fabulous title for my table.",
      path = tempdir()
    )

    expect_error(
      use_sheet_template("a string{n}", spreadsheet, 1),
      'sheet_template character string must contain "\\{l\\}"'
    )
  }
)

test_that("repeats letters if n sheets > 26", {
  results <- get_test_data()

  sheets <- replicate(
    30,
    sheet(
      results,
      sheet_name = "test",
      sheet_legend = "Legend for table"
    ),
    simplify = FALSE
  )

  spreadsheet <- do.call(
    spreadsheet,
    c(sheets, list(
      title = "Here is a fabulous title for my table.",
      path = tempdir()
    ))
  )

  output <- use_sheet_template("{n}{l}_", spreadsheet, 1)

  expected_names <- c(
    "1A_test", "1B_test", "1C_test", "1D_test", "1E_test", "1F_test",
    "1G_test", "1H_test", "1I_test", "1J_test", "1K_test", "1L_test",
    "1M_test", "1N_test", "1O_test", "1P_test", "1Q_test", "1R_test",
    "1S_test", "1T_test", "1U_test", "1V_test", "1W_test", "1X_test",
    "1Y_test", "1Z_test", "1AA_test", "1AB_test", "1AC_test", "1AD_test"
  )
  expect_equal(names(output$sheets), expected_names)
})

test_that("use_sheet_template applies prefixes correctly", {
  results <- get_test_data()

  spreadsheet <- spreadsheet(
    sheet(results,
      sheet_name = "this is sheet 1",
      sheet_legend = "Legend for table"
    ),
    sheet(results,
      sheet_name = "this is another sheet",
      sheet_legend = "Legend for this table"
    ),
    title = "Here is a fabulous title for my table.",
    path = tempdir()
  )

  output <- use_sheet_template("{n} {l} ", spreadsheet, 2)

  expect_equal(names(output$sheets), c(
    "2 A this is sheet 1",
    "2 B this is another sheet"
  ))
})


test_that("if there's only one sheet then only number is appended", {
  results <- get_test_data()

  spreadsheet <- spreadsheet(
    sheet(results,
      sheet_name = "this is sheet 1",
      sheet_legend = "Legend for table"
    ),
    title = "Here is a fabulous title for my table.",
    path = tempdir()
  )

  output <- use_sheet_template("{n} {l} ", spreadsheet, 2)

  expect_equal(names(output$sheets), "2 this is sheet 1")
})

test_that("append_sheet_prefix throws error if name exceeds 31 chars", {
  results <- get_test_data()

  spreadsheet <- spreadsheet(
    sheet(results,
      sheet_name = paste0(rep("A", 30), collapse = ""),
      sheet_legend = "Legend for table"
    ),
    sheet(results,
      sheet_name = "this is another sheet",
      sheet_legend = "Legend for this table"
    ),
    title = "Here is a fabulous title for my table.",
    path = tempdir()
  )

  expect_error(
    append_sheet_prefix(
      i = 1,
      sheet_template = "{n}{l}",
      sheet = spreadsheet$sheets[1],
      n = 2
    ),
    "exceeds the maximum length of 31 characters"
  )
})

test_that("spreadsheet template is sanitised", {
  # test data
  results <- get_test_data()
  # other namespace variables
  a <- 1

  spreadsheet <- spreadsheet(
    sheet(results,
      sheet_name = paste0(rep("A", 30), collapse = ""),
      sheet_legend = "Legend for table"
    ),
    sheet(results,
      sheet_name = "this is another sheet",
      sheet_legend = "Legend for this table"
    ),
    title = "Here is a fabulous title for my table.",
    path = tempdir()
  )

  expect_error(
    use_spreadsheet_template(
      spreadsheet_template = "{n}{a}",
      spreadsheet = spreadsheet,
      n = 2
    ),
    "object 'a' not found"
  )
})
