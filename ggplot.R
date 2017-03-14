reddit = read.csv("reddit.csv")
summary(reddit)
levels(reddit$age.range)
install.packages("ggplot2")
library(ggplot2)
qplot(data = reddit, x = age.range)
qplot(data = reddit, x = gender)
qplot(data = reddit, x = military.service)
qplot(data = reddit, x = children)
qplot(data = reddit, x = country)
qplot(data = reddit, x = cheese)

qplot(data = reddit, x = income.range)
levels(reddit$income.range)
income.range=ordered(reddit$income.range,levels = c ("Under $20,000", "$20,000 - $29,999", "$30,000 - $39,999",
                                               "$40,000 - $49,999", "$50,000 - $69,999", "$70,000 - $99,999",
                                               "$100,000 - $149,999", "$150,000 or more" ))
income.range
levels(income.range)
qplot(data = reddit, x = income)

qplot(data = reddit, x = age.range)
levels(reddit$age.range)
reddit$age.range=ordered(reddit$age.range,levels = c("Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above"))
qplot(data=reddit,x=age.range)
