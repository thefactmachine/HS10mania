fn_create_graph_smoothed_price <- function(df_data, str_dir, str_product, a_int_rpt_year, str_price_unit, vct_country_order) {

  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
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
  # create some custom colours.  There are six countries to display + 1 total (7 colours) 
  # we will distinguish the "total" value from the others by colouring dark grey
  # define dark grey
  str_dk_grey <- "#585858"
  vct_colours <- c(mbie::mbie.cols(1:6), str_dk_grey)
  # create a display order vector. This corresponds to the vct_coloours defined above.
  vct_display_order <- c(vct_country_order, "Total")
  df_data$country <- factor(df_data$country, levels = vct_display_order)
  cairo_pdf(str_path, width = 11, height = 2.8)
  print(
    ggplot(df_data, aes(x = date, y = tot_price, color = country)) +
      theme_minimal() +
      stat_smooth(method = "loess",  se = FALSE, na.rm = TRUE) +
      theme_light(11, base_family = "Calibri") + 
      scale_colour_manual("Country", values = vct_colours) + 
      scale_y_continuous(y_axis_label, label = dollar) +
      stat_smooth(data = subset(df_data, country == "Total"), method = "loess", se = FALSE, na.rm = TRUE,  colour = str_dk_grey, size = 1.2, alpha = 0.9) +
      theme(legend.text = element_text(lineheight = 0.6), legend.key.height = grid::unit(0.4, "cm"), 
            legend.position = "bottom", legend.title = element_text(size = 12)) +
      theme(legend.text = element_text(size = 12)) +
      theme(axis.title.x = element_blank()) +
      theme(panel.grid.minor.y = element_blank()) +
      theme(legend.key = element_blank()) +
      ggtitle(str_title)
    
  )
  # call to invisible() supresses "null device...." message
  invisible(dev.off())
  
  # message log
  fn_message_log(str_product,  paste0("Smoothed Monthly Price Graph - created! - saved in: ", str_path))
  
}