fn_message_log <- function(a_str_product, a_str_message)  {
  # displays a progress message to the console
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  quote <- intToUtf8(34)
  c_time <- format(Sys.time(), "%X")
  str_calling_fn = as.list(sys.call(-1))[[1]]
  str_calling_function <- as.character(sys.call(-1))
  str_message <- paste0(c_time, " - ", str_calling_fn, "()", " is making: ", quote , a_str_product, quote ," ", a_str_message)
  message(str_message)
}