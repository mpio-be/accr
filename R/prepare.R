
#' setODBA
#' setODBA
#'
#' @param d data.table
#' @param datetime_  datetime
#' @param ODBA 'character'
#' @param threshold function or value
#'
#' @export
setODBA <- function(d, datetime_, ODBA, threshold = NA) {
  stopifnot(data.table::is.data.table(d))

  data.table::setattr(d, "dt_", datetime_)
  data.table::setattr(d, "odba", ODBA)


  data.table::setattr(d, "class", append("ODBA", class(d)))

}
