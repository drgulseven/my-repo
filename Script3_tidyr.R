library(tidyverse)
options(scipen=999)
## wide format
gap_wide <- readr::read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/gapminder_wide.csv')

## yesterday's format
gapminder <- readr::read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/gapminder.csv')

head(gap_wide)
str(gap_wide)

?gather
gap_long <- gap_wide %>% 
  gather(key   = obstype_year,
         value = obs_values)

head(gap_long)
str(gap_long)
tail(gap_long)

gap_long <- gap_wide %>% 
  gather(key   = obstype_year,
         value = obs_values,
         dplyr::starts_with('pop'),
         dplyr::starts_with('lifeExp'),
         dplyr::starts_with('gdpPercap'))  #here i'm listing all the columns to use in gather

str(gap_long)
head(gap_long)
tail(gap_long)

gap_long <- gap_wide %>% 
  gather(key   = obstype_year,
         value = obs_values,
         -continent, -country)

str(gap_long)
head(gap_long)
tail(gap_long)

gap_long <- gap_wide %>% 
  gather(key   = obstype_year,
         value = obs_values,
         -continent, -country) %>%
  separate(obstype_year,
           into = c('obs_type','year'),
           sep = "_",
           convert = TRUE) #this ensures that the year column is an integer rather than a character

canada_df <- gap_long %>%
  filter(obs_type == "lifeExp",
         country == "Canada")

ggplot(canada_df, aes(x = year, y = obs_values)) +
  geom_line()

life_df <- gap_long %>%
  filter(obs_type == "lifeExp",
         continent == "Americas")

ggplot(life_df, aes(x = year, y = obs_values, color = country)) +
  geom_line()

# solution (no peeking!)
continents <- gap_long %>% 
  filter(obs_type == "lifeExp", 
         year > 1980) %>% 
  group_by(continent, year) %>% 
  summarize(mean_le = mean(obs_values)) %>%
  ungroup()

ggplot(data = continents, aes(x = year, y = mean_le, color = continent)) + 
  geom_line() +
  labs(title = "Mean life expectancy",
       x = "Year",
       y = "Age (years)") 

## Additional customization
ggplot(data = continents, aes(x = year, y = mean_le, color = continent)) + 
  geom_line() +
  labs(title = "Mean life expectancy",
       x = "Year",
       y = "Age (years)",
       color = "Continent") +
  theme_classic() +
  scale_fill_brewer(palette = "Blues")  

gap_normal <- gap_long %>% 
  spread(obs_type, obs_values)

gap_wide <- gap_long %>%
  head(gap_long) # remember the columns

gap_wide_new <- gap_long %>% 
  # first unite obs_type and year into a new column called var_names. Separate by _
  unite(col = var_names, obs_type, year, sep = "_") 

gap_wide_new <- gap_wide_new %>% 
  # then spread var_names out by key-value pair.
  spread(key = var_names, value = obs_values)
str(gap_wide_new)
# gather(): columns → rows
# spread(): rows → columns
# separate(): character_column → multiple_columns
# unite(): multiple_character_column → single_column

