fn_wrapper_compile_pdf <- function(a_str_product, a_vct_HS10_codes) {
  # purpose of this function is create a PDF file from the various artefacts previously created.
  # to do this: 
  
  # [1] a tex file is initially created (see fn_create_tex_file) this file is saved
  # in the "latex_tex" folder. If the structure of the report needs to be changed..then
  # it should be changed in within this function
  
  # [2] a knitr file is created from the tex file in step 1. This is necessary as the 
  # knit2pdf() function requires a knitr file
  
  # [3] The knit2pdf function creates the pdf file
  
  # [4] The resultant pdf file is copied to the "pdf" folder. An intermediate tex file
  # created in the "latex_tex" folder is then created

  # Peer review: Ilkka Havukkala 21 April 2016 OK
  
  
  source('R/create_pdf/fn_create_tex_file.R')
  # [1] create tex file and save to the  "latex_tex" folder
  tex_string <- fn_create_tex_file(a_str_product, a_vct_HS10_codes)
  
  tex_path <- file.path(PROJHOME, "outputs", "latex_tex", paste0(a_str_product, ".tex"))
  write(tex_string, tex_path)
  fn_message_log(a_str_product, "base Latex tex file - created (outputs/latex_tex)")
  
  # [2] create knitr file: read in the tex and then convert the sucker and save it
  str_knitr_file_name <- paste0(a_str_product, ".rnw")
  str_knitr_path <- file.path(PROJHOME, "outputs", "latex_knitr", str_knitr_file_name)
  
  readChar(tex_path, file.info(tex_path)$size) %>%
    Sweave2knitr(text = .) %>%
    write(.,str_knitr_path)
  fn_message_log(a_str_product, "knitr file - created (outputs/latex_knitr)")
  # [3] Use the knit2pdf() function to convert the knitr file created in step 2 to a pdf  
  
  # knit2pdf needs to run in the directory where the knitr file is saved  
  fn_message_log(a_str_product, "pdf file - starting to make - please be patient!")
  setwd(file.path(PROJHOME, "outputs", "latex_knitr"))
  
  
  # invisible = suppresses output messages
  invisible(
    knit2pdf(input = str_knitr_file_name,
             compiler = 'xelatex', 
             quiet= TRUE, 
             clean = TRUE) # knit2pdf
  ) # invisible
  # set the working directory back
  setwd(PROJHOME)
  
  # [4] Copy the pdf file the "pdf" folder and delete an intermediate file
  # copy the pdf file 
  path_from <- file.path(PROJHOME, "outputs", "latex_knitr", paste0(a_str_product, ".pdf"))
  
  # create a file name
  str_c_date <- format(Sys.Date(), "%Y%m%d")
  str_dest_file_name <- paste0(a_str_product, "_", str_c_date, ".pdf")
  
  path_to <- file.path(PROJHOME, "outputs", "pdf", str_dest_file_name)
  
  # if the pdf previously exists in the destination folder, then delete it. This is because...
  # the file.copy() command will not smash a new file over the top of an old file
  if (file.exists(path_to)) {file.remove(path_to)}
  file.copy(from = path_from, to = path_to)
  
  glob.env$vct_pdf_names <- c(glob.env$vct_pdf_names, str_dest_file_name)
  
  #print(vct_pdf_names)
  
  # now the file has been copied. remove it
  file.remove(path_from)
  # now remove the intemidate tex file
  path_tex <- file.path(PROJHOME, "outputs", "latex_knitr", paste0(a_str_product, ".tex"))
  file.remove(path_tex)
  
}
