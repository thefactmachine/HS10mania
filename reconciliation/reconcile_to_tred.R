rm(list = ls())
options(stringsAsFactors = FALSE)
library(data.table)
library(lubridate)
library(dplyr)

setwd("/Volumes/SILVER_FAT/export_intelligence/reconciliation")
# PURPOSE OF THIS SCRIPT ======================
# The purpose of this script is to check the TRED load process.
# The output from tred is stored as an RDA file. It is : "input_data/Exports_By_Country_20151130.rda"
# This rda file was created by a Tred query. Tred obtains this data from a number of csv files 
# produced by StatsNZ.  There are about 26 of these csv files.  They are located as follows:
# CSV source:  (as at 19.05.2016)
# P:\OTSP\data-infrastructure\Regular_Flexi_ETL\Flexible_ETL_Series\SNZ_Trade_Commodities\data_raw

# The csv files are imported and aggregated.  Then the result of this aggregation (ie dt_csv_all)
# is compared to the tred-created rda file.  There should be no differences.

# actual result.  There were found to be very very small differences in quantity values for all
# months in 2015.  There were There are 513  differences and the differences ranged from -1 to 1.
# it seems that these result from some rounding difference during the tred load / query process.
# in total these 513 differences sum to 87.  

# This is considered immaterial and therefore will not be investigated further.




vct_cols <- c("character", "character", "character", "character", 
              "character", "character", "character", "character", 
              "character", "character", "character", "character")

vct_col_names <- c("month", "hs10", "hs10_des", "units", 
                   "country", "val_fob", "qty_fob", "val_rexp",
                   "qty_rexp", "val_tot", "qty_tot", "status")

# ===================
dt_2000 <- data.table::fread("input_data/2000_Exports_HS10_by_Country.csv", colClasses = vct_cols, col.names = vct_col_names)
dt_2001 <- data.table::fread("input_data/2001_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2002 <- data.table::fread("input_data/2002_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2003 <- data.table::fread("input_data/2003_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2004 <- data.table::fread("input_data/2004_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2005 <- data.table::fread("input_data/2005_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2006 <- data.table::fread("input_data/2006_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2007 <- data.table::fread("input_data/2007_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2008 <- data.table::fread("input_data/2008_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2009 <- data.table::fread("input_data/2009_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2010 <- data.table::fread("input_data/2010_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2011 <- data.table::fread("input_data/2011_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2012 <- data.table::fread("input_data/2012_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2013 <- data.table::fread("input_data/2013_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2014 <- data.table::fread("input_data/2014_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)

# ==================
dt_2000$hs10_new <- ifelse(nchar(dt_2000$hs10) == 9, paste0("0", dt_2000$hs10), dt_2000$hs10)
dt_2001$hs10_new <- ifelse(nchar(dt_2001$hs10) == 9, paste0("0", dt_2001$hs10), dt_2001$hs10)
dt_2002$hs10_new <- ifelse(nchar(dt_2002$hs10) == 9, paste0("0", dt_2002$hs10), dt_2002$hs10)
dt_2003$hs10_new <- ifelse(nchar(dt_2003$hs10) == 9, paste0("0", dt_2003$hs10), dt_2003$hs10)
dt_2004$hs10_new <- ifelse(nchar(dt_2004$hs10) == 9, paste0("0", dt_2004$hs10), dt_2004$hs10)
dt_2005$hs10_new <- ifelse(nchar(dt_2005$hs10) == 9, paste0("0", dt_2005$hs10), dt_2005$hs10)
dt_2006$hs10_new <- ifelse(nchar(dt_2006$hs10) == 9, paste0("0", dt_2006$hs10), dt_2006$hs10)
dt_2007$hs10_new <- ifelse(nchar(dt_2007$hs10) == 9, paste0("0", dt_2007$hs10), dt_2007$hs10)
dt_2008$hs10_new <- ifelse(nchar(dt_2008$hs10) == 9, paste0("0", dt_2008$hs10), dt_2008$hs10)
dt_2009$hs10_new <- ifelse(nchar(dt_2009$hs10) == 9, paste0("0", dt_2009$hs10), dt_2009$hs10)
dt_2010$hs10_new <- ifelse(nchar(dt_2010$hs10) == 9, paste0("0", dt_2010$hs10), dt_2010$hs10)
dt_2011$hs10_new <- ifelse(nchar(dt_2011$hs10) == 9, paste0("0", dt_2011$hs10), dt_2011$hs10)
dt_2012$hs10_new <- ifelse(nchar(dt_2012$hs10) == 9, paste0("0", dt_2012$hs10), dt_2012$hs10)
dt_2013$hs10_new <- ifelse(nchar(dt_2013$hs10) == 9, paste0("0", dt_2013$hs10), dt_2013$hs10)
dt_2014$hs10_new <- ifelse(nchar(dt_2014$hs10) == 9, paste0("0", dt_2014$hs10), dt_2014$hs10)


# ==================
# ==================

dt_2015_jan <- data.table::fread("input_data/Jan_2015_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2015_feb <- data.table::fread("input_data/Feb_2015_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2015_mar <- data.table::fread("input_data/Mar_2015_Exports_HS10_by_Country.csv",  colClasses = vct_cols, col.names = vct_col_names)
dt_2015_apr <- data.table::fread("input_data/Apr_2015_Exports_HS10_by_Country.csv", colClasses = vct_cols, col.names = vct_col_names)
dt_2015_may <- data.table::fread("input_data/May_2015_Exports_HS10_by_Country.csv", colClasses = vct_cols, col.names = vct_col_names)
dt_2015_jun <- data.table::fread("input_data/Jun_2015_Exports_HS10_by_Country.csv", colClasses = vct_cols, col.names = vct_col_names)
dt_2015_jul <- data.table::fread("input_data/Jul_2015_Exports_HS10_by_Country.csv", colClasses = vct_cols, col.names = vct_col_names)
dt_2015_aug <- data.table::fread("input_data/Aug_2015_Exports_HS10_by_Country.csv", colClasses = vct_cols, col.names = vct_col_names)
dt_2015_sep <- data.table::fread("input_data/Sep_2015_Exports_HS10_by_Country.csv", colClasses = vct_cols, col.names = vct_col_names)
dt_2015_oct <- data.table::fread("input_data/Oct_2015_Exports_HS10_by_Country.csv", colClasses = vct_cols, col.names = vct_col_names)
dt_2015_nov <- data.table::fread("input_data/Nov_2015_Exports_HS10_by_Country.csv", colClasses = vct_cols, col.names = vct_col_names)

dt_2015_jan$hs10_new <- ifelse(nchar(dt_2015_jan$hs10) == 9, paste0("0", dt_2015_jan$hs10), dt_2015_jan$hs10)
dt_2015_feb$hs10_new <- ifelse(nchar(dt_2015_feb$hs10) == 9, paste0("0", dt_2015_feb$hs10), dt_2015_feb$hs10)
dt_2015_mar$hs10_new <- ifelse(nchar(dt_2015_mar$hs10) == 9, paste0("0", dt_2015_mar$hs10), dt_2015_mar$hs10)
dt_2015_apr$hs10_new <- ifelse(nchar(dt_2015_apr$hs10) == 9, paste0("0", dt_2015_apr$hs10), dt_2015_apr$hs10)
dt_2015_may$hs10_new <- ifelse(nchar(dt_2015_may$hs10) == 9, paste0("0", dt_2015_may$hs10), dt_2015_may$hs10)
dt_2015_jun$hs10_new <- ifelse(nchar(dt_2015_jun$hs10) == 9, paste0("0", dt_2015_jun$hs10), dt_2015_jun$hs10)
dt_2015_jul$hs10_new <- ifelse(nchar(dt_2015_jul$hs10) == 9, paste0("0", dt_2015_jul$hs10), dt_2015_jul$hs10)
dt_2015_aug$hs10_new <- ifelse(nchar(dt_2015_aug$hs10) == 9, paste0("0", dt_2015_aug$hs10), dt_2015_aug$hs10)
dt_2015_sep$hs10_new <- ifelse(nchar(dt_2015_sep$hs10) == 9, paste0("0", dt_2015_sep$hs10), dt_2015_sep$hs10)
dt_2015_oct$hs10_new <- ifelse(nchar(dt_2015_oct$hs10) == 9, paste0("0", dt_2015_oct$hs10), dt_2015_oct$hs10)
dt_2015_nov$hs10_new <- ifelse(nchar(dt_2015_nov$hs10) == 9, paste0("0", dt_2015_nov$hs10), dt_2015_nov$hs10)

dt_2015 <- data.table::rbindlist(list(dt_2015_jan, dt_2015_feb, dt_2015_mar, 
                                           dt_2015_apr, dt_2015_may, dt_2015_jun, 
                                           dt_2015_jul, dt_2015_aug, dt_2015_sep, dt_2015_oct, 
                                           dt_2015_nov))

dt_all <- data.table::rbindlist(list(dt_2000, dt_2001, dt_2002, dt_2003, 
                                     dt_2004, dt_2005, dt_2006, dt_2007, 
                                     dt_2008, dt_2009, dt_2010, dt_2011,
                                     dt_2012, dt_2013, dt_2014, dt_2015))

# drop some columns and change the order. We don't need "status"
# as all are "final"
dt_all <- dt_all[, .(month, hs10, hs10_new, country, units, val_tot, qty_tot)]

# remove everything except dt_all
 rm(list = ls()[!(ls() %in% c('dt_all', 'df_me_exports'))])


# remove commas and convert to numbers
dt_all$val_tot <- as.numeric(gsub(",", "", dt_all$val_tot))
dt_all$qty_tot <- as.numeric(gsub(",", "", dt_all$qty_tot))

# add a day (ie. 1st month and convert month to date)
dt_all$date <- as.Date(paste0(dt_all$month, "01"), "%Y%m%d")

# create a vector of dates
vct_dates <- dt_all$date

# add a month
month(vct_dates) <- month(vct_dates) + 1

# take off a day
day(vct_dates) <- day(vct_dates) -1

# now, stick our new date back into the data_table
dt_all$date <- vct_dates

rm(vct_dates)

dt_csv_all <- dt_all[, .(date, hs10_new, country, units, val_tot, qty_tot)]

# this loads in "Exports_By_Country"
load("input_data/Exports_By_Country_20151130.rda")
df_tred_all <- Exports_By_Country

# assign some PK and test their uniqueness
dt_csv_all <- dt_csv_all %>% mutate(key = paste0(date, hs10_new, country))
length(unique(dt_csv_all$key)) == nrow(dt_csv_all)

df_tred_all <- df_tred_all %>% mutate(key = paste0(Date, Harmonised_System_Code,  Country))
length(unique(df_tred_all$key)) == nrow(df_tred_all)

# the tred load scripts seem to implement a business rule that if
# the value of units is blank then: 1) its value is set to "UNKNOWN" AND
# 2) the associated quantity value is set to NA.  There are 19 instances in
# the original data where the units value is blank but the quantity value is 
# set to valid value.  In the following this difference is resolved.

# 1) set the units value to UNKNOWN
dt_csv_all$units <- ifelse(dt_csv_all$units == "", "UNKNOWN",  dt_csv_all$units)

# 2) now make sure that the quantity is NA iff the units value is known
dt_csv_all$qty_tot <- ifelse(dt_csv_all$units == "UNKNOWN", NA, dt_csv_all$qty_tot)
rm(Exports_By_Country); rm(dt_all)
# ================================================
# SPECIFIC RECONCILATION CHECKS




# 1) QUANTITY DIFFERENCES
# join both tables
df_both <- inner_join(df_tred_all, dt_csv_all, by = c("key" = "key"))

# add quantity difference variable
df_both <- df_both %>% mutate(q_diff = Total_Exports_Qty - qty_tot)

# create a data frame of quantity breaks. There are 513 rows differences range from -1 to 1.
df_breaks_quantity <- df_both %>% filter(q_diff != 0) %>% select(date, hs10_new, country, units, Total_Exports_Qty, qty_tot, q_diff)

# sum(df_breaks_quantity$q_diff) is 87 so total differences are not material
# expect the following to be zero
sum(dt_csv_all$qty_tot, na.rm = TRUE) - sum(df_tred_all$Total_Exports_Qty, na.rm = TRUE) + sum(df_breaks_quantity$q_diff)

# =========================
# 2) VALUE CHECK - check that TRED and CSV have the same value
sum(df_tred_all$Total_Export_NZD_fob, na.rm = TRUE) == sum(dt_csv_all$val_tot, na.rm = TRUE)

# =========================
# 3) Transactions per date - checks that number of tx are the same for each time period
df_tred_date_tx <- df_tred_all %>% group_by(Date) %>% summarise(tred_tx = n())
df_csv_date_tx <- dt_csv_all %>% group_by(date) %>% summarise(csv_tx = n())
df_date_tx_diff <- inner_join(df_tred_date_tx, df_csv_date_tx, by = c("Date" = "date")) %>% mutate(diff = tred_tx -  csv_tx)
# expecting the sum of differences to be zero
sum(df_date_tx_diff$diff)

# =========================
# 4) Transactions per country
df_tred_country_tx <- df_tred_all %>% group_by(country = as.character(Country)) %>% summarise(tred_tx = n())
df_csv_country_tx <- dt_csv_all %>% group_by(country) %>% summarise(csv_tx = n())
df_country_tx_diff <- inner_join(df_tred_country_tx, df_csv_country_tx, by = c("country" = "country")) %>% mutate(diff = tred_tx -  csv_tx)
# expecting the sum of differences to be zero
sum(df_country_tx_diff$diff)

# =========================
# 5) Transactions per HS10 Code
df_tred_hs10_tx <- df_tred_all %>% group_by(hs10 = as.character(Harmonised_System_Code)) %>% summarise(tred_tx = n())
df_csv_hs10_tx <- dt_csv_all %>% group_by(hs10 = hs10_new) %>% summarise(csv_tx = n())
df_hs10_tx_diff <- inner_join(df_tred_hs10_tx, df_csv_hs10_tx, by = c("hs10" = "hs10")) %>% mutate(diff = tred_tx -  csv_tx)
# expecting the sum of differences to be zero
sum(df_hs10_tx_diff$diff)
