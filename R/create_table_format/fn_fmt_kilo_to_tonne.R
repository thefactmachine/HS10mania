fn_fmt_kilo_to_tonne <- function(x) {
  vct_return <- round(x / 1e3, 0) %>% format(., big.mark = ",")
  return(vct_return)
  # Peer review: Ilkka Havukkala 21 April 2016 OK
}
