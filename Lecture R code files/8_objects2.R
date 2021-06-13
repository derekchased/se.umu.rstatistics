## ----objects2.factors, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------
x<-c(1,2,3,4,1,3)
x
str(x)

y<-as.factor(x)
str(y)

is.vector(x)
is.vector(y)
is.factor(x)
is.factor(y)

x<-factor(c("f","b","c","f","c","b","b")) # levels are stored in alphabetical order

x<-factor(c(1,7.1,"a","Low",14,1,"a","high","low",14,1,"Low"))
x
levels(x)   # if we only want the levels

x[c(2,4)]   # all levels are printed


## ----objects2.factors.2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-------
y<-relevel(x,ref="high")
y


## ----objects2.lists1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------
x1<-data.frame(measurement=c(12.7,6.4,5.7,14,2.5),
               gender=factor(c("male","male","female","male","female")))
x2<-c(2.5,14)
x3<-5
x4<-"This is the minimum and maximum values"

x1
typeof(x1)
str(x1)
is.list(x1)

y<-list(what=x4,min.max=x2,N=x3)
y
str(y)    # like a vector but elements of different type


## ----objects2.lists2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------
y$N
y[[2]]
y[2]

z<-list(oldlist=y,data=x1)
z
str(z)

z$oldlist 

z[[1]]              # same as z$oldlist

z$oldlist[2]        # second element

z[[1]][2]

z[[2]][,2]          # second column of the second list element


## ----dates.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=F--------
x.t<-Sys.time()
x.t
str(x.t) #returns an object of class "POSIXct"

x.d<-Sys.Date() 
x.d
str(x.d) # returns an object of class "Date"

format(x.d,format="%Y-%m-%d")

# some alternatives
format(x.d,format="%d-%m-%Y")
format(x.d,format="%Y/%m/%d")
format(x.d,format="%Y")

x<-c("2017,02,16")
x
x.d<-as.Date(x,format="%Y,%m,%d")
x.d
format(x.d,format="%m/%Y")

y<-c("20190414")
y.d<-as.Date(y,format="%Y%m%d")
y.d

y.d-x.d

as.numeric(y.d-x.d)/365.25  # difference in years

both<-c(x.d,y.d)
both
max(both)


## ----objects2.functions.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-----
x<-c(1,4,9,25,10,2)
length(x)
sqrt(x)
round(sqrt(x),2)
sort(x)
log(x)
sample(x,3)         # random sample from x
sample(x,10)        
# it does not work because default is without replacement 
# i.e. max sample size is length(x)  

sample(x,10,replace=TRUE)  # but this works (with replacement)


## ----objects2.library, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------
options()
options()$defaultPackages     # packages loaded by default
search()                      # all loaded packages

library(Epi)
search()
detach("package:Epi")  # remove a specific package/data base from the search path 
search()


## ----objects2.masking, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------
rm(list=ls())       # just for cleaning up a little

x<-9
sqrt(x)             # square root of x

sqrt<-log
log(9)
sqrt(9)
ls()                # ls() list the objects in work space

sqrt(x)             # sqrt now is the log function

base::sqrt(x)       # the solution if we have masking

rm(sqrt)
ls()

sqrt(x)             # not masked anymore

