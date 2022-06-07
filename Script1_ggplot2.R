library(tidyverse)
#National Parks in California
ca <- read_csv("https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/ca.csv") 

#Acadia National Park
acadia <- read_csv("https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/acadia.csv")

#Southeast US National Parks
se <- read_csv("https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/se.csv")

#2016 Visitation for all Pacific West National Parks
visit_16 <- read_csv("https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/visit_16.csv")

#All Nationally designated sites in Massachusetts
mass <- read_csv("https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/mass.csv")

options(scipen=999)
head(ca)
str(ca)
ggplot(data=ca) +
  geom_point(aes(x = year, y = visitors))
ggplot(data = ca) +
  geom_point(aes(x = year, y = visitors,color = park_name))

ggplot(data = ca) +
  geom_point(aes(x = year, y = visitors, color = park_name)) +
  labs(x = "Year",
       y = "Visitation",
       title = "California National Park Visitation") +
  theme_bw() +
  theme(legend.title=element_blank())


ggplot(data = se) +
  geom_point(aes(x = year, y = visitors, color = park_name)) +
  labs(x = "Year",
       y = "Visitation",
       title = "National Park Visitation") +
  theme_bw() +
  theme(legend.title=element_blank())

# 2. & 3.
ggplot(data = se) +
  geom_point(aes(x = year, y = visitors, color = state)) +
  labs(x = "Year",
       y = "Visitation",
       title = "Southeast States National Park Visitation") +
  theme_light() +
  theme(legend.title = element_blank(),
        axis.text.x = element_text(angle = 90, hjust = 1, size = 14))

#Faceting Plots
ggplot(data = se) +
  geom_point(aes(x = year, y = visitors)) +
  facet_wrap(~ state)

ggplot(data = se) +
  geom_point(aes(x = year, y = visitors, color = park_name))
  facet_wrap(~ state, scales = "free") 
  
  
#Jitter
ggplot(data = se) + 
    geom_jitter(aes(x = park_name, y = visitors, color = park_name), 
                width = 0.1, 
                alpha = 0.4) +
    coord_flip() +
    theme(legend.position = "none") 

#Boxplot
ggplot(se, aes(x = park_name, y = visitors)) + 
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#Geom_line
ggplot(se, aes(x = year, y = visitors, color = park_name)) +
  geom_line()

#Geom_Smooth
ggplot(data = acadia) + 
  geom_point(aes(x = year, y = visitors)) +
  geom_line(aes(x = year, y = visitors)) +
  geom_smooth(aes(x = year, y = visitors)) +
  labs(title = "Acadia National Park Visitation",
       y = "Visitation",
       x = "Year") +
  theme_bw()

ggplot(data = acadia, aes(x = year, y = visitors)) + 
  geom_point() +
  geom_line() +
  geom_smooth(color = "red") +
  labs(title = "Acadia National Park Visitation",
       y = "Visitation",
       x = "Year") +
  theme_bw()

#geom_bar
ggplot(data = visit_16, aes(x = state)) + 
  geom_bar()

#Position_adjust
ggplot(data = visit_16, aes(x = state, y = visitors, fill = park_name)) + 
  geom_bar(stat = "identity")

ggplot(data = visit_16, aes(x = state, y = visitors, fill = park_name)) + 
  geom_bar(stat = "identity", position = "dodge")

#how many of each types of parks are in Massachusetts?
ggplot(data = mass) + 
  geom_bar(aes(x = type, fill = park_name)) +
  labs(x = "",
       y = "")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7))

#Arrange and rearrange Plots
my_plot <- ggplot(data = mass) + 
  geom_bar(aes(x = type, fill = park_name)) +
  labs(x = "",
       y = "")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7))
ggsave("name_of_file.png", my_plot, width = 15, height = 10)

#Plotly 
#install.packages("plotly")
library(plotly)
ggplotly(my_plot)


acad_vis <- ggplot(data = acadia, aes(x = year, y = visitors)) + 
  geom_point() +
  geom_line() +
  geom_smooth(color = "red") +
  labs(title = "Acadia National Park Visitation",
       y = "Visitation",
       x = "Year") +
  theme_bw()
acad_vis
ggplotly(acad_vis)
