library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)

climate <- read.csv("./data/GlobalLandTemperaturesByCountry.csv")
cnames <- as.character(unique(climate$Country))

climate$year <- year(climate$dt)

climate<- climate %>% 
  filter(!is.na(AverageTemperature)) %>%
  group_by(year, Country) %>% 
  summarise(YearlyMean = mean(AverageTemperature))

# UI =============
ui <- fluidPage(
  
  titlePanel("ClimateChange"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select here a country to view"),
      
      selectInput(inputId = "country.id",
                  label = "Country",
                  choices = cnames,
                  selected = cnames[1])
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput("plot")),
                  tabPanel("Summary", verbatimTextOutput("summary")))
    )
  )
  
)


# Server =========
server <- function(input, output){
 
  output$plot <- renderPlot({
    
    x <- switch(input$country.id,
                )
    
    g <- ggplot(data = climate, aes(x = year, y = YearlyMean))
    
  }) 
}

shinyApp(ui = ui, server = server)