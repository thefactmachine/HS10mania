fn_fmt_pc <- function(x) {
  # function's purpose is to convert a numeric to a string percentage
  # exmample 0.60 becomes "60.0%"
  
  # x comes as a df and paste0() returns a vector.  We want the
  # function to return a data frame with the incoming column name preserved.
  # therefore the following trickery is used to preserve our data.frame. 
  #mmm RR is tricky!!!
  df_a <- format(round(x * 100, 2), big.mark = ',', nsmall = 2, trim = TRUE)
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  # numeric gets coerced to a factor in the following
  
  # format string based NA so they do NOT have a trailing % sign
  vct_b <- ifelse(df_a[,1] == "NA", df_a[,1], paste0(df_a[,1], "\\%"))

  # previous code
  # vct_b <- paste0(df_a[,1], "\\%")
  df_a[,1] <- vct_b
  return(df_a)
}





