rm(list=ls())

library(data.table)
library(dplyr)
library(readr)
library(stringi)
library(microbenchmark)

# purpose: 
# - present data.table
# - put data manipulation into perspective (different libraries), tidyverse vs data.table vs base

d_pop <- fread("C:/Users/meili/Downloads/population-figures-by-country-csv_csv.csv")
d <- fread("C:/Users/meili/Downloads/IMDb_movies.csv",encoding = 'UTF-8')


# d[i,j,by]
# selection, rows and columns
d[c(1,2,3),]
d[c(1,2,3)]

d[,title]
d$title

d[,"title"]
d[,c("title", "year")] # by names
cols = c("metascore", "language")
d[,..cols] # two dots in j to refer to variables in parent environment (but not in i)

d[, .SD, .SDcols = startsWith(names(d), "t")]
d[, .SD, .SDcols = names(d) %like% "title"]



d[,list(title,year)]
d[,.(title,year)] # shorthand for list

d[,.(Title2 = title, Year = year)] # Select and change name
d[,year:language] # range



# conditions
d[year == 1999, ]

# rename columsn
setnames(d, "original_title", "otitle")
setnames(d, c("otitle", "date_published"), c("original_title", "pubdate"))

# calculations inside []
d[, sum(duration)] # returns vector
d[, .("totalduration"=sum(duration))] # returns data.table


# # .N,, by
d[, .N, by = year]
d[, .N, by = .(year, country)]

d[, .N, by = .(country,year)] # group by multiple columns
d[, .N, keyby = .(country,year)] # sort automatically

# .SDcols, SD
d[, lapply(.SD, mean), by=year, .SDcol=c("votes", "duration")]

d[,.(meandur_se = mean(.SD[country=="Sweden",duration]), meandur_ge = mean(.SD[country=="Germany",duration])), 
  by=year]

d[, .("sval" = shift(duration, 1)+ shift(duration, 2), duration)]



# problem: normal datatables and dplyr can create multiple instance of the data (deep copy)
# data.table allows in-place memory operations using the := operator: data is not copied but relly updated!
# :=, single and multiple columns, ..  
d[, title_length:= nchar(title)]
d[, c("title_length", "n_actors") := .(nchar(title), stri_count_fixed(actors, ","))]

d[, `:=`(title_length = nchar(title), n_actors = stri_count_fixed(actors, ","))]

# add/update something per group
d[, n_year:= .N, by = year]

# delete 
d[, n_year := NULL]


dt = data.table(l = c("a", "b", "c" , "d"), nr = c(1,2,3,4))
dt[nr>2, l:="g"]

# get a data.table with a vector of all actors
t <- d[, .(sact = strsplit(actors, ",")[[1]])]

# get a data table with a vector of vectors of actors
t <- d[, .(sact = list(strsplit(actors, ",")[[1]])), by = imdb_title_id]


# rbindlist 
t1 <- d[year > 1950]
t2 <- d[year <= 1950]
t <- rbindlist(l = list(t1,t2))

# order/sort
d[order(year, -country), ]
setorder(d, -year, country)

# chaining
d[, .(num_per_year = .N), by = year][order(-num_per_year)]




# join
d[, `:=`(first_country = unlist((stri_split_fixed(country,", ", n=1, tokens_only = T))))]
t <- merge(d, d_pop, by.x = "first_country", by.y = "Country", all.x=T)

d_pop[,first_country:= Country]
t <- merge(d, d_pop, by= "first_country", all.x=T)


microbenchmark("data.table join" = { merge(d, d_pop, by= "first_country", all.x=T) }, 
               "dplyr join" = { d %>% right_join(d_pop, by= "first_country") }, times = 5)


n <- 5000000
d1 <- data.table(id = 1:n, v = sample(1:100, n, T))
d2 <- data.table(id = 1:n, v = sample(1:100, n, T))


setkey(d, "id") # d1[d2]
microbenchmark("data.table join" = { d1[d2, on="id"] }, 
               "dplyr join" = { d1 %>% inner_join(d1, by= "id") }, times = 5)



# wide to long, long to wide:  melt, dcast
dwide <- melt(d, id.vars = c("imdb_title_id"), variable.name = "property", value.name = "val")
dlong <- dcast(dwide, imdb_title_id ~  property , value.var = "val")


# wrap-up:
# dt vs dplyr
# approach: [] vs 'verbs'
# focus on flexibility ([]) vs focus on denoting operations  close to verbal language 
# inbuilt multithreading vs no 

# speed: little difference in normal-day datasets
# verbosity: data.table shorter vs dplyr explicit

# its even possible to use dplyr with a data.table in the background: https://github.com/tidyverse/dtplyr



# https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html
# https://atrebas.github.io/post/2019-03-03-datatable-dplyr/