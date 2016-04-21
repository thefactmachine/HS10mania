fn_monthly_summary <- function(df_data, vct_HS10, int_val_divisor, int_vol_divisor) {
  # This function is used to groom data for the use in three graphs.  These graphs are:
  # 1) "monthly value" 2) "monthly volume" 3) "monthly number of countries"
  # the data frame produced has a column for each of the these graphs.
  
  # Function receives all raw data rows and aggregates by month. 
  # Filters in only the supplied vct_HS10 codes
  # Aggregates by month (i.e date which changes monthly)
  # Calculates the number of distinct countries for each month.
  
  # finally for the sake of formatting. The value and volume columns are
  # divided by the specified parameter
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  # set up things so that this function can be parameterised with a filter of HS10 codes
  filter_HS10 <- interp(quote(x %in% y), x=as.name("Harmonised_System_Code"), y = vct_HS10)
  
  df_monthly_summary <- df_data %>%filter_(filter_HS10) %>%
    # convert from factor to character
    mutate(country = as.character(Country)) %>%
    select(Date, country, Total_Exports_Qty, Total_Exports_NZD_fob) %>%
    rename(volume = Total_Exports_Qty, value = Total_Exports_NZD_fob, date = Date) %>%
    # data is presented as monthly data, so following produces monthly aggregates
    group_by(date) %>%
    summarise(tot_value = sum(value), tot_volume = sum(volume), 
    # number of distinct countries in each group
    num_countries = n_distinct(country)) %>%
    arrange(date) %>%
    # now we just divide the tot_value and tot_volume by the appropriate divisor
    mutate(tot_value = tot_value / int_val_divisor, tot_volume = tot_volume / int_vol_divisor)
 
  return(df_monthly_summary)
}