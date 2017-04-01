install.packages("ggplot2")
library(ggplot2)
getwd()

pdf("Bitcoin_Plot.pdf")

summary(bitcoin)

ggplot(data = bitcoin, aes (x = timestamp, y = last)) +
  geom_point() +
  geom_line()

dev.off()