## ----ggplot2.1, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE--------
library(readr)
BackPain<-read_csv("../data/BackPain.csv") # The resulting object is a tibble

# remove missing data in some variables
bp<-BackPain %>% filter(complete.cases(bmi,residence,physical,waistc,height))
 
set.seed(1001)
bp<-bp[sample(nrow(bp),10000),]
bp

p<-ggplot(bp,aes(y=disability,x=age))
p1<-p+geom_point(size=0.7)  
# Not informative with integer or lattice data. There are points at the same position. 
p2<-p+geom_jitter(height=0.5,width=0.5,size=1,shape=21)  # Better


## ----fig_gg2.1,echo=F,fig.width=12,fig.height=6,out.width="100%",fig.align="center"-----
grid.arrange(p1,p2,nrow=1) # similar as par(mfrow=c(1,2))


## ----ggplot2.2, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE--------
library(haven)
norsjo86 <- read_sav("../data/norsjo86.sav")

norsjo86<- norsjo86 %>% filter(complete.cases(sbp,bmi,cholesterol))
names(norsjo)[names(norsjo) == "kolester"] <- "cholesterol" # rename
norsjo86


## ----ggplot2.3, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE--------
gr1<-norsjo86 %>% filter(sex==1 & smoker==0)
gr2<-norsjo86 %>% filter(sex==2 & smoker==1)

p1<-ggplot(gr1,aes(y=sbp,x=bmi))+
   geom_point(size=1.5,color="blue")+
   geom_smooth(method=lm,se=F,color="blue")+
   labs(title="Non-smoking men (p1)")

p2<-p1+geom_point(data=gr2,size=1.5,color="red")+
   geom_smooth(data=gr2,method=lm,se=F,color="red")+ 
   labs(title="Smoking women (red) and non-smoking men ( blue) (p2)")


## ----fig_gg2.2,echo=F,fig.width=12,fig.height=8,out.width="100%",fig.align="center"-----
grid.arrange(p1,p2,nrow=1)


## ----ggplot2.4, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE--------
p<-ggplot(bp,aes(x=bmi))
p1<-p+geom_histogram(binwidth=1,colour="black",fill="red",alpha=0.4) # alpha=1 is full color 

p2<-p+geom_histogram(aes(fill=sex),binwidth=1,colour="black",alpha=1)


## ----fig_gg2.3,echo=F,fig.width=12,fig.height=6,out.width="100%",fig.align="center"-----
grid.arrange(p1,p2,nrow=1)


## ----ggplot2.5, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE--------
p<-ggplot(bp,aes(x=country,y=bmi))
p1<-p+geom_boxplot(colour="blue",size=0.5)+ # size=thickness of box lines
    labs(title="p1") 
p2<-p+geom_boxplot(aes(fill=sex)) +
   labs(title="p2") 
p3<-p+geom_boxplot(aes(fill=agegr),alpha=0.8)+
   labs(title="p3") 
p4<-p+geom_boxplot(aes(color=agegr))+
   labs(title="p4") 


## ----fig_gg2.4,echo=F,fig.width=12,fig.height=8,out.width="100%",fig.align="center"-----
grid.arrange(p1,p2,p3,p4,nrow=2)


## ----ggplot2.7, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE--------
norsjo86<-norsjo86 %>% mutate(Sex=as_factor(sex))

p<-ggplot(norsjo86,aes(y=sbp,x=bmi,shape=Sex))
#p<-ggplot(norsjo86,aes(y=sbp,x=bmi,shape=as_factor(sex))) 
#this alternative works but does not look as good
p1<-p+geom_point(size=1.5,aes(color=Sex))+
    labs(title="p1") 
p2<-p+geom_point(aes(size=cholesterol/2))+
 labs(title="p2") 
p3<-p+geom_point(shape=21,colour="black",fill="red",aes(size=cholesterol/2,stroke=bmi/10))+
     labs(title="p3") 
# we can add regression lines
p4<-p1+geom_smooth(method=lm,color="black",linetype=2,se=F,aes(color=Sex))+
 labs(title="p4") 


## ----fig_gg2.6,echo=F,fig.width=12,fig.height=8,out.width="100%",fig.align="center"-----
grid.arrange(p1,p2,p3,p4,nrow=2)


## ----ggplot2.8, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE--------
norsjo86<-norsjo86 %>% mutate(sex=factor(sex,labels=c("men","women")),
                              age=as.double(agegrp))
nor.sum<-norsjo86 %>% group_by(age,sex) %>% 
   summarise(mean.sbp=mean(sbp),min.sbp=min(sbp),max.sbp=max(sbp))
nor.sum                              

p1<-ggplot(nor.sum,aes(y=mean.sbp,x=age,shape=sex))+
   geom_line(aes(linetype=sex),size=1)+
   geom_point(size=2)+
   labs(y="Mean systolic blood pressure")+
   labs(title="p1")

p2<-p1+geom_point(aes(y=max.sbp),color="black",size=2)+
   geom_line(aes(y=max.sbp,linetype=sex),size=1)+
   geom_point(aes(y=min.sbp),color="black",size=2)+
    geom_line(aes(y=min.sbp,linetype=sex),size=1)+
   labs(y="Systolic blood pressure",title="Mean, maximum and minimum systolic blood pressure",subtitle="by sex and age (p2)")

p3<-p1+geom_point(color="black")+
   geom_text(aes(y=min.sbp,color=sex),label="Min",size=3)+
   geom_label(aes(y=max.sbp,color=sex),label="Max",size=3)+
   labs(title="p3")
# label can also be a vector with length=nrow(data.frame)  


## ----fig_gg2.7,echo=F,fig.width=10.2,fig.height=6,out.width="100%",fig.align="center"----
grid.arrange(p1,p2,p3,nrow=2)


## ----ggplot2.6, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE--------
p<-ggplot(bp,aes(x=interaction(sex,residence),y=bmi))
p1<-p+geom_boxplot(colour="black",size=0.5)+
    labs(title="p1") 
p2<-p+geom_boxplot(size=0.5,aes(fill=sex))+
    labs(title="p2") 
p3<-p+geom_boxplot(colour="blue",size=0.5,aes(fill=interaction(sex,residence)))+
    labs(title="p3") 
p<-ggplot(bp,aes(x=agegr,y=bmi))
p4<-p+geom_boxplot(colour="blue",size=0.5,aes(fill=interaction(sex,residence)))+
    labs(title="p4") 


## ----fig_gg2.5,echo=F,fig.width=12,fig.height=6,out.width="100%",fig.align="center"-----
grid.arrange(p1,p2,p3,p4,nrow=2)


## ----ggplot2.9, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE--------
p<-ggplot(norsjo86,aes(y=sbp,x=bmi))+
geom_point(size=1.5)
p1<-p+facet_grid(.~as_factor(sex))
p2<-p+facet_grid(as_factor(sex)~agegrp)


## ----fig_gg2.8,echo=ECHO,fig.width=12,fig.height=6,out.width="100%",out.height="35%",fig.align="center"----
p1


## ----fig_gg2.9,echo=ECHO,fig.width=12,fig.height=8,out.width="100%",fig.align="center"----
p2


## ----ggplot2.10, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE-------
p<-ggplot(norsjo86,aes(y=sbp,x=bmi))+
geom_point(size=1.5)+
facet_grid(as_factor(sex)~agegrp)   

ps1<-p+geom_smooth(method=lm,se=T)+ # Add smoothing with linear regression
labs(title="ps1")
ps2<-p+geom_smooth(se=F)+ # by default it is smoothed using loess
labs(title="ps2")
ps3<-p+geom_smooth(se=F,span=0.4)+  # less stiff
labs(title="ps3")
ps4<-p+geom_smooth(se=F,span=10,color="black")+ # more stiff
labs(title="ps4")


## ----fig_gg2.10,echo=F,fig.width=12,fig.height=8,out.width="100%",fig.align="center"----
grid.arrange(ps1,ps2,ps3,ps4,nrow=2)


## ----ggplot2.11, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE-------
p<-ggplot(norsjo86,aes(y=sbp,x=bmi))+
  facet_grid(as_factor(sex)~agegrp)
pf1<-p+geom_point(size=2,shape=21,aes(fill=as_factor(smoker)))+
   labs(title="pf1")
pf2<-p+geom_point(size=2,aes(color=cut(cholesterol,c(0,6,100)),shape=as_factor(smoker)))+
   labs(title="pf2")


## ----fig_gg2.11,echo=F,fig.width=12,fig.height=8,out.width="100%",fig.align="center"----
grid.arrange(pf1,pf2,nrow=2)


## ----ggplot2.12, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE-------
bp.lf<- bp %>% gather(key=var,value=value,sex,agegr) 

bp.lf %>% select(id,disability, residence,country,var,value) %>% head(5)
bp.lf %>% select(id,disability, residence,country,var,value) %>% tail(5)
table(bp.lf$var)

pb1<-ggplot(bp.lf,aes(y=disability,x=value,fill=var))+
geom_boxplot(colour="blue",size=0.5)+ # disability is plotted vs both sex and agegr 
labs(title="pb1")

pb2<-pb1+facet_grid(residence~.)+       # split by residence
labs(title="pb2")
pb3<-pb1+facet_grid(residence~country)+ # also split by country
labs(title="pb3")


## ----fig_gg2.12,echo=F,fig.width=12,fig.height=6,out.width="100%",fig.align="center"----
grid.arrange(pb1,pb2,nrow=1)


## ----fig_gg2.13,echo=ECHO,fig.width=16,fig.height=8,out.width="80%",fig.align="center"----
pb3


## ----ggplot2.13, warning=WARN, eval=EVAL, echo=ECHO,comment=COMMENT,message=FALSE-------
# this time we gather continuous variables
bp.lf<- bp %>% gather(key=var,value=value,bmi,height)   

pc1<-ggplot(bp.lf,aes(x=waistc,y=value,fill=var))+
geom_point(size=1.3,shape=21)

pc2<-pc1+facet_grid(residence~physical)+
   geom_smooth(method=lm,se=F,color="black")


## ----fig_gg2.14,echo=ECHO,fig.width=10,fig.height=6,out.width="80%",fig.align="center"----
pc1


## ----fig_gg2.15,echo=ECHO,fig.width=12,fig.height=6,out.width="100%",fig.align="center"----
pc2

