fn_create_graph_smoothed_price <- function(df_data, str_dir, str_product, a_int_rpt_year, str_price_unit) {
  # create a full path to save the png
  str_path <- paste0(str_dir, "/", str_product,  "_smoothed_price.pdf") 
  
  # create pretty product title for display
  source('R/utilities/fn_create_display_title.R')
  str_prod_title_display <- fn_create_display_title(str_product)
  
  
  # this is the title of the graph
  str_title <- paste0(str_prod_title_display," - ", "Smoothed Monthly Unit Price History (year ending ", 
                      a_int_rpt_year, ")")
  
  
  # create the label for the Y axis. This depends on the units of measurement (i.e. str_price_unit)
  y_axis_label <- paste0("Unit Price (", str_price_unit, ")\n")

  cairo_pdf(str_path, width = 11, height = 2.8)
  print(
    ggplot(df_data, aes(x = date, y = tot_price, color = country)) +
      theme_minimal() +
      geom_blank() + 
      stat_smooth(method = "loess", se = FALSE, na.rm = TRUE) +
      theme_light(11, base_family = "Calibri") + 
      scale_colour_manual("Country", values = mbie::mbie.cols(1:7)) + 
      scale_y_continuous(y_axis_label, label = dollar) +
      stat_smooth(data = subset(df_data, country == "Total"), method = "loess", colour = "blue", size = 1.2) +
      theme(legend.text = element_text(lineheight = 0.6), legend.key.height = grid::unit(0.4, "cm"), 
            legend.position = "bottom", legend.title = element_text(size = 12)) +
      theme(legend.text = element_text(size = 12)) +
      theme(axis.title.x = element_blank()) +
      theme(legend.key = element_blank()) +
      ggtitle(str_title)
    
  )
  # call to invisible() supresses "null device...." message
  invisible(dev.off())
}