fn_create_display_title <- function(str_underscore_title) {
  # functions takes a string with underscores and replaces these with spaces.
  # Then, the initial letter of each word is capitalised.
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  str_spaces <- strsplit(str_underscore_title, "_")[[1]] 
  str_pretty <- paste0(toupper(substring(str_spaces,1,1)),
                       tolower(substring(str_spaces,2)), collapse = " ")
  return(str_pretty)
}


