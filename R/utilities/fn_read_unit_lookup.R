fn_read_unit_lookup <- function() {
  # reads in the units_lookup csv and returns a data.frame
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  df_lookup <- 
      read.csv("inputs/concordances/units_lookup.csv", 
               colClasses = c("character", "numeric", "numeric",  "character", "character"))
  return(df_lookup)
}