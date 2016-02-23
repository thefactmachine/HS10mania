fn_year_country_HS10 <- function(df_data, vct_HS10, int_year, vct_country)  {
  # function receives data, vector of HS10 codes, the year (e.g 2015) and number of values to return
  # returns the top n countries which exported the specified HS10 codes in the specified year
  # requires library(dplyr) library(lazyeval) library(lubridate)
  
  # set up things with non-standard evalutation so that function can be parameterised.
  filter_cond_HS10 <- interp(quote(x %in% y), x=as.name("HS10"), y = vct_HS10)
  filter_cond_year <- interp(~year(x) == y, x=as.name("date"), y = int_year)
  filter_cond_country <- interp(quote(x %in% y), x=as.name("country"), y = vct_country)
  
  suppressMessages(
    df_result <- df_data %>% 
      filter_(filter_cond_HS10) %>% 
      filter_(filter_cond_year) %>%
      filter_(filter_cond_country) %>%
      group_by(country) %>% summarise(total = sum(value)) %>%
      arrange(country)
  )
  vct_total <- df_result$total
  names(vct_total) <- df_result$country
  
  return(vct_total) 
}