fn_top_n_country <- function(df_data, vct_HS10, int_year, int_top_n)  {
  # function receives data, vector of HS10 codes, the year (e.g 2015) and number of values to return
  # returns the top n countries which exported the specified HS10 codes in the specified year
  # requires library(dplyr) library(lazyeval) library(lubridate)
  
  # set up things with non-standard evalutation so that function can be parameterised.
  filter_cond_HS10 <- interp(quote(x %in% y), x=as.name("HS10"), y = vct_HS10)
  filter_cond_year <- interp(~year(x) == y, x=as.name("date"), y = int_year)
  suppressMessages(
    vct_return <- df_data %>% 
      filter_(filter_cond_HS10) %>% 
      filter_(filter_cond_year) %>%
      group_by(country) %>% summarise(total = sum(value)) %>%
      arrange(country) %>% top_n(int_top_n)
  )
  return(vct_return) 
}




