fn_read_product_codes <- function() {
   # reads a csv file of key-value pairs and returns a list where the
   # the specific product name (eg "salmon") is the list name
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
   df_codes <- read.csv("inputs/concordances/product_codes.csv", 
                        colClasses = c("character", "character"))
   
   lst_codes <- split(df_codes$code, df_codes$name)
   return(lst_codes)
   
}