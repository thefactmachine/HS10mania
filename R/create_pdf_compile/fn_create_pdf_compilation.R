fn_create_pdf_compilation <- function(vct_pdf_names, str_file_sfx)  {
  # this creates a cover page with a month ending title
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  
  source('R/create_pdf_compile/fn_create_pdf_compile_tex.R')

  # [1] create the tex file and save the sucker
  fn_message_log("compilation pdf", "creating tex file in outputs/compile_tex")
  
  str_to_save <- fn_create_pdf_compile_tex(vct_pdf_names)
  tex_path <- file.path(PROJHOME, "outputs", "compile_tex", "compile.tex")
  write(str_to_save, tex_path)

  # [2] create knitr file: read in the tex and then convert it!
  str_knitr_file_name <- "compile.rnw"
  str_knitr_path <- file.path(PROJHOME, "outputs", "compile_tex", str_knitr_file_name)
  readChar(tex_path, file.info(tex_path)$size) %>%
    Sweave2knitr(text = .) %>%
    write(.,str_knitr_path)
 
  # [3] get the knitr file and create a pdf
  # knit2pdf needs to run in the directory where the knitr file is saved  
  fn_message_log("compilation pdf", "creating final pdf file")
  setwd(file.path(PROJHOME, "outputs", "compile_tex"))
  
  # invisible = suppresses output messages
  invisible(
    knit2pdf(input = str_knitr_file_name,
             compiler = 'xelatex', 
             quiet= TRUE, 
             clean = TRUE) # knit2pdf
  ) # invisible
  # set the working directory back
  
  # [4] get rid of the intermediate files
  if (file.exists("compile.aux")) file.remove("compile.aux")
  if (file.exists("compile.log")) file.remove("compile.log")
  if (file.exists("compile.out")) file.remove("compile.out")
  if (file.exists("compile.rnw")) file.remove("compile.rnw")
  
  # [5] copy the result and rename it
  setwd(PROJHOME)
  path_from <- file.path(PROJHOME, "outputs", "compile_tex", "compile.pdf")

  
  str_dest_file_name <- paste0("eir_",str_file_sfx,".pdf")
  path_to <- file.path(PROJHOME, "outputs", "consolidated_pdf", str_dest_file_name)

  
  file.copy(from = path_from, to = path_to)
  fn_message_log("compilation pdf", "copying final pdf to /outputs/consolidated_pdf")
  
  
  setwd(PROJHOME)

}