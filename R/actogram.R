
#' @export
actogram <- function(obj, ...) {
  UseMethod("actogram")
}

#' actogram
#' actogram
#'
#' @param O
#' @param threshold a number specifying a threshold or a function see [accr::resting_threshold()]
#' @param ...
#'
#' @export
#' @examples
#' data(pesaODBA)
#' setODBA(pesaODBA, "datetime_", "ODBA")
#' actogram(pesaODBA, threshold = resting_threshold, Sigma = 2 )
#' Fixed threshold based on 100 individuals from the same cohort as the pesaODBA male.
#' actogram(pesaODBA, threshold = 780.83)
#'
#'

actogram.ODBA <- function(O, threshold, ...) {
  stopifnot( inherits(O, "ODBA") )
  x = copy(O)

  if (inherits(threshold, "function")) {
    threshold <- resting_threshold(x, ...)
  }


  datetime_ = attr(x, "dt_")
  ODBA = attr(x, "odba")

  setnames(
    x,
    c(attr(x, "dt_"), attr(x, "odba")),
    c("dt_", "odba")
  )

  x[, HH := dt2hh(dt_)]
  x[, date := as.Date(dt_)]

  if (!missing(threshold)) {
    x[, resting := fifelse(odba <= threshold, "rest", "activity")]
  }


  g =
  ggplot(x) +
    facet_wrap(~date, ncol = 1, strip.position = "left") +
    geom_path(aes(x = HH,  y = odba), linewidth = 0.2, alpha = 0.7, inherit.aes = FALSE) +
    scalex_act() +
    theme_act() +
    xlab("Hour")

  if (!missing(threshold)) {
    g = g +
    geom_point(aes(x = HH, y = odba, color = resting), size = 1) +
    scale_color_manual(values = c("red", "black"), name = NULL)
  }

  g



}
