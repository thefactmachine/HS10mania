fn_get_unit_parameters <- function(df_lu, vct_dist_units) {
  # pick off the first element of the vector
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  str_unit = vct_dist_units[1]
  # set up a filtering mechanism. This uses non-standard evaluation
  filter_units <- lazyeval::interp(quote(x == y), x=as.name("unit"), y = str_unit)
  df_lu %>% filter_(filter_units)
}