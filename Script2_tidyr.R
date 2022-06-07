library(tidyverse)
options(scipen=999)
## read gapminder csv. Note the readr:: prefix identifies which package it's in
gapminder <- read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/gapminder.csv') 
## explore the gapminder dataset
gapminder # this is super long! Let's inspect in different ways

head(gapminder) # shows first 6
tail(gapminder) # shows last 6
str(gapminder)
names(gapminder)
dim(gapminder)    # ?dim dimension
ncol(gapminder)   # ?ncol number of columns
nrow(gapminder)   # ?nrow number of rows
summary(gapminder)

library(skimr) # install.packages('skimr')
skimr::skim(gapminder)

gapminder$lifeExp # very long! hard to make sense of...
head(gapminder$lifeExp) # can do the same tests we tried before
str(gapminder$lifeExp) # it is a single numeric vector
summary(gapminder$lifeExp) # same information, formatted slightly differently

#filter
filter(gapminder, lifeExp > 80)
filter(gapminder, country == "Mexico")
filter(gapminder, country %in% c("Mexico", "Peru"))
filter(gapminder, country == "Mexico", year == 2002)
X1 <- filter(gapminder, country == "Brazil", year>1986)
mean(X1$lifeExp)
What was the average life expectency in Brazil between 1987 and 2007?
  Hint: do this in 2 steps by assigning a variable and then using the mean() function.

Then, sync to Github.com (pull, stage, commit, push).