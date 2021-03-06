fn_top_n_countries_rolling <- function(df_data, vct_HS10, int_top_n, dte_lower_month, dte_upper_month)  {
  # function receives data, vector of HS10 codes, the year (e.g 2015) and number of values to return
  # returns the top n countries which exported the specified HS10 codes in the specified year
  # requires library(dplyr) library(lazyeval) library(lubridate)
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  # set up things with non-standard evalutation so that function can be parameterised.
  
  fn_message_log(a_str_message = paste0("Calculating top ", int_top_n, " countries for: ", dte_lower_month, " to ", dte_upper_month))
  
  filter_cond_HS10 <- interp(quote(x %in% y), x=as.name("Harmonised_System_Code"), y = vct_HS10)
  filter_lower_month <- interp(~x >= y, x=as.name("Date"), y = dte_lower_month)
  filter_upper_month <- interp(~x <= y, x=as.name("Date"), y = dte_upper_month)
  

  suppressMessages(
    vct_return <- df_data %>% 
      filter_(filter_cond_HS10) %>% 
      filter_(filter_lower_month) %>%  filter_(filter_upper_month) %>%
      group_by(Country) %>% summarise(total = sum(Total_Exports_NZD_fob)) %>%
      arrange(-total) %>% top_n(int_top_n) %>% .$Country %>% as.character()
  )
  return(vct_return) 
}