fn_fmt_kilo_to_tonne <- function(x) {
<<<<<<< HEAD
  vct_return <- round(x / 1e3, 0) %>% format(., big.mark = ",")
  return(vct_return)
=======
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  return(format(round(x / 1e3,0), big.mark = ',', trim = TRUE))
>>>>>>> 070630970c460d2354d2a50d378cb7cf301dd849
}
