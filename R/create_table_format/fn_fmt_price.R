fn_fmt_price <-function(x) {
  # function's purpose is to convert a numeric to a string prepended with a $ sign
  # example 11.222 becomes "$11.2"
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  # x comes as a df and paste0() returns a vector.  We want the
  # function to return a data frame with the incoming column name preserved.
  # therefore the following trickery is used to preserve our data.frame. 
  #mmm RR is tricky!!!
  df_raw_num <- format(round(x ,2), big.mark = ',', nsmall = 2, trim = TRUE)
  vct_with_dollar <- paste0("\\$ ",df_raw_num[,1])
  df_raw_num[,1] <- vct_with_dollar
  return(df_raw_num)
}
