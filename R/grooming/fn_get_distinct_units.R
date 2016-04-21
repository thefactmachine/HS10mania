fn_get_distinct_units <- function(df_data, vct_HS10) {
  # functions receives a data.frame of exports data and a vector of HS10 codes.
  # the function returns the unique units ("Unit_Qty") within these codes
  # Peer review: Ilkka Havukkala 21 April 2016 OK
    
  filter_HS10 <- interp(quote(x %in% y), x=as.name("Harmonised_System_Code"), y = vct_HS10)
  vct_distinct_units <- df_data %>% 
    filter_(filter_HS10) %>% 
    select(Unit_Qty) %>% 
    dplyr::distinct() %>% .$Unit_Qty
  
  return(vct_distinct_units)
}