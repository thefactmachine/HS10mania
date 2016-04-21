fn_filter_HS10_codes <- function(df_data, vct_HS10) {
  # function receives all raw data rows and aggregates by month. 
  # Filters in only vct_HS10 codes.
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  # set up things so that this function can be parameterised with a filter of HS10 codes
  filter_HS10 <- interp(quote(x %in% y), x=as.name("Harmonised_System_Code"), y = vct_HS10)
  
  df_return_data <- df_data %>%filter_(filter_HS10) %>%
    # convert from factor to character
    mutate(country = as.character(Country)) %>%
    select(Date, country, Total_Exports_Qty, Total_Exports_NZD_fob) %>%
    rename(volume = Total_Exports_Qty, value = Total_Exports_NZD_fob, date = Date) %>%
    arrange(date)
  
  return(df_return_data)
}