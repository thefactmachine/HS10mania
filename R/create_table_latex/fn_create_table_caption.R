fn_create_table_caption <- function(vct_a, a_dte_period_end) { 
  # functions takes basic table parameters 
  # and creates a Latex formatted table caption
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  # replace underscores with spaces for the product name to display
  # re-format the product name for the title
  
  fn_message_log(a_str_message = "creating the caption for the tex table")
  
  source('R/utilities/fn_create_display_title.R')
  str_product_title <- fn_create_display_title(vct_a["product"])
  
  str_quant_units <- vct_a["quantity_units"]
  
  #print(str_quant_units)
  
  str_month_end <- paste0(format(a_dte_period_end, "%B")," - " , 
                          format(a_dte_period_end, "%Y")) 
  
  str_caption <- paste0("Top ", vct_a["top_n"], " ", str_product_title, " Markets for year ending ", 
              str_month_end, ": Quantity (", str_quant_units,  "), Value (NZ\\$Mill) and Price.")
  
  str_caption_with_tags <- paste0("\\caption{\\scriptsize ", str_caption, "}")
  return(str_caption_with_tags)
}