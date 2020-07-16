
      
      
      
      data_url = paste0("https://d396qusza40orc.cloudfront.net/",
                        "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
      download.file(data_url, "data.zip")
      
      
      log_entry_url <- paste0("Data was downloaded from the url: ", data_url)
      log_entry_date <- paste0("Data was downloaded on: " , date())
      
      log_con <- file("log.txt")
      writeLines(c(log_entry_url, log_entry_date), log_con)
      close(log_con)
      
      
      
      unzip("data.zip")
      
      

