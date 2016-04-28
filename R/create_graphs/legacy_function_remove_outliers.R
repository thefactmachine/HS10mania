# following legacy code needs to be re-written...don't know what it does
# Peer review: Ilkka Havukkala 21 April 2016 runs ok, but could be doucmented/reviewed for rationale

remove_outliers <- function(x, low_lim, up_lim, na.rm = TRUE, ...) {
  fn_message_log(a_str_message = "removing outliers for smoothed price graph") 
  qnt <- quantile(x, probs=c(low_lim, up_lim), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}
