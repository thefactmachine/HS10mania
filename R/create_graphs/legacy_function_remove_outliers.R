# following legacy code needs to be re-written...don't know what it does
# Peer review: Ilkka Havukkala 21 April 2016 not used in integrate.r, so not evaluated

remove_outliers <- function(x, low_lim, up_lim, na.rm = TRUE, ...) {
  qnt <- quantile(x, probs=c(low_lim, up_lim), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}
