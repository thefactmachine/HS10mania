fn_fmt_price <-function(x) {
  # function's purpose is to convert a numeric to a string prepended with a $ sign
  # exmample 11.222 becomes "$11.2"
  
  # x comes as a df and paste0() returns a vector.  We want the
  # function to return a data frame with the incoming column name preserved.
  # therefore the following trickery is used to preserve our data.frame. 
  #mmm RR is tricky!!!
  df_raw_num <- format(round(x ,1), big.mark = ',', trim = TRUE)
  vct_with_dollar <- paste0("\\$",df_raw_num[,1])
  df_raw_num[,1] <- vct_with_dollar

  return(df_raw_num)
}
