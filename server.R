library(shiny)
library(dplyr)
library(ggvis)
library(openair)
library(leaflet)


server <- function(input, output) {
  
  map_data <- read.table("Crime_Data_Map.csv", stringsAsFactors = FALSE)
  crimeDataFull <- read.csv("Crime_Data.csv",  stringsAsFactors = FALSE)
  crimeDataCut <- select(crimeDataFull, Occurred.Date, Crime.Subcategory, Precinct, Neighborhood)
  crimeDataReact <- reactive({filter(crimeDataCut,
                                     as.Date(Occurred.Date, "%m/%d/%Y") %in% seq(as.Date(input$dateRange[1], "yyyy-mm-dd"), as.Date(input$dateRange[2], "yyyy-mm-dd"), by = "1 day"),
                                     Precinct == input$selectPrecinct,
                                     Crime.Subcategory != "")
  })
  
  reactive({crimeDataReact %>% 
      ggvis(~factor(Crime.Subcategory), fill = ~factor(Crime.Subcategory)) %>%
      add_axis("x", 
               title = "Crime", 
               tick_padding = 90, 
               properties = axis_props(labels = list(angle = 300, fontSize = 10))) %>%
      add_axis("y", 
               title = "Count", 
               properties = axis_props(labels = list(angle = 345, fontSize = 10))) %>% 
      set_options(height = 500,
                  width = 1920)
  }) %>% bind_shiny("ggvis", "ggvis_ui")
  
  get_specific_map_data <- reactive({
    df <- filter(map_data, map_data$Event.Clearance.Group == input$select)
  })
  
  output$map <- renderLeaflet({
    m_data <- get_specific_map_data()
    leaflet(m_data) %>%
      addTiles() %>%
      setView(-122.3320708, 47.6062095, zoom = 11) %>%
      addCircles(m_data$Longitude, m_data$Latitude, weight = 2, popup = paste0(m_data$Hundred.Block.Location, " - ",
                                                                               m_data$Event.Clearance.SubGroup), opacity = 0.5)
  })
  
}