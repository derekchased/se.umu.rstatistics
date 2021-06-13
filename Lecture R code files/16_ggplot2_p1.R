## ----f1, eval=EVAL----------------------------------------------------------------------
library(ggplot2)
d <- read.csv("../data/BackPain.csv")

ggplot(data = d, mapping= aes(y = bmi))+ 
  geom_boxplot(na.rm = T) # boxplot, remove bmi values that are NA


## ----f2, eval=EVAL----------------------------------------------------------------------
# complains about binwidth
ggplot(data = d, mapping= aes(x = bmi))+ 
  geom_histogram(na.rm = T)


## ----f3, eval=EVAL----------------------------------------------------------------------
# manually define color and set number of bins
ggplot(data = d, mapping= aes(x = bmi))+ 
  geom_histogram(na.rm = T, bins = 50, fill = "steelblue") 


## ----f4, eval=EVAL, echo = F------------------------------------------------------------
ggplot(data = d, mapping= aes(x = bmi))+ 
  geom_density(na.rm = T, fill = "green", alpha = 0.3)


## ----f5, eval=EVAL----------------------------------------------------------------------
# A barplot and how to set a plot title
ggplot(data = d[d$asthma != "",], mapping= aes(x = sex, fill = asthma))+ 
  geom_bar(na.rm = T) +
  ggtitle("Sex versus asthma")


## ----f6, eval=EVAL----------------------------------------------------------------------

ds = d[,c("age", "bmi", "waistc", "height", "sex")] # the columns we want to work with
ds$weight <- ds$bmi * (ds$height/100)^2 # recover weight value using the BMI formula
ds <- ds[complete.cases(ds),] # get rid of rows with any NA


## ----f7, eval=EVAL, warning = F,dev='cairo_pdf'-----------------------------------------
# A points or scatterplot with the 'minimal' theme
ggplot(aes(x = waistc, y = bmi), data = ds)+
  geom_point(alpha = 0.3)+
  theme_minimal()


## ----f8, eval=EVAL, warning = F,dev='cairo_pdf'-----------------------------------------
da = aggregate(bmi ~ age, ds, mean) # mean of bmi by age (mean function passed as object)
gg = ggplot(aes(x=age, y = bmi), data = da)+
  geom_line() # line plot

# only now plot the plot and apply the theme
gg +  theme_minimal()


## ----f9, eval=EVAL, warning = F,dev='cairo_pdf'-----------------------------------------
# calculate mean weight for every age
da2 = aggregate(weight ~ age+sex, ds, mean)

# add a new line based on the new data to the old plot
gg+geom_line(aes(x = age, y = weight), data = da2)+
   theme_light()


## ----f10, eval=EVAL, fig.width=5--------------------------------------------------------

# restrict x axis and set manual axis labels using scales
gg + scale_x_continuous(breaks = c(50,60,70,80), 
                        labels = c("Midd life", "Late adulthood", 
                                   "Early retirement", "Late retirement"),
                        limits = c(50, 80),
                        name = "Age stages")+
     scale_y_continuous(limits = c(20,30), 
                        position = "right",
                        name = "Body Mass Index") +
     theme_minimal()


## ----f105, eval=EVAL--------------------------------------------------------------------

# only display two levels of categorical data
ggplot(data=d, mapping=aes(x=wealthQ))+
  geom_bar()+ 
  scale_x_discrete(limits=c("Q3","Q2"))


## ----f11, eval=EVAL---------------------------------------------------------------------

# use a different color palette by altering the fill scale
ggplot(data = d[d$asthma != "",], mapping= aes(x = sex, fill = asthma))+
  geom_bar(na.rm = T)+
  scale_fill_brewer(type="qual", palette = 2)+
  theme_minimal()


## ----f12, eval=EVAL, warning=WARNING----------------------------------------------------

# an example using guides to change the legend title
ggplot(data = d[d$asthma != "",], mapping= aes(x = sex, fill = asthma))+
  geom_bar(na.rm = T)+
  scale_fill_brewer(type="qual", palette = 2)+
  guides(fill = guide_legend(title = "Asthma status", direction = "horizontal"))+
  theme_minimal()+
  theme(legend.position = "bottom")

