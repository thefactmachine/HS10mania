
# PURPOSE OF THIS SCRIPT ======================
# The purpose of this script is to check the TRED load process using Salmon product as a test case

# Peer Review: Ilkka Havukkala 26 April 2016 ok, revised to grab data files from P drive



rm(list = ls())
options(stringsAsFactors = FALSE)
library(data.table)
library(lubridate)
library(dplyr)

# for local use
# setwd("/Volumes/SILVER_FAT/export_intelligence/reconciliation")




#========= Step 1======== LOAD in Data =========
# this loads in "Exports_By_Country"
load("P:/OTSP/export_intelligence/inputs/Exports_By_Country_20151130.rda")

# load in product codes
df_codes <- read.csv("P:/OTSP/export_intelligence/inputs/concordances/product_codes.csv", 
                 colClasses = c("character", "character"))


vct_cols_to_drop <- c("Exports_NZD_fob", "Exports_Qty", "Re_exports_NZD_fob", "Re_exports_Qty")
df_me <- Exports_By_Country[, !names(Exports_By_Country) %in% vct_cols_to_drop]



names(df_me) <- c("date", "country", "HS10", "units", "value", "quantity")
df_me$country <- as.character(df_me$country)

# clean up
rm(Exports_By_Country); rm(vct_cols_to_drop)

#========= Step 2 ======== Filter for current product =========
vct_curr_product_codes <- df_codes %>% filter(name == "salmon") %>% .$code
df_me_c_prod <- df_me %>% filter(HS10 %in% vct_curr_product_codes)

# clean up
rm(df_me); rm(vct_curr_product_codes)

#========= Step 3 ========  get date vectors =========
# these will be used a few different times

# previous 12 months
vct_year_n <- df_me_c_prod %>% 
              filter(date <= as.Date("20151130", "%Y%m%d")) %>%
              filter(date > as.Date("20141130", "%Y%m%d")) %>%
              select(date) %>% distinct() %>% .$date

# 12 months --- 3 years ago
vct_year_n_3 <- df_me_c_prod %>% 
  filter(date <= as.Date("20121130", "%Y%m%d")) %>%
  filter(date > as.Date("20111130", "%Y%m%d")) %>%
  select(date) %>% distinct() %>% .$date

#========= Step 4 ========  top 6 countries =========
# calculated the top 6 countries by value for most recent 12 months
vct_top_6_country <- df_me_c_prod %>% filter(date %in% vct_year_n) %>% 
                      group_by(country) %>% 
                      summarise(total = sum(value)) %>% 
                      arrange(desc(total)) %>% slice(1:6) %>% .$country

vct_other_country <- df_me_c_prod %>% filter(!country %in% vct_top_6_country) %>% 
                      select(country) %>% distinct() %>% .$country

#========= Step 5 ========  Calculate Quantity (N) =========

#==5a) top 6 countries

vct_quant_6 <-      df_me_c_prod  %>% filter(date %in% vct_year_n) %>% 
                    filter(country %in% vct_top_6_country) %>%
                    group_by(country) %>% summarise(tot_quantity = sum(quantity)) %>% 
                    slice(match(vct_top_6_country, country)) %>% .$tot_quantity

vct_quant_other <-  df_me_c_prod  %>% filter(date %in% vct_year_n) %>% 
                    filter(!country %in% vct_top_6_country) %>%
                    summarise(tot_quantity = sum(quantity)) %>% .$tot_quantity

vct_quant_total <-  df_me_c_prod  %>% filter(date %in% vct_year_n) %>% 
                    summarise(tot_quantity = sum(quantity)) %>% .$tot_quantity

# following should be zero or a very very very small number
sum(vct_quant_6) + vct_quant_other - vct_quant_total

# club the vectors together
vct_quant_all <- c(vct_quant_6, vct_quant_other, vct_quant_total)


#========= Step 6 ========  Calculate Value (N) =========

vct_value_6 <-      df_me_c_prod  %>% filter(date %in% vct_year_n) %>% 
                    filter(country %in% vct_top_6_country) %>%
                    group_by(country) %>% summarise(tot_value = sum(value)) %>% 
                    slice(match(vct_top_6_country, country)) %>% .$tot_value

vct_value_other <-  df_me_c_prod  %>% filter(date %in% vct_year_n) %>% 
                    filter(!country %in% vct_top_6_country) %>%
                    summarise(tot_value = sum(value)) %>% .$tot_value


vct_value_total <-  df_me_c_prod  %>% filter(date %in% vct_year_n) %>% 
                    summarise(tot_value = sum(value)) %>% .$tot_value

# following should be zero or a very very very small number
sum(vct_value_6) + vct_value_other - vct_value_total

# club the vectors together
vct_value_all <- c(vct_value_6, vct_value_other, vct_value_total)

# =========================================================
# =========================================================

#========= Step 7 ========  Calculate Quantity (N-3) =========

#==7a) top 6 countries

vct_quant_6_n3 <-       df_me_c_prod  %>% filter(date %in% vct_year_n_3) %>% 
                        filter(country %in% vct_top_6_country) %>%
                        group_by(country) %>% summarise(tot_quantity = sum(quantity)) %>% 
                        slice(match(vct_top_6_country, country)) %>% .$tot_quantity

vct_quant_other_n3 <-   df_me_c_prod  %>% filter(date %in% vct_year_n_3) %>% 
                        filter(!country %in% vct_top_6_country) %>%
                        summarise(tot_quantity = sum(quantity)) %>% .$tot_quantity

vct_quant_total_n3 <-   df_me_c_prod  %>% filter(date %in% vct_year_n_3) %>% 
                        summarise(tot_quantity = sum(quantity)) %>% .$tot_quantity



# following should be zero or a very very very small number
sum(vct_quant_6_n3) + vct_quant_other_n3 - vct_quant_total_n3

# club the vectors together
vct_quant_all_n3 <- c(vct_quant_6_n3, vct_quant_other_n3, vct_quant_total_n3)

#========= Step 8 ========  Calculate Value (N-3) =========
vct_value_6_n3 <-     df_me_c_prod  %>% filter(date %in% vct_year_n_3) %>% 
                      filter(country %in% vct_top_6_country) %>%
                      group_by(country) %>% summarise(tot_value = sum(value)) %>% 
                      slice(match(vct_top_6_country, country)) %>% .$tot_value

vct_value_other_n3 <-   df_me_c_prod  %>% filter(date %in% vct_year_n_3) %>% 
                        filter(!country %in% vct_top_6_country) %>%
                        summarise(tot_value = sum(value)) %>% .$tot_value


vct_value_total_n3 <- df_me_c_prod  %>% filter(date %in% vct_year_n_3) %>% 
                      summarise(tot_value = sum(value)) %>% .$tot_value

# following should be zero or a very very very small number
sum(vct_value_6_n3) + vct_value_other_n3 - vct_value_total_n3

# club the vectors together
vct_value_all_n3 <- c(vct_value_6_n3, vct_value_other_n3, vct_value_total_n3) 

# =========================================================
# =========================================================
# =========================================================
# =========================================================

# clean up, release memory
gc()
rm(list= ls()[!(ls() %in% c('vct_top_6_country','vct_quant_all', 
                    'vct_value_all', 'vct_quant_all_n3', 'vct_value_all_n3'))])
gc()

# define some helpful functions
fn_compound3 <- function(previous, current) {((current / previous) ^ (1/3))-1}

# calculate some  dervived values for display in a data frame
vct_price <- (vct_value_all / vct_quant_all)
vct_price_n3 <- (vct_value_all_n3 / vct_quant_all_n3)
vct_growth_quant <- fn_compound3(vct_quant_all_n3, vct_quant_all) 
vct_growth_value <- fn_compound3(vct_value_all_n3, vct_value_all) 
vct_growth_price <- fn_compound3(vct_price_n3, vct_price) 
vct_elasticity <- vct_growth_quant / vct_growth_price

# contruct data.frame 
df_complete <- data.frame(country = c(vct_top_6_country, "Other", "Total"), 
                          yearly_quant = vct_quant_all,
                          yearly_value = vct_value_all,
                          yearly_price = vct_price,
                          CAGR_qty = vct_growth_quant,
                          CAGR_val = vct_growth_value,
                          CAGR_price = vct_growth_price,
                          elasticity = vct_elasticity)

# format the data frame


df_complete$yearly_quant <- round(df_complete$yearly_quant / 1e3, 0) %>% format(., big.mark = ",")
df_complete$yearly_value <- round(df_complete$yearly_value / 1e6, 2) %>% format(., big.mark = ",", nsmall = 2) %>% paste0("$ ", .)
df_complete$yearly_price <- round(df_complete$yearly_price, 2) %>% format(., big.mark = ",", nsmall = 2) %>% paste0("$ ", .)

fn_fmt_n <- function(flt_number) {round(flt_number * 100, 2) %>% format(., big.mark = ",", nsmall = 2) %>% paste0(., "%")}

df_complete$CAGR_qty <- fn_fmt_n(df_complete$CAGR_qty)
df_complete$CAGR_val <- fn_fmt_n(df_complete$CAGR_val)
df_complete$CAGR_price <- fn_fmt_n(df_complete$CAGR_price)

df_complete$elasticity <- round(df_complete$elasticity, 2) %>% format(., big.mark = ",", nsmall = 2) 

df_complete

# these numbers should be the same as in the salmon pdf top table produced by integrate.R.
# checked manually, ok 26 April 2016 Ilkka Havukkala

# setwd("/Volumes/SILVER_FAT/export_intelligence")
























