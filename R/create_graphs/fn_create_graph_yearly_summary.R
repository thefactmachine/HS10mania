fn_create_graph_yearly_summary <- function(df_data, str_dir, str_product, a_int_rpt_year) {
  # creates a yearly bar graph for volume, value and price
  # saves the graph as a png to the path specified by str_title (see below)
  
  # create a full path to save the png
  str_path <- paste0(str_dir, "/", str_product,  "_yearly_summary.pdf") 
  
  # create pretty product title for display
  source('R/utilities/fn_create_display_title.R')
  str_prod_title_display <- fn_create_display_title(str_product)
  
  # this is the title of the graph
  str_title <- paste0(str_prod_title_display, " - ", "Total Yearly Quantity, Value and Price (year ending ", 
                      a_int_rpt_year, ")")
 # print(head(df_data))

  levels(df_data$domain) <- c("Total volume", "Total value", "Total price")
  
  cairo_pdf(str_path, width = 11, height = 2.8)
  print(
    ggplot(df_data, aes(x = year, y = value, fill = domain)) +
      geom_bar(stat = "identity", position = "dodge") +
      facet_wrap(~domain, scales = "free_y") +
      theme_light(11) +
      theme(legend.text = element_text(lineheight = 0.6), legend.key.height = grid::unit(0.8, "cm"), 
            legend.position = "right") +
      theme(legend.position = "none") + 
      labs(x = "Year") +
      labs(y = "Value") +
      ggtitle(str_title)
  )
  # call to invisible() supresses "null device...." message
  invisible(dev.off())
}