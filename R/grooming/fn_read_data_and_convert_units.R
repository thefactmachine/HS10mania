fn_read_data_and_convert_units <- function() {
  
    ##  Objective:
    ##  The raw data contains data in various different units such as tonne and kilogram.
    ##  The alcohol products also converted into absolute amount of alcohol. For example,
    ##  If two tonnes (2000 kgs) of beer are exported and this has 5% alcohol, then the program
    ##  converts this to 100 kgs of alcohol
    ##  Such that data can be aggregated, units need to be converted to a common base.
    
    ##  Plan of attack
    ## load in various concordances and raw data. Partition data into alcohol and non-alcohol
    ## perform various conversions on the alcohol and non-alcohol sets.
    ## club the two data sets together and return the result
   
    ##  Author:Mark Hatcher, Sector Trends 2015.
    ## Peer review: Ilkka Havukkala 18 April 2016 ok
    
    # ======================================================
    # load in merchandise exports and call it "df_exports"  (3630442)
    load("inputs/Exports_By_Country_20151231.rda")
    df_exports <- Exports_By_Country; rm(Exports_By_Country)
    
    # get rid of some variables
    df_exports$Harmonised_System_Description <- NULL
    df_exports$Re_exports_NZD_fob <- NULL
    df_exports$Re_exports_Qty <- NULL
   
    # ==================================================================================================
    
    # read in alcohol conversion rates and product codes
    df_al_conv <- read.csv(file = "inputs/concordances/alcohol_conversion.csv", header = TRUE)
    
    # read in the data.frame of product codes
    df_pc <- read.csv(file = "inputs/concordances/product_codes.csv", header = TRUE, 
                      colClasses = c("character", "character"))
    
    # ======================================================
    # Following section converts litres (LTR) to litres of alcohol (LPA)
    
    # create a conversion table for alcohol. Columns: alcohol type, percent alcohol, HS10 code
    df_conv_table <- inner_join(df_al_conv, df_pc, by = c("name" = "name"))
    
    
    df_exports <- df_exports %>% rename(Total_Exports_NZD_fob = Total_Export_NZD_fob)
    
    df_exports$Harmonised_System_Code <- as.character(df_exports$Harmonised_System_Code)
    
    
    
    # partition df_exports into two tables: alcohol and non-alcohol
    # two extra columns have been added to df_alcohol: "name" and "con_rate"
    df_alcohol <- df_exports %>% inner_join(df_conv_table, 
    						by = c("Harmonised_System_Code" = "code"))
    
    # apply the columns which were added. 
    df_alcohol <- df_alcohol %>% 
    	mutate(Total_Exports_Qty = ifelse(Unit_Qty == "LTR", con_rate * Total_Exports_Qty, Total_Exports_Qty),
    	Unit_Qty = ifelse(Unit_Qty == "LTR", "LPA", "LTR")) %>%
    	select(-con_rate, -name)
    
    						
    # negation of alcohol. For stuff that is not alcohol, we convert "Tonnes" to Kilograms
    N_df_alcohol <- df_exports %>% 
    	anti_join(df_conv_table, by = c("Harmonised_System_Code" = "code")) %>%
    	mutate(Total_Exports_Qty = ifelse(Unit_Qty == 'TNE', Total_Exports_Qty * 1000, Total_Exports_Qty),
    	Unit_Qty = ifelse(Unit_Qty == 'TNE', 'KGM', as.character(Unit_Qty)))
  
    # ASSERT: two tables have been partitioned correctly						
    stopifnot(nrow(N_df_alcohol) + nrow(df_alcohol) == nrow(df_exports))
    
    # now that we have done the work on df_alcohol, its time to put df_exports back together again
    df_exports <- bind_rows(df_alcohol, N_df_alcohol)
    
    # ======================================================
    return(df_exports)
}

