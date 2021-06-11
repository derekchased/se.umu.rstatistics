## ----functions.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-------------------------
x<-c(1,3,5,7,7,5)
x
sum(x)
mean(x)
max(x)


## ----generic.1, warning=WARN, eval=EVAL, echo=TRUE,comment=COMMENT---------------------------
people <- c('Lena', 'Solveig', 'Anna', 'Hans', 'Erik' )
byear <-  c(1982,      1976,      1949,      2001,   1967)
score <-  c( 22,        43,        87,        45,     60)
salary <- c(40,         47,        31,        32,     45)
df <- data.frame(Name = people, BirthYear = byear, Score = score, Salary = salary)
df

summary(score)
summary(df)


## ----some.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------------------------
names(df)
names(df)[3]
ncol(df)
nrow(df)
dim(df)
str(df)
class(df)


## ----some.2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------------------------
a<-c(37,35,62,45,70)
h<-c(170,162,166,174,192)
df2<-data.frame(Age=a,Heigt=h)
df2
dfw<-cbind(df,df2)  # add the data frames by column
dfw

dfw24<-dfw[c(2,4),]
dfw24
df.dupl<-rbind(dfw,dfw24)  # add the data frames by row
df.dupl


## ----some.3, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------------------------
library(dplyr)
distinct(df.dupl)


## ----functions.3, warning=WARN, eval=EVAL,echo=ECHO,comment=COMMENT--------------------------
rep(2,6)
rep(c(1,5,7),times=3)
rep(c(1,5,7),each=3)
rep(c(1,5,7),times=2,each=3)

1:5
seq(from=1,to=5)
seq(1,5,by=1)
seq(1,5,by=0.5)
seq(1,8,by=3)
seq(4,by=3,length.out=6)
#
#rep is gereral. Also characters and strings can be used
rep(c(412,"c","May is a nice month"),times=2)


## ----functions.oe1, warning=WARN, eval=EVAL,echo=FALSE,comment=COMMENT-----------------------
"vector 1";rep(8:9,times=5)
 
"vector 2"; rep(8:9,times=2,each=3)
 
"vector 3"; rep(8:9,times=2,each=2,length.out=12)

"vector 4"; rep(c(2,"monkey","Lemon"),times=2)
 
"vector 5"; rep(c(2,"monkey","Lemon"),each=2)

"vector 6"; rep(c(2,"monkey","Lemon"),each=2,times=2)

"vector 7"; rep(c(2,"monkey","Lemon"),each=2,length.out=9)


## ----functions.oe2, warning=WARN, eval=EVAL,echo=FALSE,comment=COMMENT-----------------------
"vector 1"; seq(11,14,by=1)

"vector 2"; seq(7,19,by=3)

"vector 3; the odd numers up to 39" ;seq(from=1,by=2,to=39)  # odd number2 up to 39


## ----functions.4, warning=WARN, eval=EVAL,echo=ECHO,comment=COMMENT--------------------------
df<-data.frame(var1=c(1,3,5,3,5,7),var2=rep(c(2,5,3)),var3=rep(c("A","O"),3),
  var4=rep(c("a",4,"Lars")),var5=seq(10,7,length.out=6))

df


sort(df$var2)                # Sorting
sort(df$var2,decreasing=T)   #change to decreasing order
 
df
df[c(1,4,3,6,2,5),] # manual sorting by var2

df$var2
order(df$var2) # Sorting using positions(row numbers) of var2. 
               # It is the same vector as we used for sorting above.
df[order(df$var2),] # so therfore this will also be the dataframe sorted by var2
df[order(df$var2,decreasing=T),] # same but decreasing
df[order(df$var3),] # we can also sort on characters or factors
df[order(df$var3,df$var2),] # sorted by var3 and then var2


## ----useful_functions.subset, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-------------

df<-data.frame(sex=factor(c("male","male","female","female","female","female")),
               age=c(25,42,38,39,44,24),height=c(172,184,177,152,171,180))
df
df[df$sex=="female" & df$age<40 & df$height>175,] 



## ----useful_functions.missing.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------
v1<-df$sex=="female"
v2<-df$age<40
v3<-df$height>175
vall<-v1 & v2 & v3
data.frame(v1,v2,v3,vall)
df[vall,]


## ----useful_functions.missing.2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------

df.missing<-data.frame(sex=factor(c("male","male",NA,"female","female","female")),
                       age=c(25,42,38,39,NA,24),height=c(172,NA,177,152,NA,180))
df.missing
# we now filter the data as above and get
df.missing[df.missing$sex=="female"  & df.missing$age<40 & df.missing$height>175,]  
df.missing[6,]  # this is probably what we actually wanted
df.missing$height
df.missing$sex    # missing (NA) is not seen as a factor level
# WARNING in the following example NA is interpreted as a text category
factor(c("male","male","NA","female","female","female")) 

v1<-df.missing$sex=="female"  # check the three conditions
v2<-df.missing$age<40
v3<-df.missing$height>175
vall<-v1 & v2 & v3
data.frame(sex=v1,age=v2,height=v3,total=vall)  # vall = all conditions fulfilled
df.missing[vall,] # the same as we got above
# also rows where the logical expression cannot be evaluated (NA) are included
nrow(df.missing[vall,]) 


## ----useful_functions.missing.2a, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------
is.na(df.missing$sex)   # check if missing
!is.na(df.missing$sex)  # not missing
df.missing[df.missing$sex=="female" ,] 
df.missing[df.missing$sex=="female" & !is.na(df.missing$sex) ,] # this is better, 

# To make a correct selection to avoid problems with missing data 
df.missing[df.missing$sex=="female" & !is.na(df.missing$sex) & df.missing$age<40 &
             !is.na(df.missing$age)& df.missing$height>175& !is.na(df.missing$height),]  


## ----useful_functions.missing.2b, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------
df.missing
# This is a function that make things easier
# Here is a difference - missing values are taken as false
subset(df.missing,sex=="female" & age<40 & height>175)

# subset also makes the filtering easier since you don't have to 
# repeat the name of the data frame
# which is especially helpful if it has a long name

dataframe.with.a.long.name<-df.missing # No missing here
dataframe.with.a.long.name[dataframe.with.a.long.name$sex=="female" &                              !is.na(dataframe.with.a.long.name$sex) & 
        dataframe.with.a.long.name$age<40 &
             !is.na(dataframe.with.a.long.name$age) &
        dataframe.with.a.long.name$height>175 &
        !is.na(dataframe.with.a.long.name$height),]

subset(dataframe.with.a.long.name,sex=="female" & age<40 & height>175)

# You may want to remove all missing, so called removing listwise 
df.clean<-na.omit(df.missing)
df.clean
df.clean[df.clean$sex=="female"  & df.clean$age<40 & df.clean$height>175,]  


## ----useful_functions.missing.3, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------

#
x<-c(1,3,5,NA,7,5,14,NA,6)
x
sum(x) #does not work
sum(x,na.rm=T) # this works
mean(x)
mean(x,na.rm=T)


## ----useful_functions.missing.4, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------
set.seed(221)
df<-data.frame(size=sample(c("big","small"),size=20,replace=T),
               time=sample(c("before","middle","after"),size=20,replace=T))
dfm<-df
dfm[c(6,16),1]<-NA
dfm[c(4),2]<-NA
dfm           # dfm has 3 missing
table(df$time,df$size)
table(dfm$time,dfm$size)  # we cannot see in the table that we have missing data 
table(dfm$time,dfm$size,useNA = "ifany")
xtabs(~time+size,data=dfm,addNA = T)


## ----useful_functions.cut.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT--------------
x<-seq(0,10)
x
gr<-cut(x,breaks=c(0,2,5,Inf))

gr
class(gr)
summary(gr)   # similar as table() for factors

gr.lab<-cut(x,breaks=c(0,2,5,Inf),labels=c("small","medium","large"))
gr.lab

summary(gr.lab)

table(gr.lab,useNA="ifany") # alt for table
xtabs(~gr.lab,addNA=T)      # alt for xtabs


## ----useful_functions.apply.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------
x<-data.frame(bmi.gr1=c(21.6,24.3,29.2,26.1,23.6),bmi.gr2=c(26.7,28.3,25.2,28.1,27.1),
              bmi.gr3=c(24.3,23.2,24.8,23.5,25.0))
x
apply(x,1,mean)   # mean by row
apply(x,2,mean)   # mean by column (variable names are kept)

apply(x,2,sd)

apply(x,2,sort)   # the function does not need to produce one numeric result


## ----useful_functions.apply.2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------
library(haven)
norsjo86 <- read_sav("../data/norsjo86.sav")
norsjo86<-as.data.frame(norsjo86)
tapply(norsjo86$height,INDEX=list(factor(norsjo86$sex)),FUN=max,na.rm=T)

tapply(norsjo86$sbp,INDEX=list(factor(norsjo86$sex),factor(norsjo86$agegrp)),
       FUN=mean,na.rm=T)


## ----useful_functions.head.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-------------
x<-data.frame(x=seq(1,10,length.out=4000),y=seq(-628,10,length.out=4000),
              z=seq(0,180,length.out=4000))
nrow(x)
head(x)
tail(x,10)

