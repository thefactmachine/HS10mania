   # Status: draft
   
   # Purpose: QC Mark Hatcher's export intelligence repository
   
   # Output: data is used for generating html report by next script 
   #  "R/QC/generat_QC_report_to_manager.R"
   
   # stage 1: check which scripts are peer_reviewed
   # stage 2: check basics of output pdf pages
   # stage 3: Compare data to Stat NZ base truth and also UN ComTrade website data
   #          ate.g. http://comtrade.un.org/db/mr/rfCommoditiesList.aspx?px=H4&cc=0302142 
   # stage 4: prepare list of png files to show, if any

   # Author: 13 April 2016 Ilkka Havukkala
   # Peer review: 
   
   
   # library(ggrepel)
   
   QC_rundate <- date()
   
   ####
   # stage 1: check which scripts are peer_reviewed
   ####
   
   ## Generate list of scripts needing/having peer_review

   allfiles  <- list.files(path=".", recursive=T, 
                           full.names=T) %>% as.data.frame()  
   
   colnames(allfiles) <- "myfile"
   
   # remove .Rproj link and rda, rnw files
   allfiles <- allfiles %>% 
     filter(!grepl('\\.Rproj', myfile) ) %>%
     filter(!grepl('\\.rda', myfile) ) %>%
     filter(!grepl('\\.rnw', myfile) )
     
   
   
   myfiles <- grep("\\.r", value = TRUE, ignore.case = TRUE, 
                   as.character(allfiles$myfile ) )  
   
   
   ##  Make list of peer_review comments of all scripts
   
   # initialize list
   result <- list()
   
   for(i in 1:length(myfiles) ) {
      
      
      # read all lines
      x <- scan(myfiles[i], what = "character", sep = "\n" ) 
      
      # find hits
      hits <- grep("Peer review", ignore.case = TRUE, value = TRUE, x) 
      
      # add script name name
      result[[length(result) + 1]] <- myfiles[i]
      
      # if no hits, add comment of missing peer_review line
      if(length(hits) == 0) { 
         result[[length(result) + 1]] <- "     Missing Peer_review line to add"
      }
      
      # if hits, accumulate Peer_review line(s) to result, 
      if(length(hits) > 0) { 
         for(j in 1:length(hits) ) {
            result[[length(result) + 1]] <- paste0("     ", hits[j] )
         }
      }
   }
   
   final <- result %>% sapply(paste0, collapse="")
   
   # dataframe final is put into html report for QC
   
 
   
   
   #####
   # stage 4: Prepare a list of output .png files to show in QC report, append to .Rmd file
   #####
   
   
   mypics   <- grep("\\.png", value = TRUE, ignore.case = TRUE, 
                    as.character(allfiles$myfile ) )  
   
   mylinks = paste0("****************************************************<br>",
                    "No PNG plots in this repository currently  " )
   
   if(length(mypics) > 0 ) {
   mylinks <- paste0("****************************************************<br>", 
                     mypics, "  ![](.", mypics, ")  ")
   }
   
   
   #####
   # stage 5: Prepare .Rmd file with .png file link list at bottom
   #####
   
   # make final copy of .Rmd file, to which is appended the list of image links
   
   file.copy("R/QC/Quality_Control_export_intelligence.Rmd", 
             "R/QC/Quality_Control_export_intelligence2.Rmd", overwrite = TRUE )
   
   
   write(mylinks, file = "R/QC/Quality_Control_export_intelligence2.Rmd", append = TRUE, sep = "\n")
   
  
   
   
   