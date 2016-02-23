fn_total_year <- function(df_data, int_year) {
  filter_cond_year <- interp(~year(x) == y, x=as.name("date"), y = int_year)
  int_return <- df_data %>% filter_(filter_cond_year) %>%
    summarise(total = sum(value)) %>% .$total
  return(int_return)
}