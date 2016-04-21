fn_fmt_single_dec <-function(x) {
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  return(format(round(x ,1), big.mark = ',', trim = TRUE))
}
