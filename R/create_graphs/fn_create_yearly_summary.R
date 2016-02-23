fn_create_yearly_summary <- function(df_data, a_int_report_year) {
  # creates a yearly summary of volume, value & price (3 measures) for each year (n_years)
  # initally creates a n_years (rows) by 3 (columns) measures data_frame but for display
  # in ggplot, this is re-formatted using gather() to a structure with nrows = n_years * 3
  
  df_return <- df_data %>%
    mutate(year = lubridate::year(date)) %>%
    filter(year <= a_int_report_year) %>%
    group_by(year) %>%
    summarise(
      tot_volume = sum(volume),
      tot_value = sum(value),
      tot_price = sum(tot_value / tot_volume)
    ) %>%
    # format for display in ggplot (this should really be done within ggplot)
    mutate( 
      tot_volume = tot_volume / 1e3,
      tot_value = tot_value / 1e6,
      tot_price = round(tot_price, 1)
    ) %>%
    gather("domain", "value", 2:4)
  
  return(df_return)
}