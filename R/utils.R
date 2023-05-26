

theme_act <- function() {
  theme_bw() +
    theme(
      panel.border      = element_blank(),
      panel.background  = element_blank(),
      panel.grid.major  = element_blank(),
      panel.grid.minor  = element_blank(),
      axis.title.y      = element_blank(),
      axis.text.y       = element_blank(),
      axis.ticks.y      = element_blank(),
      legend.position   = "top",
      strip.text.y.left = element_text(angle = 0),
      strip.background  = element_blank(),
      axis.line         = element_line(),
      panel.spacing     = unit(0, "lines")
    )
}

scalex_act <- function() {
  scale_x_continuous(
    breaks = seq(0, 24, by = 6),
    labels = seq(0, 24, by = 6) |> str_pad(2, "left", 0),
    limits = c(0, 24), expand = c(0, 0)
  )
}


dt2hh <- function(x) {
  h <- as.POSIXlt(x)
  h$hour + h$min / 60 + h$sec / 3600
}

monthDay <- function(p, month = 6) {
day1 <- as.Date(paste(data.table::year(p), glue("{month}-02"), sep = "-"))
yy <- data.table::yday(p)

data.table::yday(day1) - yy
}