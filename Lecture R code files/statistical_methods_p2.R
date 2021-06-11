## ----stat_meth_2.formula, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------

f1<-y~x+z # f1 is a formula

class(f1)
typeof(f1)




## ----stat_meth_2.simple.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-----------
library(haven)
norsjo86 <- read_sav("../data/norsjo86.sav")

summary(norsjo86) # There are some missing, especially in health
nrow(norsjo86)

# remove the variable health and remove missing in the remaining variables 
norsjo<-na.omit(norsjo86[,-2])  
 
# rename kolester to chorelstorol
names(norsjo)[names(norsjo) == "kolester"] <- "cholesterol"

nrow(norsjo) # 8 observations removed

res<-lm(norsjo$cholesterol~norsjo$bmi) # this is one method but somewhat prolix 
res<-lm(cholesterol~bmi,data=norsjo)   # this is a more convenient way

res                                 # printing the results don't give a comprehensive output
class(res)
summary(res)                        # using summary gives a reasonable amount of information


## ----fig_sm.simple.1,echo=ECHO, fig.width=8,fig.height=6,out.width="60%",fig.align="center"----
#par(mfrow=c(1,2))
plot(cholesterol~bmi,data=res$model,cex=0.7) # same as plot(cholesterol~bmi,data=norsjo)
abline(res$coefficients,col=2)

abline(coef(res),col=2) # alternative


## ----stat_meth_2.simple.2,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT--------------
par(mfrow=c(2,2))
par(mar = c(1,1,1,1))
plot(res,cex=0.6) # plot is generic, here it gives four plots
par(mfrow=c(1,1))


## ----stat_meth_2.mlr.1,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT-----------------
table(norsjo$agegrp)
res<-lm(cholesterol~bmi+agegrp,data=norsjo)
summary(res)


## ----stat_meth_2.ci.1,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT------------------
library(Epi)
round(ci.lin(res),3)  # with 95% confidence interval
round(ci.lin(res,alpha=0.1),3)  # with 90% confidence interval


## ----stat_meth_2.mlr.2,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT-----------------
res<-lm(cholesterol~bmi+as.factor(agegrp),data=norsjo)
summary(res)


## ----stat_meth_2.mlr.3,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT-----------------
fage<-as.factor(norsjo$agegrp) 
norsjo<-cbind(norsjo,fage)  # add the factor to the data frame

levels(norsjo$fage)
contrasts(norsjo$fage)

contr.treatment(1:4)
contr.treatment(levels(norsjo$fage))


## ----stat_meth_2.mlr.4,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT-----------------
contr.sum(levels(norsjo$fage))


options()$contrasts   # using contr.treatment is the default


## ----stat_meth_2.mlr.5,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT-----------------
res.n2<-lm(cholesterol~bmi+fage,data=norsjo)
summary(res.n2)


## ----stat_meth_2.mlr.6,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT-----------------
norsjo$newfage<-relevel(norsjo$fage,"50")

levels(norsjo$newfage)
res<-lm(cholesterol~bmi+newfage,data=norsjo)
summary(res)


## ----stat_meth_2.anova.1,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT---------------
lm.age<-lm(cholesterol~fage,data=norsjo)
summary(lm.age)


## ----stat_meth_2.anova.2,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT---------------
aov.age<-aov(cholesterol~fage,data=norsjo)
summary(aov.age)


## ----stat_meth_2.lr.1,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT------------------
lm.m1<-lm(cholesterol~fage,data=norsjo)
lm.m2<-lm(cholesterol~fage+sbp+bmi,data=norsjo)

anova(lm.m1,lm.m2)


## ----stat_meth_2.lr.2,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT------------------
round(summary(lm.m2)$coef,4)


## ----stat_meth_2.lr.3,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT------------------
lm.m0<-lm(cholesterol~1,data=norsjo)
anova(lm.m0,lm.m1)


## ----stat_meth_2.anova.5,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT---------------
sbpcat<-cut(norsjo$sbp,c(0,110,130,Inf))
is.factor(sbpcat)
levels(sbpcat)

norsjo<-cbind(norsjo,sbpcat)  # alternative to add a variable to a data frame
head(norsjo)

aov.agesbp<-aov(cholesterol~fage+sbpcat,data=norsjo)
summary(aov.agesbp)


## ----stat_meth_2.anova.6,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT---------------
aov.agesbp.int<-aov(cholesterol~fage*sbpcat,data=norsjo)    
                    # main effects plus remaining interaction terms
summary(aov.agesbp.int)

aov.agesbp.int<-aov(cholesterol~fage:sbpcat,data=norsjo)
                    # only interaction terms
summary(aov.agesbp.int)


## ----stat_meth_2.simple.10,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT-------------
glm.m2<-glm(cholesterol~fage+sbp+bmi,data=norsjo)
summary(glm.m2)

summary(lm.m2) # Same result with glm and lm


## ----stat_meth_2.simple.10b,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT------------
class(glm.m2)
class(lm.m2)


## ----stat_meth_2.logreg.1,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT--------------
dbpcat<-cut(norsjo$dbp,c(0,80,Inf))
levels(dbpcat)
norsjo<-cbind(norsjo,dbpcat)

bin.m1<-glm(dbpcat~bmi,data=norsjo,family=binomial)
summary(bin.m1)


## ----stat_meth_2.logreg.2,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT--------------
library(Epi)
res.ci<-ci.lin(bin.m1)  # log(odds) ratio with 95% confidence interval 
round(res.ci,3)

res.cie<-ci.exp(bin.m1)  # odds ratio with 95% confidence interval for 
round(res.cie,3)

round(ci.exp(bin.m1,pval=T,alpha=0.1),3)  # p-value added and 90% CI


## ----stat_meth_2.survival.1,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT------------
library(haven)
adf <- read_dta("../data/Anderson.dta")
adf<-as.data.frame(adf)
head(adf)


## ----stat_meth_2.survival.2,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT------------
library(survival)
survtime<-Surv(adf$survt,adf$status)
class(survtime)
head(survtime)


## ----stat_meth_2.survival.3,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT------------
adf<-cbind(adf,survtime)
sf<-survfit(survtime~1,data=adf)
sf
summary(sf)  # events but not censorings are shown  


## ----fig_sm.survival.4,echo=ECHO, fig.width=10,fig.height=5,out.width="80%",fig.align="center"----
par(mfrow=c(1,2))
plot(sf)  # 95% confidence interval by default
plot(sf,conf.int=F,mark.time=T) # remove CI and add the censorings


## ----stat_meth_2.survival.5,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT------------
adf<-cbind(adf,frx=factor(adf$rx,labels=c("treatment","placebo")))
sf2<-survfit(survtime~frx,data=adf)
par(mfrow=c(1,2))

survdiff(survtime~rx,data=adf) # log-rank test


## ----fig_sm.survival.6,echo=ECHO, fig.width=10,fig.height=5,out.width="80%",fig.align="center"----
par(mfrow=c(1,2))
plot(sf2,col=c(1,2),lty=c(1,2)) # different color and pattern of the curves added
legend(20,0.95,legend=c(levels(adf$frx)),col=c(1,2),lty=c(1,2),cex=0.8)
plot(sf2,col=c(1,2),lty=c(1,2),fun="cloglog") # plot of log-log(S(t))


## ----stat_meth_2.cox.1,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT-----------------
addicts <- read_dta("../data/addicts.dta")
addicts
dim(addicts)


## ----stat_meth_2.cox.2,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT-----------------
survtime<-Surv(addicts$Survt,addicts$Status)
fclinic<-as.factor(addicts$Clinic)
addicts<-cbind(addicts,survtime,fclinic)  # add to the data farme

fitc<-coxph(survtime~Dose+fclinic,data=addicts)
summary(fitc)


## ----fig_sm.cox.4,echo=ECHO, fig.width=10,fig.height=5,out.width="80%",fig.align="center"----
sfc<-survfit(survtime~fclinic,data=addicts)
par(mfrow=c(1,2))
plot(sfc,col=c(1,2))
plot(sfc,fun="cloglog",col=c(1,2))


## ----stat_meth_2.cox.3,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT-----------------
ph<-cox.zph(fitc)
ph


## ----fig_sm.cox.5,echo=ECHO, fig.width=10,fig.height=5,out.width="80%",fig.align="center"----
par(mfrow=c(1,2))
plot(ph)


## ----stat_meth_2.cox.6,warning=WARN,eval=EVAL,echo=ECHO,comment=COMMENT-----------------
library(survival)
fitcs<-coxph(survtime~Dose+strata(fclinic),data=addicts)
summary(fitcs)

