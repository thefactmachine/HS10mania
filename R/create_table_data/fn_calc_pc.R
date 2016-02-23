fn_calc_pc <- function(df_prev, df_curr, int_year_diff) {
  # this function takes two data frames and compares the columns of each data frame
  # to calculate percentages. The Country columns needs to be stripped from each data frame
  
  # The following function calculates compounded annual rate of growth. The..
  # function is used by mapply() below
  fn_carg <- function(previous_value, current_value, int_ann_diff) {
    # pv = previous value; fv = current value
    return(((current_value / previous_value) ^ (1 / int_year_diff)) - 1)
  } # end of fn_carg
  
  # the call to mapply applies the fn_carg function to the columns of df_prev & df_curr
  # mapply interates through columns 1 to 3
  df_pc <- mapply(function(prev, current) fn_carg(prev, current, int_year_diff), 
              df_prev, df_curr) %>% as.data.frame()
  # create some different names
  names(df_pc) <- paste0(names(df_pc),"_carg")
  return(df_pc)
}