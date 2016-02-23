fn_fmt_kilo_to_tonne <- function(x) {
  return(format(round(x / 1e3,0), big.mark = ',', trim = TRUE))
}
