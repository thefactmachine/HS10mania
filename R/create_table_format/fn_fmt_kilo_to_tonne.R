fn_fmt_kilo_to_tonne <- function(x) {
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  return(format(round(x / 1e3,0), big.mark = ',', trim = TRUE))
}
