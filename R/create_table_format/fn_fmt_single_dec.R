fn_fmt_single_dec <-function(x) {
  return(format(round(x ,2), big.mark = ',', nsmall = 2, trim = TRUE))
  # Peer review: Ilkka Havukkala 21 April 2016 OK
}
