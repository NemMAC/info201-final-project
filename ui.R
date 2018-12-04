library(shiny)
library(dplyr)
library(ggvis)


crimeDataFull <- read.csv("Crime_Data.csv",  stringsAsFactors = FALSE)
crimeDataCut <- select(crimeDataFull, Occurred.Date, Crime.Subcategory, Precinct, Neighborhood)
precinctOption <- unique(crimeDataCut$Precinct)
precinctOption <- precinctOption[1:6]
precinctOption <- precinctOption[-5]
  
ui <- fluidPage(
  navbarPage("Crimes in Seattle",
             tabPanel("Overview"),
             tabPanel("Histogram", 
                sidebarLayout(
                  sidebarPanel(
                    radioButtons("selectPrecinct", "Precinct", precinctOption),
                    dateRangeInput("dateRange", 
                                   label = "Date Range",
                                   start = "12/13/1908",
                                   min = "12/13/1908",
                                   format = "mm/dd/yyyy"
                                   )
                  ),
                  mainPanel(
                    textOutput("test"),
                    uiOutput("ggvis_ui"),
                    ggvisOutput("ggvis")
                  )
                )
             ),
             tabPanel("Map"), 
             tabPanel("Rankings")
  )
)