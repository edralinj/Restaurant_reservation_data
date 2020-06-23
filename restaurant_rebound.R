library(rvest)
library(readr)
library(lubridate)

# scraping restaurant covid data by country from open table

url <- "https://www.opentable.com/state-of-industry"
  
raw_tables <- read_html(url) %>% 
  html_nodes("table")

#creating data.frame for reservations data (tidying in PBIX)

reservation_data <- html_table(raw_tables[1], fill = TRUE) %>%
       as.data.frame() 
reservation_data <- as.data.frame(t(reservation_data))
      names(reservation_data) <- reservation_data[1,]
reservation_data <- reservation_data[-1,]
reservation_data <- cbind(Date = rownames(reservation_data), reservation_data)

#creating data.frame for restaurants open for reservations (tidying in PBIX)

restaurants_open <- html_table(raw_tables[2], fill = TRUE) %>%
  as.data.frame() 
restaurants_open <- as.data.frame(t(restaurants_open))
names(restaurants_open) <- restaurants_open[1,]
restaurants_open <- restaurants_open[-1,]
restaurants_open <- cbind(Date = rownames(restaurants_open), restaurants_open)

#trying to access data by state
test <- read_html(url) %>% select.list() %>%
html_table()

