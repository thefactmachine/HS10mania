fn_create_table_dimensions <- function(vct_col_widths)  {
  # this function takes a vector of columns widths and returns a string in latex format
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  fn_message_log(a_str_message = "creating table dimensions to table tex file")
  fslash <-intToUtf8(92)
  nline <- paste0("\n")
  str_hfill <- paste0(">{",fslash, "hfill}")
  
  str_col_dims <- vct_col_widths %>%
    sapply(function(x)  paste0("p{", x, "cm}", str_hfill)) %>% paste0(collapse = "" ) %>%
    # remove the last hfill tag; encapsulate the the string with tags
    gsub(">.\\\\hfill}$", "", .) %>% paste0(fslash, "begin{tabular}[t]{",.,"}",nline)
  return(str_col_dims)
}