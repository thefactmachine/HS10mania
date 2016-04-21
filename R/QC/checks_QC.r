   # Status: draft
   
   # Purpose: QC Mark Hatcher's export intelligence repository
   
   # Output: data is used for generating html report by next script 
   #  "R/QC/generat_QC_report_to_manager.R"
   
   # stage 1: check which scripts are peer_reviewed
   # stage 2: check basics of output pdf pages
   # stage 3: Compare data to Stat NZ base truth and also UN ComTrade website data
   #          ate.g. http://comtrade.un.org/db/mr/rfCommoditiesList.aspx?px=H4&cc=0302142   

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
   
   # remove .Rproj link adn rda files
   allfiles <- allfiles %>% 
     filter(!grepl('\\.Rproj', myfile) ) %>%
     filter(!grepl('\\.rda', myfile) ) 
     
   
   
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
   # stage 2: check basics of TRED dataframes
   #####
#    
#    
#    ## check data in TRED PROD
#    # Ranks data checks
#    
#    myseriesR <- ImportTS2(TRED_Prod , "WEF GCI Ranks")
#    head(as.data.frame(myseriesR) )
#    unique(myseriesR$CV4)
#    str(myseriesR)
#    # all basics seems ok.
#    
#    # sample plots
#    
#    mytitle <- "12_01 Capacity for innovation_ 1_7 _best_"
#    
#    p1 <- myseriesR %>% 
#       filter(CV4 ==  "12_01 Capacity for innovation_ 1_7 _best_") %>%
#       filter(CV1 %in% c("New Zealand", "Finland",
#                         "Israel", "Ireland") ) %>%
#       group_by(CV1) %>% 
#       ggplot(aes(x = TimePeriod, y = Value, 
#                  group = CV1, colour = CV1) ) +
#       geom_point(size = 1) +
#       geom_line(size = 0.25) +
#       facet_wrap(~CV1) +  # , scales = "free")  +
#       labs(title = paste(mytitle, "Ranks" ) )
#    
#    
#    
#    # Values data checks
#    
#    myseriesV <- ImportTS2(TRED_Prod , "WEF GCI Values")
#    head(as.data.frame(myseriesV) )
#    unique(myseriesV$CV4)
#    str(myseriesV)
#    # all basics seems ok.
#    
#    
#    p2 <- myseriesV %>% 
#       filter(CV4 ==  "12_01 Capacity for innovation_ 1_7 _best_") %>%
#       filter(CV1 %in% c("New Zealand", "Finland",
#                         "Israel", "Ireland") ) %>%
#       group_by(CV1) %>% 
#       ggplot(aes(x = TimePeriod, y = Value, 
#                  group = CV1, colour = CV1) ) +
#       geom_point(size = 1) +
#       geom_line(size = 0.25) +
#       facet_wrap(~CV1) +  # , scales = "free")  +
#       labs(title = paste(mytitle, "Values" ) )
#    
#    
#    mytitle <- "Capacity vs Innovation,2015"
#    
#    p3 <- myseriesV %>% 
#       filter(CV4 %in% c("12_01 Capacity for innovation_ 1_7 _best_",
#                         "12th pillar_ Innovation") ) %>% 
#       filter(TimePeriod == "2015-12-31") %>%
#       spread(CV4, Value) %>% 
#       
#       ggplot(aes(x = `12_01 Capacity for innovation_ 1_7 _best_`, 
#                  y = `12th pillar_ Innovation` ) ) +
#       geom_point(size = 2) +
#       geom_text_repel(aes(label=CV1) )  +
#       labs(title = paste(mytitle, "Values" ) )
#    
#    # as.data.frame %>% tail
#    
#    #----------plot sizes------------------------------
#    # half horizontal (shape 1)
#    w1 <- 138/25.4   # width is set and cannot be changed.
#    w2 <- 100/25.4   # narrower width so designers can adjust the text
#    h1 <- 80/25.4    # height can be adjusted to work for the plot
# 
#    #####
#    # stage 3: plot example plots
#    #####
#    
#    
#    png("analysis_code/CG_capacity_ranks.png", w1*600, h1*600, res= 600, bg = "transparent" )
#    print(p1)
#    dev.off() 
#    
#    png("analysis_code/CG_capacity_values.png", w1*600, h1*600, res= 600, bg = "transparent" )
#    print(p2)
#    dev.off() 
#    
#    png("analysis_code/CG_capacity_vs_innovation.png", 3*w1*600, 3*h1*600, res= 600, bg = "transparent" )
#    print(p3)
#    dev.off() 
#    
   
   ## next go to http://theviz.wd.govt.nz/tred_interactive/
   ## and replot similar plot via shiny and save as shinyplot.png in same place.
   
   # Status: draft
   
   # Purpose: QC Mark Hatcher's export intelligence repository
   
   # Output: data is used for generating html report by next script 
   #  "R/QC/generat_QC_report_to_manager.R"
   
   # stage 1: check which scripts are peer_reviewed
   # stage 2: check basics of output pdf pages
   # stage 3: Compare data to Stat NZ base truth and also UN ComTrade website data
   #          ate.g. http://comtrade.un.org/db/mr/rfCommoditiesList.aspx?px=H4&cc=0302142   

  # stage 4: Prepare a list of output .png files
  # stage 5: Prepare .Rmd file with .png file link list at bottom


   # Author: 13 April 2016 Ilkka Havukkala
   # Peer review: 
   
   
   # library(ggrepel)
   
   QC_rundate <- date()
   
   ####
   # stage 1: check which scripts are peer_reviewed
   ####
   
   # before running QC, remove all current outputs, 
   #  to avoid superfluous .rnw file hits made for pdf outputs
   # removes all files from /output/*
   fn_remove_files_from_output_dir()   
   
   ## Generate list of scripts needing/having peer_review

   allfiles  <- list.files(path=".", recursive=T, 
                           full.names=T) %>% as.data.frame()  
   
   colnames(allfiles) <- "myfile"
   
   # remove .Rproj link adn rda files
   allfiles <- allfiles %>% 
     filter(!grepl('\\.Rproj', myfile, ignore.case = TRUE) ) %>%
     filter(!grepl('\\.rda', myfile, ignore.case = TRUE) ) 
     
   
   
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
   
  
   
   
#    
#    
#    ## check data in TRED PROD
#    # Ranks data checks
#    
#    myseriesR <- ImportTS2(TRED_Prod , "WEF GCI Ranks")
#    head(as.data.frame(myseriesR) )
#    unique(myseriesR$CV4)
#    str(myseriesR)
#    # all basics seems ok.
#    
#    # sample plots
#    
#    mytitle <- "12_01 Capacity for innovation_ 1_7 _best_"
#    
#    p1 <- myseriesR %>% 
#       filter(CV4 ==  "12_01 Capacity for innovation_ 1_7 _best_") %>%
#       filter(CV1 %in% c("New Zealand", "Finland",
#                         "Israel", "Ireland") ) %>%
#       group_by(CV1) %>% 
#       ggplot(aes(x = TimePeriod, y = Value, 
#                  group = CV1, colour = CV1) ) +
#       geom_point(size = 1) +
#       geom_line(size = 0.25) +
#       facet_wrap(~CV1) +  # , scales = "free")  +
#       labs(title = paste(mytitle, "Ranks" ) )
#    
#    
#    
#    # Values data checks
#    
#    myseriesV <- ImportTS2(TRED_Prod , "WEF GCI Values")
#    head(as.data.frame(myseriesV) )
#    unique(myseriesV$CV4)
#    str(myseriesV)
#    # all basics seems ok.
#    
#    
#    p2 <- myseriesV %>% 
#       filter(CV4 ==  "12_01 Capacity for innovation_ 1_7 _best_") %>%
#       filter(CV1 %in% c("New Zealand", "Finland",
#                         "Israel", "Ireland") ) %>%
#       group_by(CV1) %>% 
#       ggplot(aes(x = TimePeriod, y = Value, 
#                  group = CV1, colour = CV1) ) +
#       geom_point(size = 1) +
#       geom_line(size = 0.25) +
#       facet_wrap(~CV1) +  # , scales = "free")  +
#       labs(title = paste(mytitle, "Values" ) )
#    
#    
#    mytitle <- "Capacity vs Innovation,2015"
#    
#    p3 <- myseriesV %>% 
#       filter(CV4 %in% c("12_01 Capacity for innovation_ 1_7 _best_",
#                         "12th pillar_ Innovation") ) %>% 
#       filter(TimePeriod == "2015-12-31") %>%
#       spread(CV4, Value) %>% 
#       
#       ggplot(aes(x = `12_01 Capacity for innovation_ 1_7 _best_`, 
#                  y = `12th pillar_ Innovation` ) ) +
#       geom_point(size = 2) +
#       geom_text_repel(aes(label=CV1) )  +
#       labs(title = paste(mytitle, "Values" ) )
#    
#    # as.data.frame %>% tail
#    
#    #----------plot sizes------------------------------
#    # half horizontal (shape 1)
#    w1 <- 138/25.4   # width is set and cannot be changed.
#    w2 <- 100/25.4   # narrower width so designers can adjust the text
#    h1 <- 80/25.4    # height can be adjusted to work for the plot
# 
#    #####
#    # stage 3: plot example plots
#    #####
#    
#    
#    png("analysis_code/CG_capacity_ranks.png", w1*600, h1*600, res= 600, bg = "transparent" )
#    print(p1)
#    dev.off() 
#    
#    png("analysis_code/CG_capacity_values.png", w1*600, h1*600, res= 600, bg = "transparent" )
#    print(p2)
#    dev.off() 
#    
#    png("analysis_code/CG_capacity_vs_innovation.png", 3*w1*600, 3*h1*600, res= 600, bg = "transparent" )
#    print(p3)
#    dev.off() 
#    
   
   ## next go to http://theviz.wd.govt.nz/tred_interactive/
   ## and replot similar plot via shiny and save as shinyplot.png in same place.
   

   