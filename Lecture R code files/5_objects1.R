## ----objects1.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------


4+13


21-4

21-(-4)

5*7

-3/2

5^2 # 5 squared
5**2


2^4 # ^ is the power function 

9^0.5 # the square root

sqrt(9) # the specific function for square root 
        # (more about functions later)

2^(-2) # 1/(2*2)

x<-5
x

Important.Number<-14
Important.Number

x*Important.Number

Important.Number/x

x<-2    # it is easy to change x
1/x+1/x^2+1/x^3+1/x^4+1/x^5


## ----objects1.2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------

x<-c(2,4,6)
x
x[2]

2*x

y<-x*x
y

x^2

z<-(x+y)/2
z

z<-c(z,x,3,14)
z

xi<-5:12  # to generate a sequence
xi


## ----objects1.3, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------
x<-c(2,4,6)
typeof(x) # real numbers
class(x)
str(x)    # decribe the object


## ----objects1.4, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------
x<-c(2,4,6)
y<-as.integer(x)
x
y
typeof(x)
class(x)
typeof(y) #even if you cannot see the difference x and y have different type
class(y)


## ----objects1.5, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------
z1<-c(TRUE,FALSE,TRUE) 
z1
typeof(z1) # this is an important type in R
class(z1)

z2<-c(T,F,T) # the same as z1
z2
z2 == 0

z2 == 1
z2 == TRUE

z2 == 2

y<-z1*1 # converting logical to a so called dummy variable
y

5<7                           # The result is logical
x<-c(5<7,5>7,2==2)            # "==" means equal to
x

# some more examples (!= means not equal to)
x<-c(5>5, 5>=5,3!=5,4!=4) 
x
!x


## ----objects1.6, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------
x<-"b"
x
y<-"R-object"
y
x<-c(x,y,"c","another phrase",1)
x==1
x=="1"

typeof(x)
class(x)


## ----objects1.6b, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT--------------------
x<-c(2,4,7,13,5,8)
x
y<-x[3]
y

# pass array of indexes to select
z<-x[c(1,4,6)]
z

# pass array of indexes to select, with duplicats
y2<-x[c(1,1,4,4,4,6,6,6,6,6)]
y2

z2<-x[-c(2,3,5)] # minus sign means exclusion of the elements
z2
x2<-x[c(T,F,F,T,F,T)] # you can also use a vector (of the same length) of logical elements 
x2


## ----objects1.6c, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT--------------------
paste("part one","part two") # one string
# Functions usually have arguments. For paste one argument is "sep"
paste("part one","part two",sep="")  # sep=" " is the default
paste0("part one","part two")  # alternative wrapper function with sep="" as the default

paste("part one","part two",sep=" | ")

x<-c(0.49,"Pearson's r")
x
paste("The result from the calcultaion of",x[2],"=",x[1])


## ----objects1.matrixes, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT--------------
x<-seq(1,16)
x
x2= 1:16
x2

x3 = c(1:16)
x3[3]

class(x)
class(x2)
class(x3)

y<-matrix(x,nrow=4)
y                    
typeof(y)
class(y)

z<-matrix(x,ncol=8)
z
z[1,4]
# data are stored by column


## ----objects1.7, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------
people <- c("Lena", "Solveig", "Anna", "Hans", "Erik" )
byear <-  c(1982,      1976,      1949,      2001,   1967)
score <-  c( 22,        43,        87,        45,     60)
salary <- c(40,         47,        31,        32,     45)
df <- data.frame(Name = people, BirthYear = byear, Score = score, Salary = salary)
# New variable names are given for the data frame
df

df$Sex<-c("woman","woman","woman","man","man")  # we can add a variable
df
typeof(df)
class(df)

# A matrix can be converted to a data frame
y
ydf<-data.frame(y)
ydf       # no names
names(ydf)<-c("first col","Var2","col 3","Var4")
ydf


## ----objects1.8, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT---------------------
df
df$BirthYear[3] # List form - 3rd row of column "BirthYear"
df$byear        # does not work
df[2,3]         # Matrix form - 2nd row of 3rd column
df[,3]          # Row number omitted, assume ALL rows i.e. this is equivalent to df$score
df[:,3]          # doesnt work
df[4:5,1:3]     # Selects the subset - rows 4 and 5, columns 1  to 3
df[,c(-1,-4)]          # omit 1st column
df[-3,c(-1,-4)]          # omit 1st and 4th column, omit 3rd row

df
df$Name
names(df)
[1:3,3]
df[5:1,]            # reverse order
df[5:1]

df[c(2,5,3,1,4),]   # specific order
df[c(5,1,2),]       # sorting and selection combined
df[c(1,2,3,2,3),]   # repeating rows 
df[,c(1,2,3,2,3)]   # also possible with columns
df[c(T,F,T,T,F),]   # selection due to logical vector of same length (nrow)


## ----objects1.10, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT--------------------
library(tibble)
df <- as_tibble(df)
df
class(df)
df <- as.data.frame(df)
class(df)
df

