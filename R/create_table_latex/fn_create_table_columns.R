fn_create_table_columns <- function(vct_names) {
  # this function takes a vector of columns names and returns a latex formated string
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  fslash <- intToUtf8(92)
  nline <- paste0("\n")
                  
  str_c_titles <- vct_names  %>%
    sapply(function(x) paste0("\\textbf{",x,"} & ")) %>% paste0(collapse = "" ) %>% 
    # lop off the final ampersand and append two nice slashes
    gsub(" & $", "", .)  %>% paste0(" ",fslash, fslash)
  return(str_c_titles)
}  
