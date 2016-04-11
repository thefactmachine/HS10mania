# Written by:     Mark Hatcher (Sector Trends 26.02.2016)

# Objective:      This code is dependant on the RDA file saved in the directory inputs/
#                 Example: inputs/Exports_By_Country_20150930.rda
#
# Instructions:   Make sure that this code uses the latest dataset.  This code does not get the data
#                 from TRED as this takes about 30 minutes.  Instead this code uses a local RDA file.
#                 A separate program "load_from_tred.R' creates this RDA file.  Therefore, if the user
#                 requires new data, this program "load_from_tred.R" should be run first.
#                 The "load_from_tred.R" will generate an RDA file name with the most recent month's data:
#                 "Exports_By_Country_20150930.rda"  This program does not automatically detect this file name
#                 and therefore, the user will have to manually change the code.  

#                 The file that needs to be changed is "\R\grooming\fn_read_data_and_convert_units.R" ...
#                 Just simply change the file name at around line 19.

# Operation:      The short story of how this program works is as follows.... 
#                 The program loops through a list of products (which are defined as groups of HS Codes) For each
#                 product the program creates a separate PDF file. Currently there are about 22 reports (separate PDFS)
#                 And these are stored in the /outputs/pdf directory.  After these PDFS are created, the program creates
#                 a cover page (stored in /outputs/cover_page).  Finally, the program collages the individual product
#                 PDFs along with the cover page and stores the result in /outputs/consolidated_pdf

# Saving files:   This program DOES NOT ARCHIVE any files created by this automated process.  Once the user has created a set
#                 pdf files which they are happy with...the user will need to copy the relevant files to a separate directory.

# Testing:        The program can easily be run with a limited set of products. At around line 97 there is a line of code that
#                 limits the set of products to just Salmon and Honey.  The user can uncomment this line to run the program for
#                 all products.



### clear working space
rm(list = ls())


## PPL using MAC, outside of MBIE envirnment does not need to run it.
if( Sys.info()['sysname'] == 'Windows' ){
  ## set up R environment ---------------------------------------------------
  source("P:/R/common.Rprofile")
}

## load pacakges
library(Cairo) 
library(ggplot2)
library(grid)
library(knitr)
library(lubridate)
library(lazyeval)
library(mbie)
library(tidyr)
library(tools)
library(dplyr)

options(stringsAsFactors = FALSE) 
# disable scientific notation
options(scipen = 999)

# set work directory -
PROJHOME <- getwd()


# read in data / concordances
source('R/fn_read_product_codes.R')
# looks up units
source('R/utilities/fn_read_unit_lookup.R')
# cleans up the source data
source('R/grooming/fn_country_mapping.R')
# removes all files from /output/*
source('R/utilities/fn_remove_files_from_output_dir.R')
# prints a status message to the screen
source("R/fn_message_log.R")
# creates a PDF file for a specific product 
source('R/fn_wrapper_create_product_report.R')
# loads and formats the data file.  Columns are renmaed to suit this code
source('R/grooming/fn_read_data_and_convert_units.R')
# this creates a cover page with a month ending title
source('R/create_cover_page/fn_create_pdf_cover_page.R')
# once we have generated the pdfs, this joins them all together
source('R/create_pdf_compile/fn_create_pdf_compilation.R')


# read in data, convert the units and renname a few countries
df_me_exports <- fn_read_data_and_convert_units() %>% fn_country_mapping()

# read products and their codes
lst_prod_codes <- fn_read_product_codes()
# exclude some products.  These have more than 1 measurement unit type
vct_exclusions <- c("spirits", "beer", "cider_alcoholic")
lst_prod_codes <- lst_prod_codes[!names(lst_prod_codes) %in% vct_exclusions]

# read in a file that provides parameters associated with each type of unit
df_unit_lookup <- fn_read_unit_lookup()

# define some constants - these don't get changed at all.
c_num_previous_years = 3
c_top_n_countries = 6

# define some dates which are used for all reports
# get the most recent month
dte_end_date <- max(df_me_exports$Date)

# format the most recent month for display (i.e. 31.05.15 => "May -- 2015")
str_month_end <- paste0(format(dte_end_date, "%B")," - " , format(dte_end_date, "%Y")) 

# get the most recent complete year
int_report_year <- ifelse(month(dte_end_date) == 12, 
              year(dte_end_date), year(dte_end_date) - 1)

# This is testing stuff
# lst_prod_codes <- lst_prod_codes[c("salmon", "honey")]
# lst_prod_codes <- lst_prod_codes[c("peas")]
 
# before we start producing reports, delete all previous files (output/*)
fn_remove_files_from_output_dir()

# create vector with global scope to store PDF file names
glob.env <- new.env() 
glob.env$vct_pdf_names <- vector(mode = "character")

# this sets up some dates for disply in fn_create_tex_file()
glob.env$vct_disp_dates <- c(today = format(Sys.Date(), "%B %d, %Y"), 
                             min = format(min(df_me_exports$Date), "%B %Y" ),
                             max = format(max(df_me_exports$Date), "%B %Y" ))


# invisible() suppresses output from lapply
invisible(
  # cycle through the list of product codes; create a report for each
  lapply(seq_along(lst_prod_codes), function(i) {
          # get the current product name; i is the ith element of lst_prod_codes
          str_prod_name <- names(lst_prod_codes)[[i]]
          # create a pdf report for the current product
          fn_wrapper_create_product_report(str_prod_name)
        } # end of: anonomymous function
      ) # end of: lapply
  ) # end of: invisible


# create the cover page
invisible(fn_create_pdf_cover_page(str_month_end))
str_file_suffix <- paste0(format(dte_end_date, "%Y"),"-", format(dte_end_date, "%m"))
# the following joins up the cover page with individual product pdfs into a single conscolidated document.
fn_create_pdf_compilation(glob.env$vct_pdf_names, str_file_suffix)
