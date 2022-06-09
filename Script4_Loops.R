## Clear Console (Use at the beginning) ##
rm(list=ls()); pacman::p_unload(); while (!is.null(dev.list())) dev.off(); cat("\014")
knitr::opts_chunk$set(cache=TRUE) # Use knitr caching to improve performance
options(scipen=999)
# Load Packages
pacman::p_load(tidyverse)

## yesterday's format
gapminder <- readr::read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/gapminder.csv')

## filter the country to plot
gap_to_plot <- gapminder %>%
  filter(country == "Afghanistan")

## plot
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
  geom_point() +
  ## add title and save
  labs(title = paste("Afghanistan", "GDP per capita", sep = " - "))
my_plot

## filter the country to plot
gap_to_plot <- gapminder %>%
  filter(country == "Afghanistan")

## plot
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
  geom_point() +
  ## add title and save
  labs(title = paste("Afghanistan", "GDP per capita", sep = " "))
ggsave(filename = "Afghanistan_gdpPercap.png", plot = my_plot)

# Alternative Plots
## create country variable
cntry <- "Afghanistan"

## filter the country to plot
gap_to_plot <- gapminder %>%
  filter(country == cntry)

## plot
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
  geom_point() +
  ## add title and save
  labs(title = paste(cntry, "GDP per capita", sep = " "))

## note: there are many ways to create filenames with paste() or file.path()
ggsave(filename = paste(cntry, "_gdpPercap.png", sep = ""), plot = my_plot)

#### Executable Loop for list ####
## create a list of countries
country_list <- c("Albania", "Fiji", "Spain")
for (cntry in country_list) {
  ## filter the country to plot
  gap_to_plot <- gapminder %>%
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = paste(cntry, "_gdpPercap.png", sep = ""), plot = my_plot)
}

####Superfast Complete Loop####
dir.create("figures") 

## create a list of countries
country_list <- unique(gapminder$country) # ?unique() returns the unique values

for( cntry in country_list ){
  
  ## filter the country to plot
  gap_to_plot <- gapminder %>%
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## add the figures/ folder
  ggsave(filename = paste("figures/", cntry, "_gdpPercap.png", sep = ""), plot = my_plot)
} 


####Superfast Complete Loop Exercise ####
dir.create("figures") 
dir.create("figures/EU") 

## create a list of countries
gapminder_EU <- gapminder %>%
  filter(continent=="Europe")

country_list <- unique(gapminder_EU$country) # ?unique() returns the unique values

for( cntry in country_list ){
 ## filter the country to plot
  gap_to_plot <- gapminder_EU %>%
    filter(country == cntry)
print(paste("Plotting", cntry)) ## add a print message to see what's plotting
 ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## add the figures/ folder
  ggsave(filename = paste("figures/EU/", cntry, "GdpPercap.png", sep = ""), plot = my_plot)
} 

#### If else based on estimated ####
est <- readr::read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/countries_estimated.csv')
gapminder_est <- left_join(gapminder, est)

dir.create("figures") 
dir.create("figures/Europe") 

## create a list of countries
gap_europe <- gapminder_est %>% ## use instead of gapminder
  filter(continent == "Europe")

country_list <- unique(gap_europe$country) 

for( cntry in country_list ){ # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message 
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## if estimated, add that as a subtitle. 
  if (any(gap_to_plot$estimated == "yes")) { # any() will return a single TRUE or FALSE
    
    print(paste(cntry, "data are estimated"))
    
    my_plot <- my_plot +
      labs(subtitle = "Estimated data")
  } else {
    
    my_plot <- my_plot +
      labs(subtitle = "Reported data")
    
    print(paste(cntry, "data are reported"))
    
  }
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpPercap_cummean.png", sep = ""), 
         plot = my_plot)
} 
