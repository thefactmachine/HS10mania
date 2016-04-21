fn_fmt_millions <-function(x) {
<<<<<<< HEAD
  # x comes as a df and paste0() returns a vector.  We want the
  # function to return a data frame with the incoming column name preserved.
  # therefore the following trickery is used to preserve our data.frame. 
  #mmm RR is tricky!!!
  df_raw_num <- format(round(x / 1e6 ,2), big.mark = ',', nsmall = 2, trim = TRUE)
  vct_with_dollar <- paste0("\\$ ",df_raw_num[,1])
  df_raw_num[,1] <- vct_with_dollar
  return(df_raw_num)
=======
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  return(format(round(x / 1e6,1), big.mark = ',', trim = TRUE))
>>>>>>> 070630970c460d2354d2a50d378cb7cf301dd849
}