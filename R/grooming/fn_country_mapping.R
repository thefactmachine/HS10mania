fn_country_mapping <-  function(a_df_exports) {
 ##  Objective:
  ##   The objective is to create a look up table to map existing country names
  ##   to names more suitable for display.  For example, "Hong Kong, Special Administrate Zone"
  ##  is mapped to "Hong Kong"
  
  ##  Plan of attack 
  ##  Program reads is the latest export data and then creates a listing of
  ##  unique country names.  A csv file of replacement names is then read in (df_orig_to_new)
  ## Then a mapping table is created, containing an exhaustive list of country names
  
  ## Author:Mark Hatcher, Sector Trends 2015.
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  

    # get a list of distinct countries
  df_country_distinct <- a_df_exports %>% distinct(Country) %>%
  						select(Country) %>%
  						rename(country_name = Country) %>%
  						# country was defined as a factor..so as.character() converts this to a character vector
  						mutate(country_name = as.character(country_name)) 
  						
  # read in a data frame that contains a listing of 'existing country name' to 'new country name'
  df_orig_to_new <- read.csv(file = "inputs/concordances/country_lookup.csv", 
                             header = TRUE, colClasses = c("character", "character"), sep = ",")

  # following creates a mapping of all countries names (based on the most recent merchandise export data) and 
  # then a column that specifies a new name for the country.  The purpose of this is to create an exhausive
  # list of existing country names that map to names more suitable for display										
  df_country_lu <- left_join(df_country_distinct, df_orig_to_new, by = c("country_name" = "orig_name"))  %>%
  					mutate(derived = ifelse(is.na(new_name), country_name, new_name)) %>%
  					select(-new_name) %>%
  					rename(orig_name = country_name, new_name = derived)
  
  # convert Country to character type...so we can join to character type in df_country_lu
  a_df_exports$Country <- as.character(a_df_exports$Country)
  
  # we have created a data frame on old_names and new_names (in df_country_lu) now we replace..
  # replace the old country names with the new country names
  df_return <- inner_join(a_df_exports, df_country_lu, by = c("Country" = "orig_name")) %>%
    mutate(Country = factor(new_name)) %>%
    select(-new_name)
  
  # want to make sure that nothing got lost in the joins performed above
  stopifnot(nrow(df_return) == nrow(a_df_exports))
  
  return(df_return)

}
