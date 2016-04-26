fn_get_unique_HS10_stubs <- function(a_vct_HS10) {
  # function receives character vector of 10 digit HS10 codes
  # the first six digits are extracted, made unique and then sorted
  # finally collapse the character vector into a comma and space separated 
  # string
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  fn_message_log(a_str_message = "creating unique six digit HS10 codes for tex file") 
    
  str_HS10_top_six <- substr(a_vct_HS10, start = 1, stop = 6) %>%
    unique() %>% sort() %>% paste0(., collapse = ", ")
  return(str_HS10_top_six)
}