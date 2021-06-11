## ----tabulation1,warning=F--------------------------------------------------------------
d <- read.csv("../data/BackPain.csv")


## ----t1_1way, eval=EVAL-----------------------------------------------------------------
table(d$sex)


## ----t2_1wayx, eval=EVAL----------------------------------------------------------------
xtabs(~sex, d)


## ----t2_2way, eval=EVAL-----------------------------------------------------------------
xtabs(~sex+asthma, d) # two way with sex and asthma


## ----t3_summary, eval=EVAL--------------------------------------------------------------
summary(xtabs(~sex+asthma+age, d, exclude = ""))    # calculate chi square statistics


## ----t3_round, eval=EVAL----------------------------------------------------------------
# report proportions instead of frequencies
round(prop.table(xtabs(~sex+asthma, d, exclude = "")),2) 

# gives percentages
round(prop.table(xtabs(~sex+asthma, d, exclude = "")),2)*100 


## ----t4_addmargins, eval=EVAL-----------------------------------------------------------
addmargins(xtabs(~sex+asthma, d, exclude = "")) # add both row and column totals


## ----t5_3waytable,eval=EVAL-------------------------------------------------------------
xtabs(~sex+asthma+diabetes, d)


## ----t5_3waytable_wrapped,eval=EVAL-----------------------------------------------------
ftable(xtabs(~sex+asthma+wealthQ,d))


## ----3waytable_ftable-------------------------------------------------------------------
ftable(sex+asthma~wealthQ+diabetes,d)

