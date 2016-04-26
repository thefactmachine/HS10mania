fn_wrapper_create_all_graphs <- function(a_df_data, a_vct_HS10, a_vct_top_n_country, a_lst_args) {
  
  # These help prepare the relevant data.frames for the 5 graphs
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  
  source('R/create_graphs/fn_monthly_summary.R')
  source('R/create_graphs/fn_filter_HS10_codes.R')
  source('R/create_graphs/fn_create_monthly_price.R')
  source('R/create_graphs/fn_create_yearly_summary.R')
  
  # These functions actually create the graphs
  # fn_create_graph_monthly(...) is used 3 times 
  source('R/create_graphs/fn_create_graph_monthly.R')
  source('R/create_graphs/fn_create_graph_yearly_summary.R')
  source('R/create_graphs/fn_create_graph_smoothed_price.R')
  
  # ==================================================================== 
  # [1] Prepare the data for the graphs
  fn_message_log(a_str_message = "about to prepare data for the five graphs") 
  # create a data.frame for use in graphs 1,2 & 4 (monthly value, monthly volume &
  # number of countries)
  df_monthly_vvn <- fn_monthly_summary(a_df_data, a_vct_HS10, 
                                       int_val_divisor = a_lst_args$int_val_divisor, 
                                       int_vol_divisor = a_lst_args$int_vol_divisor)
  
  # create a data.frame for use in graph # 3 (smoothed price)
  # step a: include only relevant H10 Codes
  df_HS10_filtered <- fn_filter_HS10_codes(a_df_data, a_vct_HS10)

  # step b: using the filtered HS10 df, we aggregate by month and include the top_n countries
  df_top_country_price <- fn_create_monthly_price(df_HS10_filtered, a_vct_top_n_country)
  
  # create a data.frame for use in graph 5 (yearly summary)
  df_yearly_summary <- fn_create_yearly_summary(df_HS10_filtered, int_report_year)
  
  fn_message_log(a_str_message = "finished preparing data. About to to create the five graphs") 
  
  # ====================================================================
  # [2] Create the actual graphs
  # graph 1 - monthly_value
  fn_create_graph_monthly(df_monthly_vvn, "outputs/graphs", 
                          a_lst_args$product_name, str_graph_type = "value", 
                          a_lst_args$str_title_year_end)
  

  # graph 2 - monthly_volume (this has extra argument for y axis units)
  fn_create_graph_monthly(df_monthly_vvn, "outputs/graphs", 
                          a_lst_args$product_name, str_graph_type =  "volume", 
                          a_lst_args$str_title_year_end, 
                          a_lst_args$str_vol_units_y_axis)

  # graph 3 - smoothed_price
  fn_create_graph_smoothed_price(df_top_country_price, "outputs/graphs/smoothed_price", 
                                 a_lst_args$product_name, a_lst_args$str_title_year_end, 
                                 a_lst_args$str_vol_units)

  # graph 4 - monthly_number_of_countries
  fn_create_graph_monthly(df_monthly_vvn, "outputs/graphs", 
                          a_lst_args$product_name, str_graph_type = "count", 
                          a_lst_args$str_title_year_end)

  # graph 5 - yearly_summary
  fn_create_graph_yearly_summary(df_yearly_summary , "outputs/graphs/yearly_summary", 
                                 a_lst_args$product_name, a_lst_args$str_title_year_end)

  }

