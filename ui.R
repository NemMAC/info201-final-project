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
             tabPanel("Overview",
                      includeMarkdown("overview.md")
                      ),
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
tabPanel("Rankings",
         titlePanel(
           "Relative Safety Ranking"
         ),
         sidebarLayout(
           sidebarPanel(
             helpText(
               "Choose a metric to rank the neighborhoods of Seattle. If you would like to see information about
               a specific area type it's name in the box below. 
               (Please type all possible names such as CHINATOWN/INTERNATIONAL DISTRICT.)"
             ),
             selectInput("rank", label = ("Metric for Ranking"),
                         choices = list("Frequency" = 1, "Violent Crimes" = 2, "Petty/Other crimes" = 3, "Sexual Assault" = 4),
                         selected = "Frequency"
           ),
           textInput("text", label = "Choose Neighborhood", value = "Enter Name...")
         ),
         mainPanel(
           fluidRow(
             splitLayout(cellWidths = c("50%", "50%"), tableOutput("table"), tableOutput("table2"))
           ),
           tableOutput("single")
         )
         )
)
)
)