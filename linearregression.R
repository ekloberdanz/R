data("airquality")
names(airquality)
# "Ozone"   "Solar.R" "Wind"    "Temp"    "Month"   "Day" 
plot(Ozone~Solar.R,data=airquality)
mean.Ozone<-mean(airquality$Ozone,na.rm=T)
print(mean.Ozone)
abline(h=mean.Ozone)
model1=lm(Ozone~Solar.R,data=airquality)
model1
abline(model1,col="red")
plot(model1)
summary(model1)
