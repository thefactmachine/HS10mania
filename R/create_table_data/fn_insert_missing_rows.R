fn_insert_missing_rows <- function(a_df_now, a_df_prev) {
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
  
  ## Peer review: Ilkka Havukkala 27 April 2016 ok
  
  
  # obtain a vector of countries contained in the N periods
  # previous data.frame
  vct_prev_country <- a_df_prev$Country
  
  # create a blank data.frame with appropriate types and column names
  # this data.frame will store the result
  df_prev_corrected <- data.frame(Country = character(0), 
                                        quantity = numeric(0), 
                                        value = numeric(0), 
                                        price = numeric(0))
  
  # iterate through the data frame of the current periods data.
  # each country...should have a corresponding value in the data.frame
  # for N periods previous. If there is not a match then insert dummy values.
  
  for (i in 1:nrow(a_df_now)) {
      # obtain the current country value
      str_i_country <- as.character(a_df_now[i, "Country"])
      
      if (!is.na(match(str_i_country, vct_prev_country))) {
        # if (TRUE) ==> a matching column ==> copy data accross from df_before_qvp to df_before_qvp_corrected
        df_prev_corrected <- rbind(df_prev_corrected, a_df_prev[a_df_prev$Country == str_i_country,]) 
      } # if
      else {
        # if (FALSE) ==> missing country.  Insert the missing country name and insert dummy data (0s or NAs)
        str_missing_country <- a_df_now$Country[i]
        df_inserted_data <- data.frame(Country = str_missing_country, quantity = NA, value = NA, price = NA)
        df_prev_corrected <- rbind(df_prev_corrected, df_inserted_data) 
      } # else
    } # for
  return(df_prev_corrected)

} # end of function

