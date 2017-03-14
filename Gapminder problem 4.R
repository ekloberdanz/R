#The relationship between BMI and Blood Pressure
library(xlsx)

BMI <- read.xlsx(file = "BMI.xlsx", sheetName = "Data", check.names = F, header = T)
BloodPressure <- read.xlsx(file = "BloodPressure.xlsx", sheetName = "Data", check.names = F, header = T)
names(BloodPressure)[1] <- "Country"

library("dplyr")
library(tidyr)
BMI_stacked_col <- gather(BMI,"Year","BMI_Index", 2:30)
BloodPressure_stacked_col <- gather(BloodPressure, "Year", "SBP", 2:30)
BMI_and_BloodPressure <- inner_join (BMI_stacked_col, BloodPressure_stacked_col, by = c("Country", "Year"))

Graph_BMI_and_BloodPressure <- ggplot(data = BMI_and_BloodPressure, aes(x = BMI_Index, y = SBP))+
  geom_point()+
  stat_smooth(method = lm, formula = y~x)+
  ggtitle("The relationship between BMI and Blood Pressure 
          in all countries: 1980 - 2008")
Graph_BMI_and_BloodPressure
cor(BMI_and_BloodPressure$BMI_Index, BMI_and_BloodPressure$SBP)
