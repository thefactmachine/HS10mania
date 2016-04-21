fn_create_pdf_cover_page <- function(str_month_year) {
    
    # this function actually creates the tex file
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  
    source('R/create_cover_page/fn_create_cover_tex.R')
    
    fn_message_log("cover page", "starting to create")
    
    # [1] create the tex file and save the sucker
    str_to_save <- fn_create_cover_tex(str_month_year)
    tex_path <- file.path(PROJHOME, "outputs", "cover_page", "cover_page.tex")
    write(str_to_save, tex_path)
    
    fn_message_log("cover page", "cover_page.tex created and saved (outputs/cover_page)")
    
    # [2] create knitr file: read in the tex and then convert it!
    str_knitr_file_name <- "cover_page.rnw"
    str_knitr_path <- file.path(PROJHOME, "outputs", "cover_page", str_knitr_file_name)
    readChar(tex_path, file.info(tex_path)$size) %>%
      Sweave2knitr(text = .) %>%
      write(.,str_knitr_path)
    
    # [3] get the knitr file and create a pdf
    # knit2pdf needs to run in the directory where the knitr file is saved  
    
    setwd(file.path(PROJHOME, "outputs", "cover_page"))
    
    # invisible = suppresses output messages
    invisible(
      knit2pdf(input = str_knitr_file_name,
               compiler = 'xelatex', 
               quiet= TRUE, 
               clean = TRUE) # knit2pdf
    ) # invisible
    # set the working directory back
    
    # [4] get rid of the intermediate files
    if (file.exists("cover_page.aux")) file.remove("cover_page.aux")
    if (file.exists("cover_page.log")) file.remove("cover_page.log")
    if (file.exists("cover_page.out")) file.remove("cover_page.out")
    if (file.exists("cover_page.rnw")) file.remove("cover_page.rnw")
    
    setwd(PROJHOME)
    fn_message_log("cover page", "cover_page.pdf created")

}


