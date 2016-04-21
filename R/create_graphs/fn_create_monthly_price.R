fn_create_monthly_price <- function(df_data, vct_top_country) {
  # 1.  function creates monthly prices for top six countries by dividing value by volume (df_detail)
  # 2. the function creates average monthly prices for all countries (df_total)
  # 3. the two data frames created above are clubbed together and returned (df_consolidated)
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  source('R/create_graphs/legacy_function_remove_outliers.R')
  
  # 1. create monthly prices for top n countries (vct_top_country)
  filter_country <- interp(quote(x %in% y), x=as.name("country"), y = vct_top_country)
  df_detail <- df_data %>% filter_(filter_country) %>%
    group_by(date, country) %>%
    summarise(tot_volume = sum(volume), 
              tot_value = sum(value), 
              tot_price = sum(tot_value / tot_volume)) %>%
    # needs to be cast to data.frame() to produce same answers as legacy code..why???
    data.frame() %>%
    # this function needs replacing..its unreadable!!
    mutate(tot_price = remove_outliers(tot_price, low_lim = 0.05, up_lim = 0.95))
  
  # 2. create average monthly prices for all countries.
  df_total <- df_data %>% group_by(date) %>%
    summarise(country = "Total",
              tot_volume = sum(volume), 
              tot_value = sum(value), 
              tot_price = round(sum(tot_value / tot_volume),1))
  
  # 3. club steps 1 & 2 together and return
  df_consolidated <- bind_rows(df_detail, df_total) %>% arrange(date)
  return(df_consolidated)
}