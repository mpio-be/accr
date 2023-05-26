
#' resting_threshold
#'
#' @param x       An ODBA data.table. See [accr::setODBA()]
#' @param method  Only "mixfit" available at the moment. See [mixR::mixfit]
#' @param Sigma   SD units away away from the mean to set the resting cutoff. Default t0 2.
#'
#' @return A value for the resting threshold is given. 
#' @export
#'
#' @examples
#' data(pesaODBA)
#' setODBA(pesaODBA, "datetime_", "ODBA")
#' thr = resting_threshold(pesaODBA)
#' density(pesaODBA$ODBA) |> plot()
#' abline(v = thr, col = 2)
#' 
resting_threshold <- function(x, method = "mixfit", Sigma = 2) {
  stopifnot(inherits(x, "ODBA"))

  odba = attr(x, "odba")

  # because mixfit does not work normally
  assign(".V", x[, ..odba][[1]], .GlobalEnv)

  if(method == "mixfit") {
    mm = mixR::mixfit(get(".V", .GlobalEnv), ncomp = 2, family = "lnorm")
    out = mm$mu[2] - mm$sd[2] * Sigma
    }

  rm(.V, envir = .GlobalEnv)

  out


}
