
data(pesaODBA)
setODBA(pesaODBA, "datetime_", "ODBA")

test_that("actogram returns a ggplot", {

  actogram(pesaODBA, threshold = resting_threshold) |>
    testthat::expect_s3_class("ggplot")
  
  actogram(pesaODBA, threshold = resting_threshold, Sigma = 2) |>
    testthat::expect_s3_class("ggplot")
  
  actogram(pesaODBA, threshold = 123) |>
    testthat::expect_s3_class("ggplot")
  

})
