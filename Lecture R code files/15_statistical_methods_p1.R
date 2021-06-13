## ----statistical_methods_1.norsjo86, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
# import spss file norsjo86
library(haven)
norsjo86 <- read_sav("../data/norsjo86.sav")  # this becomes a tibble 
norsjo86<-as.data.frame(norsjo86)
head(norsjo86)


## ----statistical_methods_1.measures.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
x<-norsjo86$height
summary(x)
mean(x) # what happens here?
mean(x,na.rm=T) # na.rm=T helps

ownmean<-function(x){mean(x,na.rm=T)} # we can define an own function that removes NA
ownmean(x)
median(x,na.rm=T)
range(x,na.rm=T)
quantile(x,na.rm=T)  


## ----statistical_methods_1.measures.2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
var(x,na.rm=T) # variance 

# alternative calculation of variance
xnm<-x[!is.na(x)]         # first remove the missing observations
v<-sum((xnm-mean(xnm))^2)/(length(xnm)-1)   
v

sd(x,na.rm=T)
sqrt(v)                   # alternative calculation


## ----statistical_methods_1.measures.3, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
cor(norsjo86$sbp,norsjo86$dbp)    # correlation 
cor(norsjo86$sbp,norsjo86$dbp,use="complete.obs")

cor(norsjo86[,c("height","weight","sbp","dbp")],use="complete.obs")
# or similarly
cor(norsjo86[,4:7],use="complete.obs")


## ----statistical_methods_1.measures.4, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
cor(norsjo86$sbp,norsjo86$dbp,use="complete.obs",method="spearman")


## ----statistical_methods_1.measures.5, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
cor.test(norsjo86$sbp,norsjo86$dbp) # by default NAs are removed


## ----figsm_1,echo=ECHO, fig.width=5,fig.height=4,fig.align="center",out.width="60%"-----
plot(norsjo86$sbp,norsjo86$dbp,cex=0.7)


## ----statistical_methods_1.t-test.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
table(norsjo86$smoker) 
# contruct two groups, smokers(1) and non-smokers(0)
sbp.smoker<-norsjo86$sbp[norsjo86$smoker==1]
sbp.nonsmoker<-norsjo86$sbp[norsjo86$smoker==0]
summary(sbp.nonsmoker)
summary(sbp.smoker)

res.t<-t.test(sbp.nonsmoker,sbp.smoker,var.equal=T)
res.t


## ----statistical_methods_1.t-test.2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
res.t<-t.test(sbp~smoker,data=norsjo86,var.equal=T) #  here the groups are separated by variable smoker
res.t

class(res.t)
str(res.t) 

t.test(sbp~smoker,data=subset(norsjo86,agegrp==50),var.equal=T) # we can select a subset


## ----statistical_methods_1.t-test.3, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
res.t1<-t.test(sbp~smoker,data=norsjo86,var.equal=T,alternative="greater")  
res.t1
res.t   # compare with two-sided alternative


## ----statistical_methods_1.t-test.4, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
t.test(sbp~smoker,data=norsjo86) 


## ----statistical_methods_1.t-test.5, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
t.test(sbp.smoker) # not realistic null hypothesis (default mu=0)
t.test(sbp.smoker,mu=120)
res.t.one<-t.test(sbp~1,mu=120,data=subset(norsjo86,smoker==1)) # alternative using formula


## ----statistical_methods_1.t-test.6, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
# paired t-test
library(haven)
Subliminal <- read_sav("../data/Subliminal.sav") ## find data set
Subliminal
Sub.n<-subset(Subliminal,Message=="neutral")
t.test(Sub.n$After,Sub.n$Before,paired=T)

res.t.p<-t.test(Sub.n$After-Sub.n$Before,var.equal=T)


## ----statistical_methods_1.nonparametric.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
wilcox.test(sbp.nonsmoker,sbp.smoker) # alternative with two vectors
wilcox.test(sbp~smoker,data=norsjo86) #  alternative using formula  


## ----statistical_methods_1.nonparametric.2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
wilcox.test(Sub.n$After,Sub.n$Before,paired=T,exact=F) 


## ----statistical_methods_1.chi2.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----

pregpain<-as.table(matrix(c(22,131,12,15),nrow=2))
pregpain
dimnames(pregpain)<-list(weight=c("increase <15","increase >15"),pain=c("pain","no pain"))
pregpain

round(prop.table(pregpain,margin=1),2)  

# it works with pregpain as a data frame or matrix too
res.c<-chisq.test(pregpain)  
res.c


## ----statistical_methods_1.chi2.1b, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
class(res.c)
str(res.c)

res.c$expected
res.c$observed
res.c$observed-res.c$expected


## ----statistical_methods_1.chi2.2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
norsjo86$bmic<-cut(norsjo86$bmi,breaks=c(0,25,Inf),labels=c("<25",">25"))  
norsjo86$smokerf<-factor(norsjo86$smoker,labels=c("No smoker","Smoker"))  # optional

aggtab1<-table(norsjo86$smokerf,norsjo86$bmic)
aggtab1

aggtab2<-xtabs(~smokerf+bmic,data=norsjo86)     # alternative table
aggtab2

res.ca<-chisq.test(aggtab2)                     # chi-square test
res.ca

# We need not do this procedure - using individual data works as well
res.ci<-chisq.test(norsjo86$smokerf,norsjo86$bmic) 
res.ci
res.ci$observed # compare with aggtab1 (aggtab2)


## ----statistical_methods_1.chi2.3, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
res.fa<-fisher.test(aggtab2)                         # aggregated data
res.fa

res.fi<-fisher.test(norsjo86$smokerf,norsjo86$bmic)  # individual data
res.fi


## ----statistical_methods_1.chi2.4, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
t22<-table(norsjo86$agegrp,norsjo86$bmic)
round(prop.table(t22,margin=1),2)

chisq.test(norsjo86$agegrp,norsjo86$bmic)


## ----statistical_methods_1.chi2.4b, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
summary(xtabs(~agegrp+bmic, data=norsjo86)) 


## ----statistical_methods_1.chi2.5, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----
n.sold.houses<-c(17,14,18,26,19,24)
n.sold.houses
chisq.test(n.sold.houses)


## ----statistical_methods_1.ks, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-------
# KS test
sbp50<-norsjo86$sbp[norsjo86$agegrp==50]

# standardise the observations
m<-mean(sbp50,na.rm=T)
s<-sd(sbp50,na.rm=T)
sbp.st<-(sbp50-m)/s

ks.test(sbp50,"pnorm")  # null hypothesis is standard normal

table(duplicated(sbp50)) # We should avoid ties for this method. 
        # There are a lot of ties. They are removed below 

        # compare standardised observations to standard normal
ks.test(sbp.st[!duplicated(sbp.st)],"pnorm")  

        # compare original observations to normal(mean=m,sd=s)
ks.test(sbp50[!duplicated(sbp50)],"pnorm",m,s)   


shapiro.test(sbp50)     # Shapiro-Wilk test


## ----figsm_2,echo=ECHO, fig.width=8,fig.height=6,out.width="60%",fig.align="center"-----
qqnorm(sbp50,cex=0.7)
qqline(sbp50,col=2)

