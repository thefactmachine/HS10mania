fn_create_graph_monthly <- function(df_data, str_dir_pfx, str_product, 
                                    str_graph_type, str_title_yr_end, ...) {
  # function creates a monthly graph of either: value, volume or number of countries.
  # the specific graph is dependent on the parameter str_type. The remaining parameters are:
  
  # df_data:  contains columns for each of the three graphs
  # str_dir_pfx: This is concatenated with a specific directory for each of the three graphs
  # str_product:  name of the actual product. Eg "Salmon"
  # str__graph_type: is either "value" , "volume" "count"
  # str_unit: this is the type of units. This is used for the volume graph.

  # better check that a correct parameter was passed correctly. If not fail elegantly
  bln_correct_graph_type <-any(str_graph_type == "volume", 
                      str_graph_type ==  "value", str_graph_type ==  "count")
  stopifnot(bln_correct_graph_type)
  
  # create pretty product title for display
  source('R/utilities/fn_create_display_title.R')
  str_prod_title_display <- fn_create_display_title(str_product)
  
  # extract the optional str_units argument -- it is only used in the volume graph
  if (missing(...)) str_units <- "ERROR UNDEFINED"  else str_units <- list(...)[[1]]

  
  # We change various items depending on the graph type
  switch(str_graph_type,
         value =   {
           str_title_stub = "Total Monthly Value" 
           str_y_axis = "Total Value (NZ$000) \n"
           df_data <- df_data %>% mutate(measure = tot_value)
           str_dir_sfx <- "monthly_value"
         },
         
         volume =  {
           str_title_stub = "Total Monthly Volume"
           str_y_axis = paste0("Total Volume (", str_units, ")\n")
           df_data <- df_data %>% mutate(measure = tot_volume)
           str_dir_sfx <- "monthly_volume"
         },
         count =   {
           str_title_stub = "Monthly Count of Country/Territory" 
           str_y_axis = "Number of Countries \n"
           df_data <- df_data %>% mutate(measure = num_countries)
           str_dir_sfx <- "monthly_number_countries"
         }
  )
  # in the switch statement above, we have assigned the column "measure" the relevant column
  # so we just need to keep the date and measure columns
  df_data <- df_data %>% select(date, measure)
  
  # create a full path to save the png creates a string with a format similar to:
  # output/graphs/monthly_value/salmon_monthly_volume.png 
  str_path <- paste0(str_dir_pfx, "/", str_dir_sfx, '/', 
                     tolower(str_product),  "_monthly_", str_graph_type, ".pdf") 
  
  # create the graph title
  str_title <- paste0(str_prod_title_display," - ", str_title_stub, " (year ending ", str_title_yr_end, ")")
  
  # call to CairoPNG() creates a graphic device and stores the result at str_path
  cairo_pdf(str_path, width = 11, height = 2.8)
  print(
    ggplot(df_data, aes(x = date, y = measure)) +
      theme_minimal() +
      geom_line() + 
      theme_light(11, base_family = "Calibri") +
      scale_colour_manual("Domain", values = mbie.cols(1:7)) + 
      scale_y_continuous(str_y_axis, label = comma) +
      theme(legend.text = element_text(lineheight = 1), legend.key.height = grid::unit(1, "cm")) +
      stat_smooth(method = "loess") +
      theme(axis.title.x = element_blank()) +
      theme(legend.key = element_blank()) +
      ggtitle(str_title)
  )
  # call to invisible() supresses "null device...." message
  invisible(dev.off())
}