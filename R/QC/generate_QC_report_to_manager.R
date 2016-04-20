##  Purpose: To generate a QC report for Mark Hatcher's export intelligence reports repository
##           at P:\OTSP\export_intelligence
##  Author: Ilkka Havukkala
##  Date: 14 April 2016

##  Inputs: TRED import/export data of commodities
##  Outputs: decision to publish data

##  Dependencies: needs to run first script "analysis_code/checks_QC_prod.r"
##  Modified by: 
##  Peer reviewed by : 

## first round QC report
rmarkdown::render("R/QC/Quality_Control_export_intelligence2.Rmd") 

## Reply from Peter saved in the folder

## final response/action 
## rmarkdown::render("") 
