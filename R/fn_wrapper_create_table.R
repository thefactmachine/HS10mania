fn_wrapper_create_table <- function(a_df_exports, 
                            a_vct_HS10_codes, 
                            a_vct_top_country, 
                            a_int_n_prev_year, 
                            a_str_product_name, 
                            a_int_reporting_yr,
                            a_str_quantity_units,
                            a_vct_dte_params) {
  
  # The purpose of this function is to create a latex table for insertion into the main pdf report.
  # To do this, there are 4 main steps:
  
  # [1] Create a df of quantity, value and price for the top n countries (a_vct_top_country). To this
  # data.frame two additional rows are added: "Other" (all remaining countries) and "Total" the function
  # fn_country_product_year() is responsible for this task.
  
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  

  source('R/create_table_data/fn_country_product_rolling_year.R')
  
  # [2] Create compound percentage changes for the current reporting year ( a_int_reporting_yr ) compared
  # to a previous period. This previous period is n number of years ( a_int_n_prev_year)  
  # prior the current reporting period.
  source('R/create_table_data/fn_calc_pc.R')
  
  
  # [3] Based on steps 1 & 2 we have raw values stored as numerics. These are formated to include commas
  # and percentage signs..etc
  source('R/create_table_format/fn_fmt_millions.R')
  source('R/create_table_format/fn_fmt_kilo_to_tonne.R')
  source('R/create_table_format/fn_fmt_single_dec.R')
  source('R/create_table_format/fn_fmt_pc.R')
  source('R/create_table_format/fn_fmt_price.R')
  
  
  # [4] Assemble various components and convert the formated data.frame into a latex tex object. 
  source("R/create_table_latex/fn_wrapper_create_latex_table.R")
  
  
  # Step 1 - quantity, value, price (i.e. qvp) for top n countries (in order) for reporting year
  df_now_qvp <- fn_country_product_rolling_year(a_df_exports, 
                                        a_vct_HS10_codes,
                                        a_vct_top_country, 
                                        a_vct_dte_params["curr_lower"], 
                                        a_vct_dte_params["curr_upper"])

  # Step 2 =  Run the previous function with a different reporting period
  df_before_qvp <- fn_country_product_rolling_year(a_df_exports, 
                                        a_vct_HS10_codes,
                                        a_vct_top_country, 
                                        a_vct_dte_params["prev_lower"], 
                                        a_vct_dte_params["prev_upper"])   
  
  # calculate compound growth (i.e carg for quanity, value, price - ie qvp) 
  df_pc_qvp <- fn_calc_pc(df_before_qvp, df_now_qvp, a_int_n_prev_year) 

  # add an elasticity column 
  df_pc_qvpe <- df_pc_qvp %>% mutate(elasticity = quantity_carg / price_carg)
 
  # combine quanity, value and price (df_now_qvp) with their associated percentages (df_pc_qvp)
  # df_now_qvp = 8 x 3; df_pc_qvpe = 8 x 4. Resul of bind_cols = 8 x 7
  df_now_comp <- bind_cols(df_now_qvp, df_pc_qvpe)
  
  
  # Step 3 - format the raw values
  # assemble a vector of functions. These are used to format the raw numbers. The order of the
  # functions below correspond to the order of the columns in df_now_comp.
  vct_fn <- c(fn_fmt_kilo_to_tonne, fn_fmt_millions, fn_fmt_price, 
              replicate(3,fn_fmt_pc), fn_fmt_single_dec)
  
  # apply the vector of functions (vct_fn) to each column of df_now_comp
  # seq_along(df_now_comp) results in a vector of: 1...n(cols)
  # therefore x in function(x) is passed 1..n(cols) and this means that vct_fn[[x]] returns
  # a function corresponding to column n
  
  # FOLLOWING FOR DEBUGGING
  # print(df_now_comp)
  
  # assign("test_df", df_now_comp, envir=globalenv())
  
  df_now_comp_fmt <-  do.call(cbind, 
                             lapply(seq_along(df_now_comp), 
                                    function(x) vct_fn[[x]](df_now_comp[,x])
                             ) #lapply
                      ) # do.call
  
  fn_message_log(a_str_product_name, "table data - created (not saved to disk)")
  

  # Step 4 - Assemble the various components and create a latex tex file
  # create a data.frame of row names for the final table
  df_row_names <- data.frame(Country = c(a_vct_top_country, "Other", "Total"))
  
  # create the final table
  df_final_table <- bind_cols(df_row_names, df_now_comp_fmt)
  
  # create a named vector to pass into fn_wrapper_create_latex_table()
  vct_tbl_params <- c(top_n = 6, product = a_str_product_name, 
                      year = a_int_reporting_yr, cagr_n = a_int_n_prev_year,
                      quantity_units = a_str_quantity_units)
  
  # create the latex tex object
  str_tex <- fn_wrapper_create_latex_table(df_final_table, 
                                           vct_tbl_params, 
                                           dte_end_period = a_vct_dte_params["curr_upper"])
  
  # create the file name
  str_file_name <- paste0("export_", a_str_product_name, "_tab1.tex")

  tex_path <- file.path(PROJHOME, "outputs", "latex_table", str_file_name )
  
  # finally..!!!  save the file
  writeLines(str_tex,  tex_path)
  
  fn_message_log(a_str_product_name, "tex data for table created - (outputs/latex_table)")
  
}
