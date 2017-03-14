install.packages("Quandl")
library(Quandl)
Quandl.api_key("tK1nVcgSeLJUfkpozmGx")

stock_Deere <- Quandl("WIKI/DE", start_date = "2010-01-01")[, c("Date", "Close")]
stock_Cat <- Quandl("WIKI/CAT", start_date = "2010-01-01")[, c("Date", "Close")]

mergedDeere_Cat <- merge(x = stock_Deere, y = stock_Cat, by = "Date", all = TRUE)
colnames(mergedDeere_Cat)[2] <- "Daily_Deere"
colnames(mergedDeere_Cat)[3] <- "Daily_Cat"
names(mergedDeere_Cat)

library(ggplot2)
ggplot(data = mergedDeere_Cat, aes(x = Date)) +
  geom_line(aes(y = mergedDeere_Cat$Daily_Deere), color = "red", show.legend = TRUE) +
  geom_line(aes(y = mergedDeere_Cat$Daily_Cat), color = "blue", show.legend = TRUE) +
  ylab("Close Price")

library(tidyr)
mergedDeere_Cat <- separate(data = mergedDeere_Cat, col = Date, into = c("Year", "Month", "Day"), sep = "-", remove = FALSE)
names(mergedDeere_Cat)
Deere_medians_by_month <- aggregate(list(Montly_Median_Deere = mergedDeere_Cat$Daily_Deere, Monthly_Median_Cat = mergedDeere_Cat$Daily_Cat), 
                                    list(Month = mergedDeere_Cat$Month), FUN = median, na.rm = TRUE)

data <- merge(mergedDeere_Cat, Deere_medians_by_month, by = "Month")
data$Deere_Diff <- data$Daily_Deere - data$Montly_Median_Deere
data$Cat_Diff <- data$Daily_Cat - data$Monthly_Median_Cat

# assign NA values as "NA" so that excel recognizes it
data[is.na(data)] <- "NA"

library(readxl)
library(xlsx)
write.xlsx(x = data, file = "Quandl_Stocks.xlsx")

