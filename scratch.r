


source('R/create_table_data/fn_country_product_rolling_year.R')

a_df_exports <- df_me_exports
a_vct_HS10_codes <- lst_prod_codes[[1]]
a_vct_top_country <- c("French Polynesia" ,"Solomon Islands","New Caledonia", "Fiji" ,"Samoa, American" ,"Malaysia")
vct_test_country <- c("Solomon Islands","French Polynesia" ,"Samoa, American" ,"New Caledonia", "Fiji" , "Malaysia")
vct_test_country_sans_malaysia <- c("Solomon Islands","French Polynesia" ,"Samoa, American" ,"New Caledonia", "Fiji")

# match(a_vct_top_country, vct_test_country_sans_malaysia)


a_vct_dte_params <- c(curr_upper = "2015-11-30", curr_lower = "2014-12-31", prev_upper = "2012-11-30", prev_lower  = "2011-12-31")

df_before_qvp <- fn_country_product_rolling_year(a_df_exports, 
                                                 a_vct_HS10_codes,
                                                 a_vct_top_country, 
                                                 a_vct_dte_params["prev_lower"], 
                                                 a_vct_dte_params["prev_upper"])  


df_before_qvp







df_now_qvp <- fn_country_product_rolling_year(a_df_exports, 
                                              a_vct_HS10_codes,
                                              a_vct_top_country, 
                                              a_vct_dte_params["curr_lower"], 
                                              a_vct_dte_params["curr_upper"])

df_now_qvp

vct_before_country <- df_before_qvp$Country

df_before_qvp_corrected <- data.frame(Country = character(0), 
                                      quantity = numeric(0), 
                                      value = numeric(0),
                                      price = numeric(0)
                                      )

df_if_missing <- data.frame(Country = NA, quantity = NA, value = NA, price = NA)

for (i in 1:nrow(df_now_qvp)) {
  vct_now_i_country <- as.character(df_now_qvp[i, "Country"])
  print(vct_now_i_country)
  
  if (!is.na(match(vct_now_i_country, vct_before_country))) {
    print("not na so we just shove the normal data in")
    df_before_qvp_corrected <- rbind(df_before_qvp_corrected, df_before_qvp[i,])
   }
  else {
    print("this is na")
    df_if_missing <- df_if_missing[1, "Country"] <- "missing"
    df_before_qvp_corrected <- rbind(df_before_qvp_corrected, df_if_missing)
  }
  #print(match(vct_now_i_country, vct_before_country))
}

df_before_qvp_corrected














