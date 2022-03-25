#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(lubridate)
options(scipen=999)

pop <- read.csv("https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/WPP2019_TotalPopulationBySex.csv")

colSums(is.na(pop))

pop$Time <- ymd(pop$Time, truncated = 2L)

pop <- drop_na(pop)

pop2 <- pop %>% select(Time,Location,PopTotal) %>% filter(Location == "Slovakia")  %>% mutate(PopTotal=PopTotal/1000) %>% filter(year(Time)<2018) %>% 
    group_by(Year=year(Time)) %>% summarise(Population = sum(PopTotal))


ui <- fluidPage(
    
    titlePanel("Population of Slovakia 1958 - 2022"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("yearInput", "Year", min=1958, max=2018, 
                        value=c(1958, 2018), sep="")
        ),  
        
        mainPanel(
            tabsetPanel(
                tabPanel("Population", plotOutput("poplot")), 
                tabPanel("Guide", textOutput("text")) 
                
                
            ) 
        ) 
    )   )
