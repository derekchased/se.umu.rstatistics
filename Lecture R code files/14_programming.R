## ----p0.1, eval=EVAL--------------------------------------------------------------------
x <- sample(1:3, 1)
print(x)
if(x == 1){
  print("x is 1")
}


## ----p0.2, eval=EVAL--------------------------------------------------------------------
if(x == 1){
  print("condition 1 is true, x is 1")
} else if(x == 2) { 
  print("condition 2 is true, x is 2")
} else{
  print("Condition 1 and 2 are not true, x must be 3") 
}


## ----p0.3,eval=F------------------------------------------------------------------------
## if(log(-1) > 0){
##   print("?")
## }
## 


## ----p1, eval=EVAL----------------------------------------------------------------------
x <- 10
while(x >= 5){
 print(x)
 x <- sample(1:10, 1)
}


## ----p2, eval=EVAL----------------------------------------------------------------------
for(i in 1:10){
  print(i)
}


## ----p3, eval=EVAL----------------------------------------------------------------------
v = sample(100, 1000000, replace = T)

startTime <- Sys.time() # save current time point
i <- 1 # i stands for index
cs <- 0 # cs: current sum, start with 0

# to get the total sum of v, we retrieve each element in the loop
# and add it to the current sum
while(i < length(v)){ # run until i >= length of v
  
  cs <- cs+v[i] # add the number at index i
  i <- i +1 # increase the index to progress
}
endTime <- Sys.time() # save the current time point

print(paste0("Sum is: ", cs)) # print the current sum (use paste0 to )
print(paste0("Time for while loop: ", round(endTime - startTime,3), " seconds"))

startTime <- Sys.time()
cs <- 0 # set cs to 0 again
for(i in v){ # in the for loop, we automatically get the next element i in  v
  cs <- cs+i # add i to current sum
}
endTime <- Sys.time()
print(paste0("Sum is: ", cs))
print(paste0("Time for for loop: ", round(endTime - startTime,3), " seconds"))

startTime <- Sys.time()
cs <- sum(v)
endTime <- Sys.time()
print(paste0("Sum is: ", cs))
print(paste0("Time for for sum: ", round(endTime - startTime,3), " seconds"))


## ----p4,eval=EVAL-----------------------------------------------------------------------

myFunction <- function(arg1, arg2){
  print("Hello, this is my function. The weighted sum of arguments is: ")
  print(arg1*2+arg2)
}


## ----p5, eavl=EVAL----------------------------------------------------------------------
number <- 4
myFunction(4,number)


## ----p6, eval=EVAL----------------------------------------------------------------------
number <- 4
myFunction2 <- function(number){
  number <- 5 # last used value will be returned (v)
}
print(myFunction2())
number # what is number?


## ----p6.1, eval=EVAL--------------------------------------------------------------------
afunction <- function(number){
  print("Hello")
}
bfunction <- afunction # use function as object
bfunction() # execute functions with ()


## ----p7, eval=EVAL----------------------------------------------------------------------
cfunction <- function(x){
  print(paste0("Value of x is: ", x))
}
sapply(1:3, cfunction) # pass funtion as an argument
sapply(1:3, function(x){ x }) # use anonymous function


## ----p8, eval=EVAL----------------------------------------------------------------------
myRetFunction <- function(){
  astring <- "blue"
  astring # return astring
}
color <- myRetFunction()
color


## ----p9,eval=EVAL-----------------------------------------------------------------------
lazySum <- function(x){
  # demonstrate explicit returns using return ()
  if(weekdays(Sys.time()) == "Sunday")
  {
    return("I dont work on Sundays")
  }
  else
  {
    return(sum(x))
  }
  
  "I don't know"
}


## ----p10, eval=EVAL---------------------------------------------------------------------
myFunction(arg2 = 2, arg1 = 1) # indicate arguments by name


## ----p11, eval=EVAL---------------------------------------------------------------------
# provide a default argument
myDefArgFunction <- function(arg1, arg2, arg3=2){
  print(sum(arg1+arg2+arg3)) 
}
myDefArgFunction(2, 3) # only needs two arguments


## ----p12, eval=EVAL---------------------------------------------------------------------
f <- function(){
  obj <- "object"
}
f()
print(obj)
# we get an error!


## ----p13, eval=EVAL---------------------------------------------------------------------
x <- 10
f <- function(){
  print(x)
}
f()


## ----p14, eval=EVAL---------------------------------------------------------------------
x <- 10
f <- function(){
  x <- 77
}
f()
x

