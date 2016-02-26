# Written by:     Mark Hatcher (Sector Trends 26.02.2016)
# objective:      Download the lastest Merchandise Trade data from TRED and store as an RDA file
#                 The resultant RDA file is about 50 mb -- A large dataset.  SO this program can take
#                 about 30 minutes to run.  So make yourself a coffee and relax while R does all the work!

rm(list = ls())
library(RODBC)
library(reshape2)
library(mbieDBmisc)


TRED <- odbcConnect("TRED_Prod")

# this takes about 24 minutes to run
New_Zealand_Exports <- ImportTS2(TRED, "New Zealand Overseas Merchandise Trade: Exports by Commodity and Country")



Exports_By_Country <- dcast(New_Zealand_Exports,
                             TimePeriod + CV1 + CV2 + CV4 ~ CV3,
                             value.var = c("Value"))


names(Exports_By_Country)[1:4] = c("Date", "Country", "Harmonised_System_Code", "Unit_Qty")

# Calculate totals
Exports_By_Country$Total_Export_NZD_fob <- Exports_By_Country$Exports_NZD_fob + 
                                             Exports_By_Country$Re_exports_NZD_fob

Exports_By_Country$Total_Exports_Qty <- Exports_By_Country$Exports_Qty + 
                                          Exports_By_Country$Re_exports_Qty


# find the most recent date
dte_max_date <- max(Exports_By_Country$Date)
str_max_date <- format(dte_max_date, "%Y%m%d")
str_file_name <- paste0("Exports_By_Country_", str_max_date, ".rda")
str_file_path <- file.path("inputs",str_file_name)

# this takes about 5 minutes to save to the thumb drive
# example of save location: /inputs/Exports_By_Country_20150930.rda
save(Exports_By_Country, file = str_file_path)
