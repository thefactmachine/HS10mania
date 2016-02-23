fn_fmt_millions <-function(x) {
  return(format(round(x / 1e6,1), big.mark = ',', trim = TRUE))
}