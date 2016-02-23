fn_create_cover_tex <- function(str_month_year) {
  # purpose of this function is to return a string in tex format
  # the only parameter is string containing the month and year...
  # example: "September 2015"
  
  line_a10 <- "\\documentclass{mbie-report}"
  line_a20 <- "\\classification{}"
  line_a30 <- "\\issn{}"
  line_a40 <- "\\title{Short title}{Export Intelligence Reports}"
  line_a50 <- "\\subtitle{}"
  line_a60 <- "\\author{Sector Trends}"
  line_a70 <- paste0("\\date{",str_month_year, "}")
  vct_a <- c(line_a10, line_a20, line_a30, line_a40, line_a50, line_a60, line_a70)
  
  line_b10 <- "\\begin{document}"
  line_b20 <- "\\maketitle"
  line_b30 <- "\\end{document}"
  vct_b <- c(line_b10, line_b20, line_b30) 
  
  vct_compile <- c(vct_a, vct_b)

    # convert the vector into one long string
  str_compile <- paste0(vct_compile, collapse = "\n")
  
  return(str_compile)

}