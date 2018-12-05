library(shiny)
library(dplyr)
library(ggvis)
<<<<<<< HEAD
library(leaflet)

crimeDataFull <- read.csv("Crime_Data.csv",  stringsAsFactors = FALSE)
crimeDataCut <- select(crimeDataFull, Occurred.Date, Crime.Subcategory, Precinct, Neighborhood)
precinctOption <- unique(crimeDataCut$Precinct)
precinctOption <- precinctOption[1:6]
precinctOption <- precinctOption[-5]
=======
>>>>>>> e72636c6904c54035c7275dc4959386e861be97f


crimeDataFull <- read.csv("Crime_Data.csv",  stringsAsFactors = FALSE)
crimeDataCut <- select(crimeDataFull, Occurred.Date, Crime.Subcategory, Precinct, Neighborhood)
precinctOption <- unique(crimeDataCut$Precinct)
precinctOption <- precinctOption[1:6]
precinctOption <- precinctOption[-5]
  
ui <- fluidPage(
  navbarPage("Crimes in Seattle",
             tabPanel("Overview"),
             tabPanel("Histogram", 
<<<<<<< HEAD
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
             tabPanel("Map", 
                      titlePanel(
                        p("Seattle - Crime Map"),
                        p("The below contains all the instances of the chosen crime as well as exact location 
                          when you click on a point.")
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
=======
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
>>>>>>> e72636c6904c54035c7275dc4959386e861be97f
             tabPanel("Rankings")
  )
)