
data(pesaODBA)


test_that("setODBA inherits from ODBA", {

  setODBA(pesaODBA, "datetime_", "ODBA") |>
    testthat::expect_s3_class("ODBA")

})
