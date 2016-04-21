fn_fmt_millions <-function(x) {
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  return(format(round(x / 1e6,1), big.mark = ',', trim = TRUE))
}