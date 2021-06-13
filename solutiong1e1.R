
rm(list=ls())
getwd()

#Step 1 : Importing Data and creating a data frame
library(haven)  # NOTE - Unnecessary. This is for different formats to csv

data <- read.csv(file = 'data/df.gr1.csv') 

df <- data.frame(data)  # NOTE - Unnecessary. This is already a dataframe object. Alternative, save it as a tibble

#Step 2 : Describe the data as it is using descriptive statistics measures and graphics. 
summary(df)   # NOTE - Is this sufficient for this exercise? Need some graphics, which ones?

#Step 3: cleaning the data 
df_clean<-na.omit(df)   # NOTE - Should we check for empty string as well

#Step 4: 
Weight = df_clean$bmi * (df_clean$height/100)^2
df_clean$weight <- Weight

#Step 5: Describe the data again

summary(df_clean)

#Step 6: 
#Shoe Size: Normally distributed
hist(df_clean$shoesize)
range(df_clean$shoesize)
hist(df_clean$shoesize, breaks=seq(18,56,by=1),col=3,density=30, xlab="Size",main="Histogram of Shoe Size")
boxplot(df_clean$shoesize)

#Income: Distribution is skewed to left
#Changing negative values to 0 in income
df_clean$income[df_clean$income < 0] <- 0 
hist(df_clean$income)
range(df_clean$income)
hist(df_clean$income, breaks=seq(0,1500000,by=1000),col=1,density=50, xlab="Income",main="Histogram of Income distribution")
boxplot(df_clean$income)

#Age : Distribution is skewed the left
hist(df_clean$age)
range(df_clean$age)
hist(df_clean$age, breaks=seq(0,170,by=2),col=1,density=10, xlab="Age",main="Histogram of Age distribution")
boxplot(df_clean$age)

#Step 7: Relationship between height and shoe size

plot(df_clean$height, df_clean$shoesize)

#Step 8: Relationship between alcohol and depression
plot(df_clean$alcohol)
plot(df_clean$depression)
plot(df_clean$depression, df_clean$alcohol)
plot(df_clean$alcohol, df_clean$depression)
