testthat::test_that("classless R6 object errors with no specified framework", {
  testthat::expect_error(Classless$new())
})

testthat::test_that("classless R6 object generates successfully with framework", {
  classless <- Classless$new("test")
})
