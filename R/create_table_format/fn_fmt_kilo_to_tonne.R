fn_fmt_kilo_to_tonne <- function(x) {
  vct_return <- round(x / 1e3, 0) %>% format(., big.mark = ",")
  return(vct_return)
}
