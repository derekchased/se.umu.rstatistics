## ----matrix.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-----------------------
m<-matrix(1:10,nrow=4)
m
class(m)
as.data.frame(m)


## ----matrix.2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-----------------------
# we can define a matrix of characters but it is not so useful for calculations
matrix(letters[1:8],ncol=2)
m1<-matrix(1:12,nrow=4)
m1
nrow(m1)
ncol(m1)
dim(m1)

m2<-m1[2:4,]  # row 2-4 of m2
# specifying rows and columns work like as for a data frame
m2
dim(m2)


## ----matrix.3, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-----------------------
m1<-matrix(1:12,nrow=4)
m1
dim(m1)
t(m1) # this is the transpose of the matrix
dim(t(m1))

m2<-matrix(11:25,nrow=3)
m2
dim(m2)

m1+m1 # the numer of rows and column must match
m1+m2  # this does not work

3*m2

m1%*%m2   # the product of two matrixes

m1[3,]
m2[,2]
sum(m1[3,]*m2[,2])  # the element in row 3 column 2 of the product m1%*%m2
(m1%*%m2)[3,2]

m2%*%m1   



## ----matrix.4, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-----------------------
A<-matrix(c(1,2,3,-1),nrow=2)
A
b<-matrix(c(4,3),nrow=2)
b


## ----matrix.4b, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------------------
Am1<-solve(A)
Am1

Am1%*%b     # this is the straightforward solution

X<-solve(A,b)  # this is the recommended solution
X


## ----matrix.4c, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT----------------------
A%*%X   

round(Am1%*%A,10)  # The identity matrix
diag(2)   # it can easily be generated
diag(10)


## ----matrix.5, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-----------------------
x<-array(1,dim=c(3,3))
x
class(x)
y<-array(1:18,dim=c(3,3,2))
y
class(y)
dim(x)
dim(y)
y[,,1]
y[,,2]
y[1,,2]   # the first dimension=1 (first row) and third dimension=2 
is.vector(y[1,,2])


## ----matrix.6, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT-----------------------
# import spss file norsjo86
library(haven)
norsjo86 <- read_sav("../data/norsjo86.sav")
head(norsjo86,3)

xtabs(~sex+agegrp,data=norsjo86)

tab<-xtabs(~sex+agegrp+smoker,data=norsjo86)

tab
is.array(tab)
tab[,2,]    # gives the table for 40 year 

