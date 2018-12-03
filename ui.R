library(shiny)

ui <- fluidPage(
  navbarPage("Crimes in Seattle",
             tabPanel("Overview"), 
             tabPanel("Histogram"),
             tabPanel("Map"), 
             tabPanel("Rankings")
  )
)