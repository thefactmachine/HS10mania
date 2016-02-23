fn_wrapper_create_latex_table <- function(df_table, 
                                          vct_table_params, 
                                          dte_end_period) {
  
  # this is a wrapper function that creates a latex table
  source("R/create_table_latex/fn_create_table_body.R")
  source("R/create_table_latex/fn_create_table_caption.R")
  source("R/create_table_latex/fn_create_table_columns.R")
  source("R/create_table_latex/fn_create_table_dimensions.R")
  
  vct_col_dims <- c(1.8, 1.4, 1.4, 1.6,1.9,2.0,1.9,1.5)
  str_tbl_dims <- fn_create_table_dimensions(vct_col_dims)
  nline <- paste0("\n")
  
  vct_col_names <- c("Country", "Yearly Qty", "Yearly Value",  
        "Yearly Price", "3Year CAGR(Qty)", "3Year CAGR(Value)", 
        "3Year CAGR(Price)", "Price Elasticity")
 
  # create tex-based string of column names
  str_col_names <- fn_create_table_columns(vct_col_names)
  
  # create a tex-based string for the table body
  str_table_body <- fn_create_table_body(df_table)

  # create a tex-based string for the table caption
  str_caption <- fn_create_table_caption(vct_table_params, dte_end_period)

  # assemble stuff into chunks
  str_r1 <- paste0("\\begin{table}[ht]", nline, "\\centering", nline, "{\\scriptsize" , nline)
  str_r2 <- paste0(str_tbl_dims, " ", str_col_names, nline)
  str_r3 <- paste0("\\hline", nline, str_table_body, "\\hline", nline, "\\end{tabular}", nline, "}", nline)
  str_r4 <- paste0(str_caption, nline, "\\end{table}", nline)
  
  # concatenate the chunks
  str_return <- paste0(str_r1, str_r2, str_r3, str_r4)
  return(str_return)
}