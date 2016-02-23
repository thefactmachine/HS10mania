fn_message_log <- function(a_str_product, a_str_message)  {
  # displays a progress message to the console
  quote <- intToUtf8(34)
  c_time <- format(Sys.time(), "%X")
  str_message <- paste0(c_time, " - ", quote , a_str_product, quote ," ", a_str_message)
  message(str_message)
}