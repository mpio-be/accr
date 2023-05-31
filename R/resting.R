

.cutoff <- function(MU1, MU2, S1, S2, R) {


  fun <- function(cutoff, mu1, mu2, sigma1, sigma2) {
    separation <- abs(
      pnorm(cutoff, mean = mu1, sd = sigma1) - pnorm(cutoff, mean = mu2, sd = sigma2)
      
    )

    return(-separation)
  }

  optimise(
    f        = fun,
    interval = R,
    mu1      = MU1,
    mu2      = MU2,
    sigma1   = S1,
    sigma2   = S2
  )$minimum

    
}


#' resting_threshold
#'
#' @param x       An ODBA data.table. See [accr::setODBA()]
#' @param method  Only "mixfit" available at the moment. See [mixR::mixfit]
#' @param ...     Further arguments passed to the underlining methods. 
#'
#' @return A value for the resting threshold is given.
#' @export
#'
#' @examples
#' data(pesaODBA)
#' setODBA(pesaODBA, "datetime_", "ODBA")
#' thr = resting_threshold(pesaODBA, method = "mixfit")
#' density(pesaODBA$ODBA) |> plot()
#' abline(v = thr, col = 2)
#' 
#'
resting_threshold <- function(x, method = "mixfit", ...) {
  stopifnot(inherits(x, "ODBA"))

  odba = attr(x, "odba")

  if (method == "mixfit") {
    
    # because mixfit does not work normally
    assign(".V", x[, ..odba][[1]] |> log(), .GlobalEnv)
    #on.exit(rm(.V, envir = .GlobalEnv))

    mm = mixR::mixfit(get(".V", .GlobalEnv), ncomp = 2, family = "normal", ...)
    out = .cutoff(mm$mu[1], mm$mu[2], mm$sd[1], mm$sd[2], R = range(.V)) |>
      exp()
    
    return(out)


  }
}
