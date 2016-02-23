fn_read_unit_lookup <- function() {
  # reads in the units_lookup csv and returns a data.frame
  df_lookup <- 
      read.csv("inputs/concordances/units_lookup.csv", 
               colClasses = c("character", "numeric", "numeric",  "character", "character"))
  return(df_lookup)
}