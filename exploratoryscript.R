data.path <- "./ClimateChange-App/data/GlobalLandTemperaturesByCountry.csv"
climate <- read.csv(data.path)

cnames <- as.character(unique(climate$Country))
climate$year <- year(climate$dt)

climate<- climate %>% 
  filter(!is.na(AverageTemperature)) %>%
  group_by(year, Country) %>% 
  summarise(YearlyMean = mean(AverageTemperature))

range(climate$YearlyMean)