

###########################################################################################
hightech <- read.csv('High tech export.csv', header = T, row.names = 1, check.names = F)

country <- rownames(hightech)
hightech_test <- cbind(country, hightech)
row.names(hightech_test) <- c(1:nrow(hightech))

install.packages("tidyr")
library(tidyr)
hightech_test_gather <- gather(hightech_test, "year", "value", 2:25)
hightech_test_gather <- subset(hightech_test_gather, select = c("country","year","value"))

df_Ukraine <- subset(hightech_test_gather, hightech_test_gather$country == "Ukraine")
df_US <- subset(hightech_test_gather, hightech_test_gather$country == "United States")

{r}
qplot(x = year,
      data = subset(df_Ukraine, !is.na(value)),
      y = value,
      geom = 'histogram', 
      stat = 'identity')
#####################################################################################################
AIDS <- read.csv(file = 'gapminderAIDS.csv', header = T, check.names = F)

library(tidyr)
AIDSS <- gather(AIDS,"year","AIDS_Rate",2:23)

names(AIDSS)[1] <- "Country"
names(AIDSS)[3] <- "Deaths"

country.Weurope <- c("Spain","Germany","France")

AIDWEU <- subset(AIDSS, Country %in% country.Weurope, select = Country:Deaths)

p7 <-  ggplot(AIDWEU, aes(x= year, y = Deaths, color = Country,group = Country)) + 
  geom_point(aes(color = Country)) + 
  geom_line()+ 
  ggtitle("AIDS Deaths per Year (1990-2011)")
p7
########################################################################333
BMI <- read.csv(file = "BMI.csv", header = T, check.names = F)
BMI_stacked_col <- gather(BMI,"Year","BMI_Index", 2:30)
names(BMI_stacked_col)

Country_NorthAmerica <- c("United States", "Canada")
BMI_NorthAmerica <- subset(BMI_stacked_col, Country %in% Country_NorthAmerica, select = Country:BMI_Index)

Graph_NorthAmerica <- ggplot(data = BMI_NorthAmerica, aes(x = Year, y = BMI_Index, color = Country, group = Country))+
  geom_point(aes(color = Country))+
  geom_line()+
  ggtitle("BMI in North America")

##################################################################################
library(xlsx)
BloodPressure <- read.xlsx(file = "BloodPressure.xlsx", sheetName = "Data", header = T, 
                           check.names = F)
names(BloodPressure)[1] <- "Country"
BloodPressure_stacked_col <- gather(BloodPressure, "Year", "SBP", 2:30)

Country_NorthAmerica <- c("United States", "Canada")
Country_Europe <- c("Germany", "France", "Belgium", "Greece", "Italy", "Czech Rep.")
Country_Asia <- c("Japan", "China", "Vietnam", "Laos")

BloodPressure_NorthAmerica <- subset(BloodPressure_stacked_col, Country %in% Country_NorthAmerica, select = Country:SBP)
BloodPressure_Europe <- subset(BloodPressure_stacked_col, Country %in% Country_Europe, select = Country:SBP)
BloodPressure_Asia <- subset(BloodPressure_stacked_col, Country %in% Country_Asia, select = Country:SBP)

Graph_NorthAmerica <- ggplot(data = BloodPressure_NorthAmerica, aes(x = Year, y = SBP, color = Country, group = Country))+
  geom_line(aes(color = Country))+
  ylab("Blood Pressure")+
  ggtitle("North America")

Graph_Europe <- ggplot(data = BloodPressure_Europe, aes(x = Year, y = SBP, color = Country, group = Country))+
  geom_line(aes(color = Country))+
  ylab("Blood Pressure")+
  ggtitle("Europe")

Graph_Asia <- ggplot(data = BloodPressure_Asia, aes(x = Year, y = SBP, color = Country, group = Country))+
  geom_line(aes(color = Country))+
  ylab("Blood Pressure")+
  ggtitle("Asia")

library(gridExtra)
grid.arrange(Graph_NorthAmerica, Graph_Europe, Graph_Asia, ncol = 1, top = "Blood Pressure")