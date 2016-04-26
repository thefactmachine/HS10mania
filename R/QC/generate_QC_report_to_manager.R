##  Purpose: To generate a QC report for Mark Hatcher's export intelligence reports repository
##           at P:\OTSP\export_intelligence
##  Author: Ilkka Havukkala
##  Date: 14 April 2016, 22 April 2016 added launch of html in Chrome

##  Inputs: TRED import/export data of commodities
##  Outputs: decision to publish data

##  Dependencies: needs to run first script "analysis_code/checks_QC_prod.r"
##  Modified by: 
##  Peer reviewed by : 

## first round QC report

proposalName <- 'Quality_Control_export_intelligence2'

proposalPath <- paste0("R/QC/",
                       proposalName,
                       '.Rmd')

### compile to a html file
rmarkdown::render(proposalPath)

## Reply from Peter saved in the folder

## open html using chrome
proposalHtml <- paste0(getwd(),
                       "/",
                       gsub(".Rmd", ".html", proposalPath)
 )

shell.exec( proposalHtml )


## final response/action 
## rmarkdown::render("") 

