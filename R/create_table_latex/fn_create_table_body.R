fn_create_table_body <- function(df) {
  # insert an ampersand (i.e. &) after each column...
  # except for the last column where two \\ are inserted
  # return a vector of concatenated columns
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  fn_message_log(a_str_message = "creating body of table for tex table")  
  
  df_less1 <- df %>% select(-ncol(.))
  df_a <-lapply(seq_len(nrow(df_less1)), function(x) {
    as.vector(df_less1[x,]) %>% 
      paste0(" & ")
  }) %>% do.call(rbind, .) %>% as.data.frame()
  
  # process the last column differently
  df_last_col <- df %>% select(ncol(.)) 
  df_b <-lapply(seq_len(nrow(df_last_col)), function(x) {
    as.vector(df_last_col[x,]) %>% 
      paste0(" \\\\ ")
  }) %>% do.call(rbind, .) %>% as.data.frame()
  
  # club the two column sets together as a df,
  # then club the columns and get a vector of length = nrow()
  vct_rows <- bind_cols(df_a, df_b) %>% 
    apply(1, paste0, collapse = "")
  
  # we have a vector of rows...now club these together as a single string
  str_rtr <- paste0(vct_rows, " \n", collapse = "")
  
  return(str_rtr)
}



