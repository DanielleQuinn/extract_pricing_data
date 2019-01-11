This was done as a learning exercise in response to a [tweet from Natural Resources Canada](https://twitter.com/NRCan/status/1083108855285010439) that said they weren't able to generate a spreadsheet containing daily oil prices that are available on their website in response to another Twitter user asking for the data. I hope this helps at least a little bit. If not... trying to learn more about how web scraping works so this was a fun task!

This repository contains rough but working R code used to scrape data from Environment Canada website re: crude oil pricing and generate a single csv, and the generated csv file. It requires the libraries `dplyr` and `rvest`. I'm VERY new to this - feedback and tips are appreciated!

Limitations:  
- need to manually specify which unordered list elements to pull out of main page to generate vector of websites containing daily crude oil prices.  
- there are some cases in 2016 where a row spans multiple columns in the headers.. I can't figure out how to get rid of this, so the code will return a mesage letting you know which website couldn't be scraped and then skip it.  
- I've done some QAQC but definitely recommend it before using this data for anything - I can't make promises about quality issues that may have arisen from behind-the-scenes processes that I'm still learning about  :)  
