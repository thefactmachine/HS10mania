fn_country_product_rolling_year <- function(df_data, vct_HS10, vct_countries, 
                                            dte_lower_month, dte_upper_month) {
  # function receives: data, vector of HS10 codes, vector of countries and the year (ie. 2014)
  # the function then calculates totals for the group of HS10 codes and for each country ...
  # for the specific year.
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  # set up some re-useable parameters
  lst_totals <- list(quantity = ~sum(Total_Exports_Qty), value = ~sum(Total_Exports_NZD_fob))
  lst_price <- list(price = ~(value / quantity))
  filter_HS10 <- interp(quote(x %in% y), x=as.name("Harmonised_System_Code"), y = vct_HS10)
  filter_country <- interp(quote(x %in% y), x=as.name("Country"), y = vct_countries)
  filter_country_negation <- interp(quote(!x %in% y), x=as.name("Country"), y = vct_countries)
  
  filter_lower_month <- interp(~x >= y, x=as.name("Date"), y = dte_lower_month)
  filter_upper_month <- interp(~x <= y, x=as.name("Date"), y = dte_upper_month)
  
  # the following data.frame gets re-used three times:
  df_product_year <- df_data %>% filter_(filter_lower_month) %>% 
    filter_(filter_upper_month) %>% filter_(filter_HS10)
  
  # 1) to create totals for each country
  df_top_country <- df_product_year %>% filter_(filter_country) %>%
    group_by(Country) %>% summarise_(.dots = lst_totals) %>%
    # return the countries in the same other in which they were received.
    slice(match(vct_countries, Country)) %>%
    mutate_(.dots = lst_price)
  
  # 2) to create a single row aggregate "other" for all other countries
  df_other <- df_product_year %>% filter_(filter_country_negation) %>%
    summarise_(.dots = lst_totals) %>% mutate_(.dots = lst_price) %>%
    bind_cols(list(Country = "Other"), .)
  
  # 3 to create a total: (#1 + #2)
  df_total <- df_product_year %>% summarise_(.dots = lst_totals) %>% 
    mutate_(.dots = lst_price) %>% bind_cols(list(Country = "Total"), .)
  
  return(bind_rows(df_top_country, df_other, df_total) %>% 
           select(-Country))
}
