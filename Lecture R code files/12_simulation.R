## ----simulation.1,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------------
die<-c(1:6)
die
sample(die,1) # one throw
sample(die,1) # another throw
y<-sample(die,size=15,replace=T) # result of 15throws
y


## ----simulation.2,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------------
set.seed(1001)      # explained further down
n<-5
throws<-sample(die,size=3*n,replace=T)
throws
y<-data.frame(matrix(throws,ncol=3))    
# using matrix to specify dimensions
# data is stored by column

y         # Each row is three throws with the die.
ys3<-y[,1]+y[,2]+y[,3]
ys3

ys3b<-apply(y,MARGIN=1,FUN=sum)  # However, this may be a better alternative 
ys3b

# repetition of sam commands but large size calculation (n)
n<-10000
y<-matrix(sample(die,size=3*n,replace=T),ncol=3)
str(y)
ys3b<-apply(y,MARGIN=1,FUN=sum)
str(ys3b)
# the proportion of TRUE is the probability we wanted to calculate
table(ys3b>=12)/n

# or similarly
prop.table(table(ys3b>=12))


## ----simulation.3,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------------
set.seed(1001)
sample(die,size=10,replace=T)
sample(die,size=10,replace=T)

set.seed(1001)
sample(die,size=10,replace=T)
set.seed(1001)


## ----simulation.4,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------------
set.seed(1001)
urn<-c(rep("black",10),rep("white",5),rep("red",7))
urn
sample(urn,size=5,replace=F)  # Observe replace=F

sample(urn,size=5,replace=F)  # another sample


## ----simulation.5,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------------
set.seed(1001)
runif(5,min=0,max=1) # uniform distribution

x<-runif(1000,min=-2,max=2)

rnorm(5) # per default standard normal distribution

y1<-rnorm(1000)
summary(y1)
sd(y1)

y2<-rnorm(1000,mean=2,sd=0.1)
summary(y2)
sd(y2)

# illustration of the number of times we get "six" when throwing a die 5 times.
# The   experiment is repeated 1000 times. The probablility of each throw=1/6
z<-rbinom(n=1000,size=5,p=1/6) 
table(z)

# the estimated probabilities of the number of getting "6" in five throws
prop.table(table(z))


## ----fig_sim,echo=ECHO,fig.width=8,fig.height=12,out.width="60%",fig.align="center"-----
par(mfrow=c(3,1))
hist(x,main="Uniform(2,2)",breaks=seq(-2.5,2.5,by=0.25))
hist(y1,main="Normal(0,1) i.e. standard normal",breaks=seq(-4,4,by=0.2))
hist(y2,main="Normal(2,0.1)",breaks=seq(1.5,2.5,by=0.025))


## ----simulation.6,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------------
head(mtcars)
nrow(mtcars)

fit0<-lm(mpg~wt,data=mtcars)
summary(fit0)

set.seed(1001)
library(boot)

# This is a function to estimate the model and as result give the R-Squared 
rsq <- function(formula, data, indices) {
  d <- data[indices,] # indices allows boot to select a specific sample
  fit <- lm(formula, data=d) 
  return(summary(fit)$r.square)
}

# Example of the function rsq where all observations in the original data is used
# Compare with R-squared in the result (fit0) above
rsq(mpg~wt,data=mtcars,1:32)

# bootstrapping with 1000 replications
results <- boot(data=mtcars, statistic=rsq,
                R=1000, formula=mpg~wt)

results

results$t0  # this is the result from the original sample, compare R-squared

# this is the simulated 1000 estimates of R-squared
length(results$t)


mean(results$t)-results$t0    # compare the bias in the printed result
sd(results$t)     # compare the standard deviation in the printed result

# there are 5 possible types of confidence intervals, the default is "all" 
boot.ci(results, type="perc") 

# compare with quantiles, it seems very similar
quantile(results$t,c(0,0.025,0.975,1)) 


## ----simulation.6.fig, warning=WARN, eval=EVAL, echo=T,comment=COMMENT,fig.width=12,fig.height=8,out.width="60%",fig.align="center"----
par(mfrow=c(1,1))
hist(results$t,breaks=seq(0.3,1,by=0.05)) 

