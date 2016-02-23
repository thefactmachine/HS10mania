fn_create_pdf_compile_tex <- function(vct_pdf_titles){
  # This function gets passed a vector of completed pdf titles
  # it then creates a single tex file that will compile into
  # a single pdf containing the pdf_titles.
  
  line_a10 <- "\\documentclass{article}"
  line_a20 <- "\\usepackage{pdfpages}"
  line_a30 <- "\\begin{document}"
  line_a40 <- "\\includepdf[pages={1,2}]{../cover_page/cover_page.pdf} "
  
  str_pdf_stub <- "\\includepdf{..//pdf//"
  vct_products <- paste0(str_pdf_stub, vct_pdf_titles, "}")
  
  line_b10 <- "\\end{document}"
  vct_compile <- c(line_a10, line_a20, line_a30, line_a40, vct_products, line_b10)
  str_to_save <- paste0(vct_compile, collapse = "\n")
  return(str_to_save)

}