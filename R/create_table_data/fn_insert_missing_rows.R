fn_insert_missing_rows <- function(df_now, df_prev) {
  # There will be occaisions where 1 (or more) of the top N countries for 
  # the current period are not contained in the previous period. For example,
  # Malaysia may be country 4 for 2015 but for 3 years previous (i.e 2012)
  # Malaysia may not be contained in the data set. Perhaps NZ did not export
  # to Malaysia during this earlier period
  
  # Therefore, this function accepts two data frames: 1 for the current period (df_now)
  # and the 2 for the previous period.  Sometimes because of these missing countries,
  # the number of rows for df_prev will be less than the number of rows for df_now
  
  # This function iterates through df_now and attempts to find a matching country
  # in df_prev. If it finds a matching country, then the original data for df_prev is 
  # inserted. If it does not find a match then some dummy data (NAs for 0s) are inserted
  
  
  
  
  
  
}