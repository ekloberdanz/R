data("airquality")
names(airquality)
plot(Ozone~Solar.R,data=airquality)
model1=lm(Ozone~Solar.R,data=airquality)
model1
abline(model1,col="red")
plot(model1)
coplot(Ozone~Solar.R|Wind,panel=panel.smooth,data=airquality)
#model2=lm(Ozone~Solar.R*Wind,data=airquality)
model2=lm(Ozone~(Solar.R+Wind)^2,data=airquality)
model2
plot(model2)
summary(model2)
termplot(model2)
summary(airquality$Solar.R)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#7.0   115.8   205.0   185.9   258.8   334.0       7 
summary(airquality$Wind)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#1.700   7.400   9.700   9.958  11.500  20.700

predict(model2,data.frame(Solar.R=100,Wind=1:20))

Solar1=mean(airquality$Solar.R,na.rm=T)
Solar2=100
Solar3=300

p1=predict(model2,data.frame(Solar.R=Solar1,Wind=1:20))
p2=predict(model2,data.frame(Solar.R=Solar2,Wind=1:20))
p3=predict(model2,data.frame(Solar.R=Solar3,Wind=1:20))

plot(Ozone~Wind,airquality)
lines(1:20,p1,col="red")
lines(1:20,p2,col="blue")
lines(1:20,p3,col="green")





       