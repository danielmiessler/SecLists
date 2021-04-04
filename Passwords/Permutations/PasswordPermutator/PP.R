#!/usr/bin/env Rscript
library('data.table')
library('stringi')
library('Hmisc')
library('english')
library('stringr')

rawp <- readLines('./list.txt')
spec_chars <- c('@', '!', '$', '-', '.', ':', '_', '%', '?')
pplist <- c(rawp)

numbers_only <- function(x) !grepl("\\D", x)

num_to_stri <- function(numl) {
  numlist <- c()
  numchar <- unlist(strsplit(numl, NULL))
  for(numi in 1:length(numchar)) {
    if(numchar[numi] == "0") {
      numchar[numi] = "zero"
    }
    else if(numchar[numi] == "1") {
      numchar[numi] = "one"
    }
    else if(numchar[numi] == "2") {
      numchar[numi] = "two"
    }
    else if(numchar[numi] == "3") {
      numchar[numi] = "three"
    }
    else if(numchar[numi] == "4") {
      numchar[numi] = "four"
    }
    else if(numchar[numi] == "5") {
      numchar[numi] = "five"
    }
    else if(numchar[numi] == "6") {
      numchar[numi] = "six"
    }
    else if(numchar[numi] == "7") {
      numchar[numi] = "seven"
    }
    else if(numchar[numi] == "8") {
      numchar[numi] = "eight"
    }
    else if(numchar[numi] == "9") {
      numchar[numi] = "nine"
    }
  }
  numlist <- c(numlist, paste(numchar, sep="", collapse=""))
  numlist <- c(numlist, toupper(paste(numchar, sep="", collapse="")))
  numchar <- unlist(strsplit(numl, NULL))
  for(numi in 1:length(numchar)) {
    if(numchar[numi] == "0") {
      numchar[numi] = "Zero"
    }
    else if(numchar[numi] == "1") {
      numchar[numi] = "One"
    }
    else if(numchar[numi] == "2") {
      numchar[numi] = "Two"
    }
    else if(numchar[numi] == "3") {
      numchar[numi] = "Three"
    }
    else if(numchar[numi] == "4") {
      numchar[numi] = "Four"
    }
    else if(numchar[numi] == "5") {
      numchar[numi] = "Five"
    }
    else if(numchar[numi] == "6") {
      numchar[numi] = "Six"
    }
    else if(numchar[numi] == "7") {
      numchar[numi] = "Seven"
    }
    else if(numchar[numi] == "8") {
      numchar[numi] = "Eight"
    }
    else if(numchar[numi] == "9") {
      numchar[numi] = "Nine"
    }
  }
  numlist <- c(numlist, paste(numchar, sep="", collapse=""))
  if (numbers_only(numl)) {
    numl <- as.integer(numl)
    to_cap_str <- strsplit(str_replace_all(str_replace_all(toString(as.english(numl)), "[-]", ' '), "[,]", ''), ' ', fixed=TRUE)
    tcrfinal <- c()
    for(tcr in to_cap_str) {
      tcrfinal <- c(tcrfinal, capitalize(tcr))
    }
    numlist <- c(numlist, toString(paste(tcrfinal, sep="", collapse="")))
    numlist <- c(numlist, toupper(toString(paste(tcrfinal, sep="", collapse=""))))
    numlist <- c(numlist, tolower(toString(paste(tcrfinal, sep="", collapse=""))))
    numl <- toString(numl)
    if(((str_length(numl) %% 2) == 0) && (str_length(numl) <= 8)) {
      numl2 <- c(substr(numl, 1, str_length(numl)/2), substr(numl, (str_length(numl)/2)+1, str_length(numl)))
      numl2 <- as.integer(numl)
      to_cap_str <- strsplit(str_replace_all(str_replace_all(toString(as.english(numl2)), "[-]", ' '), "[,]", ''), ' ', fixed=TRUE)
      tcrfinal <- c()
      for(tcr in to_cap_str) {
        tcrfinal <- c(tcrfinal, capitalize(tcr))
      }
      numlist <- c(numlist, str_split(paste(tcrfinal, sep="", collapse=""),','))
      numlist <- c(numlist, toupper(str_split(paste(tcrfinal, sep="", collapse=""),',')))
      numlist <- c(numlist, tolower(str_split(paste(tcrfinal, sep="", collapse=""),',')))
    }
    if(str_length(numl) == 3) {
      numl <- c(substr(numl, 1, 1), substr(numl, 2, str_length(numl)))
      numl <- as.integer(numl)
      to_cap_str <- strsplit(str_replace_all(str_replace_all(toString(as.english(numl)), "[-]", ' '), "[,]", ''), ' ', fixed=TRUE)
      tcrfinal <- c()
      for(tcr in to_cap_str) {
        tcrfinal <- c(tcrfinal, capitalize(tcr))
      }
      numlist <- c(numlist, str_split(paste(tcrfinal, sep="", collapse=""),','))
      numlist <- c(numlist, toupper(str_split(paste(tcrfinal, sep="", collapse=""),',')))
      numlist <- c(numlist, tolower(str_split(paste(tcrfinal, sep="", collapse=""),',')))
    }
  }
  return(unlist(numlist))
}

for (i in 1:length(rawp)){
  l <- rawp[i]
  l <- gsub(' ', '', l)
  if (grepl('\\d', l)) {
    l <- as.integer(l)
    for(inc in 1:5) {
      pplist <- c(pplist, toString(l+inc))
      pplist <- c(pplist, toString(l-inc))
    }
    l <- toString(l)
  }
  else {
    pplist <- c(pplist, toupper(l))
    pplist <- c(pplist, tolower(l))
    pplist <- c(pplist, capitalize(l))
  }
  pplist <- c(pplist, num_to_stri(l))
  pplist <- c(pplist, stri_reverse(l))
  pplist <- c(pplist, num_to_stri(stri_reverse(l)))
}
pplist <- unique(pplist)
for (i in 1:length(pplist)){
  l <- pplist[i]
  for(specc in spec_chars) {
    pplist <- c(pplist, paste(l, specc, sep=''))
  }
}
pplist2 <- c()
for (i in 1:length(pplist)){
  l <- pplist[i]
  for(i2 in 1:length(pplist[!(pplist==l)])) {
    subpp <- pplist[!(pplist==l)]
    pplist2 <- c(pplist2, paste(l, subpp[i2], sep=''))
  }
}
pplist <- unique(c(pplist, pplist2))
write.table(data.table(pplist), './PPFinal_R.txt', col.names = FALSE, row.names = FALSE, quote = FALSE)
