fn_get_date_parameters <- function(vct_dates, int_n_years_prev) {
  # int_years_prev is assumed to be an integer
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  
  # function receives a vector of dates from the entire data
  # set. The function then determines the most recent date and the 
  # date which is 12 periods (ie. months) previous. This returns
  # a pair of dates. So..in total there are 2 x pairs of dates returned
 
  fn_last_day_of_month <- function(dte_param) {
    # get the first day of the month for the input date (2012-11-23 ==> 2012-11-01)
    dte_first_day <- ymd(paste0(year(dte_param),"-", month(dte_param), "-", "01"))
    # go one month in advance
    dte_last_day <- dte_first_day + months(1)  - days(1)
    return(dte_last_day)
  }

  # it is more effecient to create a vector of unique dates here
  vct_unique_dates <- unique(vct_dates) %>% sort()

  # get the current pair of dates - the distance between these is 12 months
  # need to cast the lubridate dates back to normal dates
  dte_curr_upper <- max(vct_unique_dates)
  dte_curr_lower <- fn_last_day_of_month(dte_curr_upper - months(11)) %>% as.Date()
 
  # get the previous (i.e n years previous) pair of dates
  dte_prev_upper <- fn_last_day_of_month(dte_curr_upper - years(int_n_years_prev)) %>% as.Date()
  dte_prev_lower <- fn_last_day_of_month(dte_prev_upper - months(11)) %>% as.Date()

  # assemble the 4 values in named vector: "if you don't have a name you dont exist"
  vct_return <- c("curr_upper" = dte_curr_upper, "curr_lower" = dte_curr_lower, 
                  "prev_upper" = dte_prev_upper, "prev_lower" = dte_prev_lower)

  
  # all the above was good in theory..but lets see if our calculations..
  # ..are contained in the input data..if there not then we have a problem
  stopifnot(vct_return["curr_upper"] %in% vct_unique_dates)
  stopifnot(vct_return["curr_lower"] %in% vct_unique_dates)
  stopifnot(vct_return["prev_lower"] %in% vct_unique_dates)
  stopifnot(vct_return["prev_upper"] %in% vct_unique_dates)

  return(vct_return)
}




