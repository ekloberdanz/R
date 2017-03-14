# Your first task is to create a
# scatterplot of price vs x.
# using the ggplot syntax.

data("diamonds")
?diamonds
library(ggplot2)
ggplot(aes(x = x, y = price), data = diamonds)+
  geom_point(alpha = 1/25, position = position_jitter(h = 0))+
  geom_smooth(method = "lm", formula = price~x, show.legend = TRUE)+
  scale_y_continuous(limits = c(0, 20000))+
  geom_line(stat = "summary", fun.y =  mean)
?geom_line
?geom_smooth

attach(diamonds)
plot(x, price)
abline(lm(diamonds$price~diamonds$x))

#CORRELATION 
#price and x
cor.test(price, x, data = diamonds)
cor.test(price, y, data = diamonds)
cor.test(price, z, data = diamonds)

# Create a simple scatter plot of price vs depth.
ggplot(aes(x = depth, y = price), data = diamonds)+
  geom_point(alpha = 1/100)+
  scale_x_continuous(breaks = seq(0, 80, 2))


cor.test(depth, price, data = diamonds)

# Create a scatterplot of price vs carat
# and omit the top 1% of price and carat
# values.

ggplot(aes(x = carat, y = price), data = subset(diamonds, price = quantile(0.99), carat = quantile(0.99)))+
  geom_point()

# Create a scatterplot of price vs. volume (x * y * z).
# This is a very rough approximation for a diamond's volume.
# Create a new variable for volume in the diamonds data frame.

diamonds$volume = x*y*z
max(diamonds$volume)


ggplot(aes(x = volume, y = price), data = diamonds)+
  geom_point()


library(plyr)
count(diamonds$volume==0)

#Correlation btw price and volume for diamonds whose volume is > 0 AND <= 800
volume_restricted_diamonds = subset(diamonds, volume <= 800 & volume > 0)
cor.test(volume_restricted_diamonds$volume, volume_restricted_diamonds$price, data = volume_restricted)

#Adjust the transparency of the
# points and add a linear model to the plot. (See the
# Instructor Notes or look up the documentation of
# geom_smooth() for more details about smoothers.)


volume_restricted_diamonds = subset(diamonds, volume <= 800 & volume > 0)
ggplot(aes(x = volume, y = price), data = volume_restricted_diamonds)+
  geom_point(alpha = 1/50)+
  geom_smooth(method = "lm", formula = y ~ x, size = 1)

# Mean Price by Clarity
# Use the function dplyr package
# to create a new data frame containing
# info on diamonds by clarity.

# Name the data frame diamondsByClarity

# The data frame should contain the following
# variables in this order.

#       (1) mean_price
#       (2) median_price
#       (3) min_price
#       (4) max_price
#       (5) n

# where n is the number of diamonds in each
# level of clarity.

library(dplyr)
detach("package:plyr", unload=TRUE)
#summary(diamonds$clarity)
clarity_by_groups = group_by(diamonds, clarity)
clarity_by_groups
diamondsByClarity = summarize(clarity_by_groups, 
                              mean_price = mean(price), 
                              median_price = median(price),
                              min_price = min(price),
                              max_price = max(price),
                              n = n())

color_by_groups = group_by(diamonds, color)
diamondsByColor = summarize(color_by_groups,
                            mean_price = mean(price), 
                            median_price = median(price),
                            min_price = min(price),
                            max_price = max(price),
                            n = n())

cut_by_groups = group_by(diamonds, cut)
diamondsByCut = summarise(cut_by_groups,
                          mean_price = mean(price), 
                          median_price = median(price),
                          min_price = min(price),
                          max_price = max(price),
                          n = n())

p1 = ggplot(aes(x = clarity, y = mean_price), data = diamondsByClarity)+
  geom_bar(stat = "identity", color = "blue", fill = "lightblue")+
  theme_gray()+
  xlab("Clarity")+
  ylab("Mean price")

p2 = ggplot(aes(x = color, y = mean_price), data = diamondsByColor)+
  geom_bar(stat = "identity", color = "blue", fill = "lightblue")+
  theme_gray()+
  xlab("Color")+
  ylab("Mean price")

p3 = ggplot(aes(x = cut, y = mean_price), data = diamondsByCut)+
  geom_bar(stat = "identity")

grid.arrange(p1, p2, p3, ncol = 1, top = "Mean price by Clarity and Color and Cut")




  
