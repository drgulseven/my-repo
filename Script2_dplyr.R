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

#select
select(gapminder, year, country, lifeExp) 
select(gapminder, -continent, -lifeExp) # you can use - to deselect columns

#select and filter together
gap_cambodia  <- filter(gapminder, country == "Cambodia")
gap_cambodia2 <- select(gap_cambodia, -continent, -lifeExp) 

# pipe %>% Operator
gapminder %>% head()
gapminder %>% head(3)

## instead of this...
gap_cambodia  <- filter(gapminder, country == "Cambodia")
gap_cambodia2 <- select(gap_cambodia, -continent, -lifeExp) 

## ...we can do this
gap_cambodia2  <- gapminder %>% 
  filter(country == "Cambodia") %>%  
  select(-continent, -lifeExp) 

#mutate
gapminder %>%
  mutate(gdp = pop * gdpPercap)
gapminder %>% 
  filter(continent=="Asia", year=="2007") %>%
  mutate(pop_1000 = pop/1000)

#group_by() operates on groups
gapminder %>%
  filter(year == 2002) %>%
  group_by(continent) %>% 
  mutate(cont_pop = sum(pop))

#summarize() with group_by()
gapminder %>%
  group_by(continent) %>%
  summarize(cont_pop = sum(pop)) %>%
  ungroup()

gapminder %>%
  group_by(continent, year) %>%
  summarize(cont_pop = sum(pop))%>%
  ungroup()

#arrange
gapminder %>%
  group_by(continent, year) %>%
  summarize(cont_pop = sum(pop)) %>%
  arrange(year)

# What is the maximum GDP per continent across all years?

gapminder %>%
  mutate(gdp = pop * gdpPercap) %>%
  group_by(continent) %>%
  mutate(max_gdp = max(gdp)) %>%
  filter(gdp == max_gdp)

asia_life_exp <- gapminder %>%
  filter(continent == 'Asia') %>%
  group_by(country) %>%
  filter(lifeExp == max(lifeExp)) %>%
  arrange(year) 

## gapminder-wrangle.R
## J. Lowndes lowndes@nceas.ucsb.edu


## load libraries
library(tidyverse) ## install.packages('tidyverse')

## read in data
gapminder <- readr::read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/gapminder.csv') 

## summarize
gap_max_life_exp <- gapminder %>% 
  dplyr::select(-continent, -lifeExp) %>% # or select(country, year, pop, gdpPercap)
  dplyr::group_by(country) %>%
  dplyr::mutate(gdp = pop * gdpPercap) %>%
  dplyr::summarize(max_gdp = max(gdp)) %>%
  dplyr::ungroup() 

## gapminder-wrangle.R --- baseR
## J. Lowndes lowndes@nceas.ucsb.edu


gapminder <- read.csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/gapminder.csv', stringsAsFactors = FALSE) 
x1  <- gapminder[ , c('country', 'year', 'pop', 'gdpPercap') ]# subset columns
mex <- x1[x1$country == "Mexico", ] # subset rows
mex$gdp <- mex$pop * mex$gdpPercap # add new columns
mex$max_gdp <- max(mex$gdp)

#Joining datasets
## read in the data. (same URL as yesterday, with co2.csv instead of gapminder.csv)
co2 <- read_csv("https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/co2.csv")

## explore
co2 %>% head() 
co2 %>% dim() 
co2 %>% str() 
CO2 %>% summary()

## create new variable that is only 2007 data
gap_2007 <- gapminder %>%
  filter(year == 2007) 
gap_2007 %>% dim() # 142  

# left_join keeps everything from the left table and matches as much as it can from the right table. In R, the first thing that you type will be the left table (because it’s on the left)
## left_join gap_2007 to co2
lj <- left_join(gap_2007, co2, by = "country")

## explore
lj %>% dim() #142
lj %>% summary() # lots of NAs in the co2_2017 columm
lj %>% View() 

# right_join keeps everything from the right table and matches as much as it can from the left table
## right_join gap_2007 and co2
rj <- right_join(gap_2007, co2, by = "country")

## explore
rj %>% dim() # 12
rj %>% summary()
rj %>% View() 

# inner_join only keeps the observations that are similar between the two tables
## right_join gap_2007 and co2
ij <- inner_join(gap_2007, co2, by = "country")

## explore
ij %>% dim() # 12
ij %>% summary()
ij %>% View() 

# full_join keeps all observations from both tables.
## full_join gap_2007 and co2
fj <- full_join(gap_2007, co2, by = "country")

## explore
fj %>% dim() # 12
fj %>% summary()
fj %>% View() 

## wide format
gap_wide <- readr::read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/gapminder_wide.csv')

## yesterday's format
gapminder <- readr::read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/gapminder.csv')