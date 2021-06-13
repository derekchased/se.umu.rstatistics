## ----dplyr.1,warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE-----------
BackPain<-read_csv("../data/BackPain.csv") # The resulting object is a tibble
BackPain

set.seed(1001)
bP<-BackPain[sample(nrow(BackPain),10000),] # let us take a subsample 
tibble::glimpse(bP) # this is a way of getting an overview of all variables


## ----L3Preliminaries1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------
bP <- mutate_if(bP,is.character, as.factor)
head(bP)


## ----L3SelectNames,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-----------------
bPs <- select(bP,country, residence, sex, height, disability, diabetes)
head(bPs)


## ----L3SelectNumber,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------------
bPs <- select(bP, 1:4)
kable(head(bPs))


## ----L3SelectDelete,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------------
bPs <- select(bP, -c(sex,age))

head(bPs)



## ----L3DeleteNum,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-------------------
bPs <- select(bP, -(3:4))
head(bPs)


## ----L3Filter,warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------------------
bPf <- filter(bP, country == 'China' ,
               residence == 'Rural', sex=='Female')
bPf


## ----L3Filter2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------------------
bPnf <-  select(bP,bmi,waistc,age, height)   
summary(bPnf)
bPf <-  filter(bPnf,complete.cases(bmi,waistc,age)) # data are now also complete in bmi and waistc 
# complete.cases operate on variables while omit.na operates on a data frame
summary(bPf)


## ----L3Slice,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-----------------------
bPs5 <- slice(bP, 1:5)
bPs5
bPs10 <- slice(bP,seq(1,nrow(bP), by =10))  # Select every 10th observation
head(bPs10)


## ----L3arrange,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------
bPa <- arrange(bP,waistc)
head(select(bPa,residence,sex,waistc,age,wealthQ),10)   # default is ascending order


## ----L3Descending,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------------
bPa <- arrange(bP,desc(waistc),age)
head(select(bPa,residence,sex,waistc,age,wealthQ),10) 


## ----L3rename,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------------------
bPr <- rename(bP, wealthQuantile = wealthQ)  # New name = old name
head(bPr)


## ----L3Mutate,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------------------
bPm <- mutate(bP, heightInches = height/2.54)
head(select(bPm,residence,sex,age,waistc,height,heightInches))


## ----L3MutateMany, warning =WARN, eval = EVAL-------------------------------------------
bPm <- mutate(bP, heightM = height/100,
               wHr = waistc/height,
               sAge = age-50)
select(bPm, residence,sex,age,height,waistc, heightM, wHr, sAge)


## ----L3count1,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------------------
count(bP,wealthQ)

bPc <- count(bP,country, residence, wealthQ)     
bPc


## ----L3count2,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------------------
summary(select(bP, residence, country, agegr,age))


## ----L3pipes.1,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------
bP %>% select(age,sex,wealthQ,physical,bmi) %>% head(4)


## ----L3pipes.2,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------
bPp<-bP %>% select(age,sex,wealthQ,physical,bmi)  %>% 
  filter(sex=="Female",age<60) %>%   arrange(bmi)
bPp

bPp<-bP  %>% filter(sex=="Female",age<60) %>%  
  mutate(bmi2=cut(bmi,c(0,20,30,Inf))) %>% count(bmi2)
bPp

bPp<-bP %>%  filter(sex=="Female",age<60) %>% 
  mutate(bmi2=cut(bmi,c(0,20,30,Inf)),agesq=age^2) %>% slice(1:5) %>%  
  select(-c(5,7:11,13:24))
bPp


## ----L2Factors1,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT--------------------
levels(bP$country)       
str(select(bP, country) ) 

bP %>% select(country) %>% mutate(numeric.country=as.numeric(country)) %>% slice(1:5)
  # print numeric values of first 5 elements


## ----L3Mutate2factor0, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------
bP %>% select(comorb) %>% str()
bP %>% select(comorb) %>% mutate(comorb=as.factor(comorb)) %>% str()


## ----L3MutateRecode,warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------------
bPm<-bP %>% mutate(comorb2=as.factor(comorb))%>% 
  mutate(comorb3 = fct_recode(comorb2,"None" = "0","One" = "1","Two or more"= "2"))
bPm %>% select(comorb,comorb2,comorb3) %>% slice(1:5)


## ----L3Factors3, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------
bP %>% count(country) 
bPr <- bP %>% 
  mutate(country = fct_recode(country,
                              "Russian Fed" = "Russian Federation",
                              "Sth Africa" = "South Africa") )
bPr %>% count(country)


## ----L3FActors1,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT--------------------
levels(bP$bmi4)
 bPm <- bP %>%  mutate(bmi4 = fct_relevel(bmi4, "Underweight","Normal", "Pre-Obese", "Obese"))
 levels(bPm$bmi4)


## ----L2cut, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT--------------------------
bP %>% mutate(height6 =  cut_number(height, n = 6)) %>% count(height6)


## ----L3Height4cutInterval,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------
bPc4<-bP %>% mutate(height4 = cut_interval(height, n=4)) 
bPc4 %>% count(height4)  


## ----L3cutwidth,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT--------------------
bPc <- bP %>% mutate(height4 = cut_width(height, width = 20)) 
summary(bPc$height4)


## ----Lecture3BreaksCut,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-------------
bPc <- bP %>% mutate(height4 = cut(height, breaks = c(0,120,150,170,Inf)))
summary(bPc$height4)   

bPc <- bP %>% mutate(height4 = cut(height, breaks = c(0,120,150,170,Inf),
                  labels = c("Very Short", "Short", "Average", "Tall" )))
bPc %>% count(height4)

bPc %>% mutate(height4=fct_explicit_na(height4, na_level = "(Missing)"))  %>% count(height4)


## ----L2CombiningLevels, warning=WARN, eval  = EVAL--------------------------------------
bPc6<-bP %>% mutate(height6 =  cut_number(height, n = 6,
labels = c("Very Short", "Short", "Average", "Tall", "Very Tall", "Extremely Tall")))

summary(bPc6$height6)

bP64 <- bPc6 %>%  mutate(h6_to_4 = fct_recode(height6,
                                          "short" = "Very Short",
                                          "short" = "Short",
                                          "very tall" = "Very Tall",
                                          "very tall" = "Extremely Tall"))
xtabs(~h6_to_4+height6,data=bP64)


## ----L3Piping1,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------
bPs <- bP %>%
  group_by(residence) %>%
  summarise(mean.disability = mean(disability))
bPs


## ----L3Piping2,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------
bPs <- bP %>% group_by(country,residence, sex) %>% 
  summarise(mean.disability = mean(disability), disIQR = IQR(disability),
  Bmi = mean(bmi,na.rm=T))
bPs


## ----L3Piping4,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------
bPs <- bP %>% group_by(sex,country,residence) %>% 
  summarise(mean.disability = mean(disability), disIQR = IQR(disability), Bmi = mean(bmi,na.rm=T))
bPs


## ----L3pipe5,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-----------------------
bPs <- bP %>%
  filter(country== "China")%>%
  group_by(sex,residence) %>%
  summarise(mean.disability = mean(disability), disIQR = IQR(disability), 
  Bmi = mean (bmi,na.rm=T))
bPs



## ----L3observation_counts1,  warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------
bPs <- group_by(bP, country, sex, residence, wealthQ) %>% 
  summarise( count=n(), mean.disability=mean(disability))
bPs


## ----L5toy2,  warning=WARN , eval =  EVAL-----------------------------------------------
ID <- 1:15
hhID <- c(1,1,1,1,1,2,2,3,3,3,4,4,4,4,4)
iData1 <- LETTERS[1:15]
iData2 <- letters[12:26]

iDf <- data.frame(id = as.factor(ID),
                  hhID = as.factor(hhID),
                  iD1 = iData1,
                  iD2 = iData2)
iDf

hhID <- 1:4
hData1 <- c("X1", "X2", "X3", "X4")
hData2 <- letters[5:8]
hhDf <- data.frame(hhID = as.factor(hhID),
                   hD1 = hData1,
                   hD2 = hData2)
hhDf


## ----L3MergeWithLeftJoin,  warning=WARN , eval =  EVAL----------------------------------
merged <- left_join(iDf, hhDf, by="hhID")
merged


## ----tidyr_funktions.wide, warning=WARN, eval=EVAL, echo=FALSE,comment=COMMENT----------
library(tidyr)

print("Wide format")
xwide<-data.frame(area=c(1:3),method1=c(210,135,187),method2=c(242,135,201),method3=c(207,111,214))
xwide


## ----tidyr_funktions.long, warning=WARN, eval=EVAL, echo=FALSE,comment=COMMENT----------
print("Long format")
names(xwide)[2:4]<-1:3
xlong<- xwide %>% gather(key=method,value=volume,-area)
xlong


## ----tidyr_funktions.ex2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT------------
xwide<-data.frame(area=c(1:3),method1=c(210,135,187),method2=c(242,135,201),
                  method3=c(207,111,214))
xwide

xlong<-xwide %>% gather(key=method,value=volume,method1,method2,method3)
xlong

xlong2<-xwide %>% gather(key=method,value=volume,-area) 
    # Alternative for the same result, all variables stacked except area

xlong %>% spread(key=method,value=volume)


## ----tidyr_funktions.subliminal, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-----
library(haven)
Subliminal <- read_sav("../data/Subliminal.sav")

sub<-Subliminal %>% cbind(ind.nr=1:nrow(Subliminal)) # add individual number
sub %>% slice(1:5)
nrow(sub)

sub_lf<-sub %>% gather(key=Time,value=Result,Before,After)
sub_lf %>% arrange(ind.nr) %>% filter(ind.nr<=5)
nrow(sub_lf)
  
sub_wf<-sub_lf %>% spread(key=Time,value=Result) %>% arrange(ind.nr)

head(sub_wf)
nrow(sub_wf)


## ----tidyr_funktions.bp, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE----
bPg<- bP %>% gather(key=var,value=value,disability,bmi,age)
bPg %>% count(var)

# the first three rows in each group
bPg %>% group_by(var) %>% select(var,value,residence,sex,wealthQ,physical,country) %>% slice(1:3) 


