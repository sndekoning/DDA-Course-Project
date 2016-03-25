library(ggplot2)
library(dplyr)
library(lubridate)

data.path <- "./ClimateChange-App/data/climate.csv"
climate <- read.csv(data.path)

cnames <- as.character(unique(climate$Country))
climate$year <- year(climate$dt)

climate<- climate %>% 
  filter(!is.na(AverageTemperature)) %>%
  group_by(year, Country) %>% 
  summarise(YearlyMean = mean(AverageTemperature))

range(climate$YearlyMean)
range(climate$year)


x <- climate[which(climate$Country %in% "Albania"),]


write.csv(climate, file = "./climate.csv")


for(i in 1:length(cnames)){
  cnames[i] = climate[ which(climate$Country %in% cnames[i]),]}
)


g <- ggplot(data = gdata, aes(x = year, y = YearlyMean)) +
  geom_point() +
  geom_smooth(method = lm)