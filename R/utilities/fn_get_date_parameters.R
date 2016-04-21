fn_get_date_parameters <- function(vct_dates, int_n_years_prev) {
  # int_years_prev is assumed to be an integer
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  
  # function receives a vector of dates from the entire data
  # set. The function then determines the most recent date and the 
  # date which is 12 periods (ie. months) previous. This returns
  # a pair of dates. So..in total there are 2 x pairs of dates returned
 
  # this is a helper function which gets used repeatedly
  fn_last_day_n_years_prev <- function(dte_input, a_int_years_prev) {
    # function gets the date input and returns a date n years previous
    # the returned date is the last day of the month.
    # Example (assuming int_years_prev = 1) ...
    # if input is "2015-09-30" ==> output is "2014-10-31"

    # hard code the input date to be the first day of the month
    dte_input_first_day <- ymd(paste0(year(dte_input),"-", month(dte_input), "-", "01"))
    # convert the input parameter into months.    
    int_months_prev <- (a_int_years_prev * 12) - 2
    dte_return <- (dte_input_first_day - months(int_months_prev)) - days(1)
    
    # cast the result from a lubridate type date to a normal R date
    return(as.Date(dte_return))
  }

  # it is more effecient to create a vector of unique dates here
  vct_unique_dates <- unique(vct_dates) %>% sort()

  # get the current pair of dates - the distance between these is 12 months
  dte_curr_upper <- max(vct_unique_dates)
  dte_curr_lower <- fn_last_day_n_years_prev(dte_curr_upper, a_int_years_prev = 1)
  
  # get the previous (i.e n years previous) pair of dates
  dte_prev_upper <- fn_last_day_n_years_prev(dte_curr_upper, int_n_years_prev)
  dte_prev_lower <- fn_last_day_n_years_prev(dte_curr_lower, int_n_years_prev)

  # assemble the 4 values in named vector: "if you don't have a name you dont exist"
  vct_return <- c("curr_upper" = dte_curr_upper, "curr_lower" =  dte_curr_lower, 
                  "prev_upper" = dte_prev_upper, "prev_lower" = dte_prev_lower)
  
  # all the above was good in theory..but lets see if our calculations..
  # ..are contained in the input data..if there not then we have a problem
  stopifnot(vct_return["curr_upper"] %in% vct_unique_dates)
  stopifnot(vct_return["curr_lower"] %in% vct_unique_dates)
  stopifnot(vct_return["prev_lower"] %in% vct_unique_dates)
  stopifnot(vct_return["prev_upper"] %in% vct_unique_dates)

  return(vct_return)
}





