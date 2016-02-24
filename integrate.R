rm(list = ls())
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
load("inputs/Exports_By_Country_20150930.rda")

names(Exports_By_Country)

# set work directory - need to delete one of the following
PROJHOME <- getwd()

setwd(PROJHOME)
# read in data / concordances
source('R/fn_read_product_codes.R')
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

# hier sind testing stuff
lst_prod_codes <- lst_prod_codes[c("salmon", "honey")]

 
# before we start producing reports, delete all previous files (output/*)
fn_remove_files_from_output_dir()

# create vector with global scope to store PDF file names
glob.env <- new.env() 
glob.env$vct_pdf_names <- vector(mode = "character")

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
