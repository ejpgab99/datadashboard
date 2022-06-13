Author: "E.J. Gabriel"
Title: "Homeless Dashboard Project"
Date: "2/16/22"

#Code is for importing the data for the dashboard I will be making later on. 

#test commit

library(readxl)
library(tidyverse)

setwd("~/Desktop/BIS 412/test")

Sheet20 <- read_excel("2007-2020-PIT-Estimates-by-CoC.xlsx")

excel_sheets("2007-2020-PIT-Estimates-by-CoC.xlsx")

Sheet19 <- read_excel("2007-2020-PIT-Estimates-by-CoC.xlsx", sheet = "2019")

excel_sheets("2007-2020-PIT-Estimates-by-CoC.xlsx")

rbind(Sheet19, Sheet20)

Sheet19 <- pivot_longer(Sheet19, !c("CoC Number", "CoC Name"))

# Figure out how to remove the last two sheets 
#Maybe can be done by just finding the numbers even though they are taken 
#as characters remove sheets titled "CoC Mergers" and "Revisions" 

selected_sheets <- excel_sheets("2007-2020-PIT-Estimates-by-CoC.xlsx") 

selected_sheets <- selected_sheets[!selected_sheets %in% c("CoC Mergers", "Revisions", "2020")]



dataextract <- function(file) {
  dat <- data.frame("CoC Number" = character(),
                   "CoC Name" = character(),
                   name = character(),
                   value = double())
  
  longdat <- data.frame("CoC Number" = character(), "CoC Name" = character(), name = character(),
                        value = double())
  for(sheet in selected_sheets) {
    dat <- read_excel(file, sheet = sheet) %>% ifelse(colnames() %in% c("CoC Category") ,select(!"CoC Category")) 

   longdat <- pivot_longer(dat, !c("CoC Number", "CoC Name"))
   data <- rbind(data, longdat)
   data
  }
}

all_sheets <- dataextract("2007-2020-PIT-Estimates-by-CoC.xlsx")  



