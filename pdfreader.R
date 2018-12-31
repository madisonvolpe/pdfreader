library(tidyverse)
library(rJava)
library(tabulizer)

#create base pdf 
pdf <-"/Users/michaelvolpe/Desktop/CaseloadsNM2017.pdf"

#for loop to extract all tables 
pdf_tables <- list(NA)

for(i in 1:86){
pdf_tables[[i]] <- extract_tables(pdf, i)
}

#remove empty lists from pdf_tables
pdf_tables <- pdf_tables[lapply(pdf_tables,length)>0]

# list entries of length 4 or greater  
greater4 <- pdf_tables[lapply(pdf_tables,length)>=4]
pdf_tables <- pdf_tables[lapply(pdf_tables,length)==1]

greater4_ed1 <- NA 
for(i in 1:length(greater4)){
    greater4_ed1[[i]] <- list(greater4[[i]][1]) 
}
greater4_ed2 <- NA
for(i in 1:length(greater4)){
  greater4_ed2[[i]] <- list(greater4[[i]][2])  
}
greater4_ed3 <- NA
for(i in 1:length(greater4)){
  greater4_ed3[[i]] <- list(greater4[[i]][3])  
}
greater4_ed4 <- NA
for(i in 1:length(greater4)){
  greater4_ed4[[i]] <- list(greater4[[i]][4])  
}

greater4 <- c(greater4_ed1, greater4_ed2, greater4_ed3, greater4_ed4)
rm(greater4_ed1,greater4_ed2,greater4_ed3,greater4_ed4)

#add individual lists to pdf_tables

pdf_tables <- c(pdf_tables, greater4)

#convert each entry in list to dataframe for easier manipulation 
pdf_tables <- lapply(pdf_tables, data.frame)

#write csvs for each element in list 
setwd("/Users/michaelvolpe/Desktop/nm")
names(pdf_tables) <- paste0("nmcourt",1:122,sep="")
for(i in names(pdf_tables)){
  write.csv(pdf_tables
            [[i]], paste0(i,".csv"))
}
