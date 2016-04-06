fn_create_tex_file <- function(str_current_product, a_vct_HS10_codes) {
  # purpose of this function is to create a tex file for latex use
  # the various lines of "tex' are divided up into chunks and then
  # concatenated into character vectors (eg vct_a). These vectors
  # are then concatenated into a larger vector and this is saved to disk
  # using writeLines(). 
  
  # most of the following comments describe latex functionality rather than
  # R functionality
  
  # re-format the product name for the title
  source('R/utilities/fn_create_display_title.R')
  str_product_title <- fn_create_display_title(str_current_product)
  
  # we have a list of 10 digit HS10 codes. We extract the first
  # six digits and then make them unique. The resultant 6 digit 
  # vector is converted into a string. This is displayed as a footnote
  source('R/create_pdf/fn_get_unique_HS10_stubs.R')
  str_disp_HS10 <- fn_get_unique_HS10_stubs(a_vct_HS10_codes)

 
  
  # define spaces
  c_3_space <- "   "
  c_4_space <- "    "
  # define 3 blank lines
  c_blank_lines <- c("", "", "")
  
  line_a10 <- "\\documentclass[10pt]{article}"
  
  # float enables [H] to mean here and only here
  line_a20 <- "\\usepackage{float}"
  
  # used for AddToShipOutPicture
  line_a30 <- "\\RequirePackage{eso-pic}"
  
  # suppress "table 1" like captions
  line_a40 <- "\\usepackage{caption}"
  line_a50 <- "\\captionsetup[table]{labelformat=empty}"
  vct_a <- c(line_a10, line_a20, line_a30, line_a40, line_a50, c_blank_lines)
  
  # set margins for a4 paper
  line_b10 <- "\\usepackage{geometry}"
  line_b20 <- "\\geometry{"
  line_b30 <- "a4paper,"
  line_b40 <-  "left=11mm,"
  line_b50 <- "right=14mm,"
  line_b60 <- "top=37mm,"
  line_b70 <- "bottom=14mm,"
  line_b80 <- "}" 
  vct_b <- c(line_b10, line_b20, line_b30, line_b40, line_b50, line_b60, line_b70, line_b80, c_blank_lines)
  
  # to render the table
  line_c10 <- "\\usepackage{colortbl}"
  
  # setmainfont requires fontspec. 
  line_c20 <- "\\usepackage{fontspec}"
  line_c30 <- "\\setmainfont[Ligatures=TeX]{Calibri}"
  vct_c <- c(line_c10, line_c20, line_c30, c_blank_lines)
  
  # define background picture
  line_d10 <- "\\newcommand\\BackgroundPic{%"
  line_d20 <- "\\put(0,0){%"
  line_d30 <- "\\parbox[b][\\paperheight]{\\paperwidth}{%"
  line_d40 <- "\\vfill"
  line_d50 <- "\\centering"
  line_d60 <- "\\includegraphics{MBIE_generic_background.pdf}%"
  line_d70 <- "\\vfill"
  line_d80 <- "}}}"
  vct_d <- c(line_d10, line_d20, line_d30, line_d40, line_d50, line_d60, line_d70, line_d80,  c_blank_lines)
  
  
  # finished with the preamble. Now to create the document
  line_e10 <- "\\begin{document}"
  # suppress page numbers
  line_e15 <- "\\thispagestyle{empty}"
  # display the background picture using previously defined "BackgroundPic" command
  line_e20 <- "\\AddToShipoutPicture{\\BackgroundPic}"
  
  # the title here is parameterised
  line_e30 <- paste0("\\section*{Key Export Statistics\\footnotemark - ", 
                     str_product_title, "\\footnotemark }")
  
  # insert today's date
  # line_e40 <- "\\today\\\\"
  line_e40 <- paste0("Published on ", glob.env$vct_disp_dates['today'],".", " \\par")
  
  str_date_start_fin <- paste0("Monthly data from ", 
                               glob.env$vct_disp_dates['min'], 
                               " to ", 
                               glob.env$vct_disp_dates['max'])
  
  line_e41 <- paste0("\\small{\\noindent{\\textit{", str_date_start_fin, ".", "}}}")
  
  
  # following inserts the tex table which is created dynamically
  line_e50 <- paste0("\\input{../latex_table/export_", str_current_product, "_tab1.tex}")
  line_e60 <- "\\vspace{-0.7cm}"
  
  vct_e <- c(line_e10, line_e15, line_e20, line_e30, line_e40, line_e41, line_e50, line_e60,  c_blank_lines)
  
  
  # start inserting the graphs.  These are created dynamically
  line_f10 <- paste0(c_3_space, "\\begin{figure}[H]")
  line_f20 <- paste0(c_3_space,"\\centering")
  
  # graph 1 MONTHLY VALUE
  line_f30 <- paste0(c_4_space, "\\includegraphics[scale=0.5]{../graphs/monthly_value/", 
                    str_current_product, "_monthly_value.png} \\")
  
  # graph 2 MONTHLY VOLUME
  line_f40 <- paste0(c_4_space, "\\includegraphics[scale=0.5]{../graphs/monthly_volume/", 
                    str_current_product,"_monthly_volume.png} \\")
  
  # graph 3 SMOOTHED PRICE
  line_f50 <- paste0(c_4_space, "\\includegraphics[scale=0.5]{../graphs/smoothed_price/", 
                    str_current_product , "_smoothed_price.png} \\")
  
  # graph 4  NUMBER OF COUNTRIES
  line_f60 <- paste0(c_4_space, "\\includegraphics[scale=0.5]{../graphs/monthly_number_countries/", 
                    str_current_product, "_monthly_count.png} \\")
  # graph 5 YEARLY SUMMARY
  line_f70 <- paste0(c_4_space, "\\includegraphics[scale=0.5]{../graphs/yearly_summary/", 
                    str_current_product, "_yearly_summary.png} \\")    
  
  
  line_f80 <- paste0(c_3_space, "\\end{figure}")
  vct_f <- c(line_f10, line_f20, line_f30, line_f40, line_f50, line_f60, line_f70, line_f80, c_blank_lines)  
  
  
  
  line_g10 <- "\\footnotetext[1]{Source: Statistics New Zealand - Overseas Merchandise Trade}"
  
  
  line_g20_a <- paste0("\\footnotetext[2]{Harmonised System Codes for ", str_product_title, 
                       " starting with: ", str_disp_HS10, ".}")
  #line_g20 <- "\\footnotetext[2]{Harmonised System Code for Beer starting with 220300}"
  
  
  line_g30 <- "\\end{document}"
  vct_g <- c(line_g10, line_g20_a, line_g30)
  
  # the following is a vector of strings
  vct_compile <- c(vct_a, vct_b, vct_c, vct_d, vct_e, vct_f, vct_g)
  
  # convert the vector into one long string
  str_compile <- paste0(vct_compile, collapse = "\n")
  
  return(str_compile)

}
