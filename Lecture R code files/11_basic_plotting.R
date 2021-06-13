## ----basic_plotting.hist, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------------------
# import spss file norsjo86
library(haven)
nors <- read_sav("../data/norsjo86.sav")
nors<-as.data.frame(nors)
head(nors)
par(mfrow=c(2,2))
hist(nors$height)
# hist(nors$height)$breaks
# str(hist(nors$height))
range(nors$height,na.rm=T)
hist(nors$height,breaks=seq(140,200,by=2))
hist(nors$height,breaks=seq(140,200,by=10),col=3,density=30)
hist(nors$height,xlim=c(100,200),freq=F,xlab="Body height",main="Histogram")  
# freq=F   the total area is equal to one


## ----basic_plotting.boxplot, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------------------------
par(mfrow=c(2,2))
 
nors$sex<-factor(nors$sex,labels=c("man","woman"))
# make a factor and set labels

boxplot(cholesterol~sex,data=nors)

boxplot(cholesterol~agegrp,data=nors)

boxplot(cholesterol~agegrp+sex,data=nors) # combining two categorical variables

# Example of some extra options
boxplot(cholesterol~agegrp,data=nors,col=2,ylab="Cholesterol",
        xlab="Age group",width=c(0.1,0.4,0.4,0.1),log="y") 


## ----basic_plotting.scatterplot.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,fig.width=10,fig.height=8,out.width="90%"----
# two similar alternatives with different symbols
par(mfrow=c(2,2))
plot(nors$bmi,nors$cholesterol)  
plot(cholesterol~bmi,data=nors) # using formula object

# Example of some extra options
plot(cholesterol~bmi,data=nors,col=2,pch=2,cex=0.7,ylab="Cholesterol",
     xlab="Body mass index (BMI)",ylim=c(0,15),xlim=c(10,50))  

# two groups in the same plot
plot(height~bmi,data=subset(nors,sex=="man"),pch=16,main="Figure 4")
points(height~bmi,data=subset(nors,sex=="woman"),pch=2,col=2)
legend(x=33,y=185,legend=c("Men","Women"),col=c(1,2),pch=c(16,2),cex=0.7)


## ----basic_plotting.scatterplot.2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,fig.width=10,fig.height=8,out.width="60%"----
x<-seq(-20,20,by=0.001)

y1<-10*x^2-100
plot(x,y1,type="l",ylim=c(-5000,5000),ylab="y")

y2<-5+-x-3*x^2+x^3
lines(x,y2,col=2,lty=2,lwd=2)

y3<-sin(x)*1000
lines(x,y3,col=3,lwd=3)

abline(h=0,lty=2)   # adding a horizontal line

