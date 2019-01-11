library(rvest)
library(dplyr)

# 18 - 27 for 2018
# 30 - 41 for 2017
# 44 - 55 for 2016

datalist = list()
count = 0
for(i in c(18:27, 30:41, 44:55))
{
  count = count + 1
  main1 <- html("https://www.nrcan.gc.ca/energy/oil-sands/18087#cop") %>%
    html_nodes("ul > li") %>%
    .[[i]] %>%
    as.character() %>%
    substr(start = 14, stop = nchar(.)) %>%
    substr(start = 1, stop = which(strsplit(., split = "")[[1]]==">")-2) %>%
    html() %>%
    html_nodes("table")
  
  # If there are no problems with rows spanning multiple columns, continue:
  if(length(grep("colspan", main1 %>% as.character())) == 0)
  {
    results <- main1 %>% html_table() %>%
      data.frame()
    names(results) <- gsub("([^A-Za-z0-9 ])+", ".", names(results))
    datalist[[count]] <- results    
  }
  
  # If there are problems with rows spanning multiple columns,
  # generate notification message and skip
  if(length(grep("colspan", main1 %>% as.character())) == 1)
  {
    print(paste("Could not get data from", html("https://www.nrcan.gc.ca/energy/oil-sands/18087#cop") %>%
                  html_nodes("ul > li") %>%
                  .[[i]] %>%
                  as.character() %>%
                  substr(start = 14, stop = nchar(.)) %>%
                  substr(start = 1, stop = which(strsplit(., split = "")[[1]]==">")-2),
          "because rows span multiple columns."))
  }
}

all_data = do.call(bind_rows, datalist) %>% dplyr::filter(!Date %in% c("Average", "-"))
write.csv(all_data, "all_data.csv")



