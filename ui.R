library(shiny)
library(dplyr)
library(ggvis)
library(leaflet)

crimeDataFull <- read.csv("Crime_Data.csv",  stringsAsFactors = FALSE)
crimeDataCut <- select(crimeDataFull, Occurred.Date, Crime.Subcategory, Precinct, Neighborhood)
precinctOption <- unique(crimeDataCut$Precinct)
precinctOption <- precinctOption[1:6]
precinctOption <- precinctOption[-5]

ui <- fluidPage(
  navbarPage("Crimes in Seattle",
             tabPanel("Overview"),
             tabPanel("Histogram", 
                      titlePanel(
                        "Plot of Crimes by Precinct"
                      ),
                      sidebarLayout(
                        sidebarPanel(
                          helpText(
                            "Choose Precinct and Dates to view data from"
                          ),
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
tabPanel("Map", 
         titlePanel(
           "Seattle - Crime Map"
           ),
         sidebarLayout(
           sidebarPanel(
             helpText(
               "Please choose a type of crime to map."
             ), 
             selectInput("select", label = h3("Type of Crime"),
                         choices = list("Assault" = "ASSAULTS", "Auto Thefts" = "AUTO THEFTS", 
                                        "Sexual Assault" = "FAILURE TO REGISTER (SEX OFFENDER)", 
                                        "Homicide" = "HOMICIDE", "Burglary" = "BURGLARY", 
                                        "Property Damage" = "PROPERTY DAMAGE"),
                         selected = "Assault"
             )
           ),
           mainPanel(
             leafletOutput("map")
           )
         )
         ),   
tabPanel("Rankings")
)
)