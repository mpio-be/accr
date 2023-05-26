
data(pesaODBA)
setODBA(pesaODBA, "datetime_", "ODBA")

test_that("resting_threshold returns one number", {

  resting_threshold(pesaODBA) |>
  expect_type("double")

})
