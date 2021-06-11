## ----ie1,eval=EVAL----------------------------------------------------------------------
backpain_data <- read.csv("../data/BackPain.csv")


## ----ie2,eval=EVAL----------------------------------------------------------------------
write.csv(backpain_data, "../data/tmp_DifferentName.csv")


## ----ie3,eval=EVAL----------------------------------------------------------------------
library(readxl)
library(openxlsx)

# read first sheet - readingxl
packpain_data <- read_excel("../data/BackPain.xlsx", sheet = 1)

# write again - openxlsx
write.xlsx(x = packpain_data, file  = "../data/tmp_DifferentName.xlsx")


## ----ie4,eval=EVAL----------------------------------------------------------------------
library(haven)
aids <- read_dta("../data/Aids.dta") # read stata aids data 
write_dta(aids, "../data/tmp_Aids.dta") # write stata 

norsjo <- read_sav("../data/norsjo86.sav") # read spss save file
write_sav(norsjo, "../data/tmp_norsoj86") # write spss save


## ----ie5,eval = EVAL--------------------------------------------------------------------
data <- cars
var1 <- 42

# objects 
save(data,var1, file = "../data/tmp_current_environment.RData")

# specify list of object character names
save(list = c("data", "var1"), file = "../data/tmp_current_environment.RData")

# directly specify the objects
save(data, var1, file = "../data/tmp_current_environment.RData")


## ----ie6,eval=EVAL----------------------------------------------------------------------
load(file = "../data/tmp_current_environment.RData")


## ----ie7,eval=EVAL----------------------------------------------------------------------
# save and load single objects  
saveRDS(mtcars, file = "../data/tmp_data.rds")
readRDS(file = "../data/tmp_data.rds")

