library(shiny)
library(ggplot2)

climate <- read.csv("./data/climate.csv")
cnames <- as.character(unique(climate$Country))


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
                "Ã…land" = climate[ which(climate$Country %in% cnames[1]),],
                "Albania" = climate[ which(climate$Country %in% cnames[2]),],
                "Andorra" = climate[ which(climate$Country %in% cnames[3]),],
                "Austria" = climate[ which(climate$Country %in% cnames[4]),],
                "Belarus" = climate[ which(climate$Country %in% cnames[5]),],
                "Belgium" = climate[ which(climate$Country %in% cnames[6]),],
                "Bosnia And Herzegovina" = climate[ which(climate$Country %in% cnames[7]),],
                "Bulgaria" = climate[ which(climate$Country %in% cnames[8]),],
                "Croatia" = climate[ which(climate$Country %in% cnames[9]),],
                "Czech Republic" = climate[ which(climate$Country %in% cnames[10]),]
    )
    
    g <- ggplot(data = x, aes(x = year, y = YearlyMean)) +
      geom_point() +
      geom_smooth(method = lm)

    return(g)

  })
  
  output$summary <- renderPrint({
    mean(climate$YearlyMean)
  })
  
}

shinyApp(ui = ui, server = server)