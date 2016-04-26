fn_wrapper_create_product_report <- function(a_str_product) {
  # this function creates a PDF file (and associated graphs and tex files..) each time it  is called.  
  # "a_str_product" is the name of a specific product. eg "salmon" 
  # This function is called from integrate.R
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  

  # we need to work out what the associated units of measurement are for specific product
  source('R/grooming/fn_get_distinct_units.R')
  source('R/utilities/fn_get_unit_parameters.R')
  
  # gets the top n countries for specific HS10 codes
  source('R/fn_top_n_countries_rolling.R')
  source('R/utilities/fn_get_date_parameters.R')
  
  # wrapper functions to create: tex table; png graphs and then
  # compile it all together in a pdf stored in /output/pdf
  source('R/fn_wrapper_create_table.R')
  source('R/fn_wrapper_create_all_graphs.R')
  source('R/fn_wrapper_compile_pdf.R')

  
  # PLAN OF ATTACK -- This function consists of three main sections:
  # [1] Preliminaries - to run the rest of this function we need:
  # a) We need the HS10 codes for a specific product and 
  # b) the top 6 exporting countries for a specific product.
  
  # [2] Obtain the product's unit of measurement (e.g Kilogram) and associated parameters
  
  # [3] Create a latex "tex" table for use in the PDF report (saved in output/latex_table)
  
  # [4] Create five graphs to use in the PDF report (saved in output/graphs)
  
  # [5] Create the pdf report by using the previous components and also creating a 
  # containing latex structure (stored in output/latex_tex)
  
  #----------------------------------------------------------------------
  # voici le code
  
  # write a message to the screen so the user knows what's happening.
  fn_message_log(a_str_product, "preparing data")
  
  # [1] Preliminaries 
  # get a vector of the HS10 codes associated with the current product
  vct_HS10_codes <- lst_prod_codes[[a_str_product]]

  
  # get the start & end dates for the current period and n periods prior
  vct_dte_params <- fn_get_date_parameters(df_me_exports$Date, 
                                           int_n_years_prev = c_num_previous_years)
  
  # get the top n countries for a specific set of HS10 codes, and report year
  vct_top_country <- fn_top_n_countries_rolling(df_me_exports, vct_HS10_codes, 
                                                c_top_n_countries, 
                                                vct_dte_params["curr_lower"], 
                                                vct_dte_params["curr_upper"]) 
  
  # [2] Units of measurement
  # products have a unit of measurement (i.e. KGs.) We get these units for the current product
  vct_distinct_units <- fn_get_distinct_units(df_me_exports, vct_HS10_codes)
  
  # atm..we can't cope with products with more than 1 type of units
  stopifnot(length(vct_distinct_units) == 1)
  
  # get some unit parameters for the graphs. There is only 1 unit type 
  df_unit_params <- fn_get_unit_parameters(df_unit_lookup, vct_distinct_units)
  
  # [3] Create the latex tex table 
  # create the latex tex table. saved in output/latex_table
  fn_wrapper_create_table(df_me_exports, vct_HS10_codes, 
                          vct_top_country, c_num_previous_years, 
                          a_str_product, int_report_year, 
                          a_str_quantity_units = df_unit_params$val_y_axis,
                          vct_dte_params)

    
  # [4] Create the five graphs
  # prepare a vector of arguments for fn_wrapper_create_all_graphs()
  lst_args <- list(product_name = a_str_product, int_val_divisor = df_unit_params$val_div, 
                   int_vol_divisor = df_unit_params$vol_div, 
                   str_vol_units = df_unit_params$vol_y_axis,
                   str_title_year_end = str_month_end, 
                   str_vol_units_y_axis = df_unit_params$val_y_axis)
  
  # create all five graphs
  fn_message_log(a_str_product, a_str_message = "about to call fn_wrapper_create_all_graphs(...)")
  fn_wrapper_create_all_graphs(df_me_exports, vct_HS10_codes, vct_top_country, lst_args)
  
  # [5] Create the pdf report
  # call with name of current product and HS10 codes
  
  fn_wrapper_compile_pdf(a_str_product, vct_HS10_codes)
  
  fn_message_log(a_str_product, "pdf file - created!! - go and collect your new pdf report (outputs/pdf)")

  }
