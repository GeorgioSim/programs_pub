#Ergastirio kormou 1 askisi P3
#Simopoulos Georgios, AM:1110201800159
library(data.table)
library(purrr)
library(readxl)
library("writexl")
library(ggplot2)
library(dplyr)
library(broom)
library(tidyselect)
library(ggthemes)
library(ggrepel)
library(ggpubr)
args(ggplot)

Rdata<-read_excel("proxeiro.xlsx")
View(Rdata)

DIR<-Rdata$DIR
SPD<-Rdata$`SPD[m/s]`
rm(xdata)
#1,2,3....12
Tasks<- "Tasks"
Month<-c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")

s<-SPD[which(Rdata$MO==1)]
Apnoia<-length(which(s==0))/length(which(SPD==0))*100
Mesi_timi<-mean(s)
Diaspora<-var(s)
Diamesos<-median(s)
xdata <- data.frame(Tasks = c("Apnoia%","Average[m/s]","Variance[m^2/s^2]","Median[m/s]"), 
                    Jan = c(Apnoia,Mesi_timi,Diaspora,Diamesos),
                    stringsAsFactors = FALSE)

for(i in 2:12){
  s<-SPD[which(Rdata$MO==i)]
  Apnoia<-length(which(s==0))/length(which(SPD==0))*100
  Mesi_timi<-mean(s)
  Diaspora<-var(s)
  Diamesos<-median(s)
  xdata <- data.frame(xdata, 
                      dec=c(Apnoia,Mesi_timi,Diaspora,Diamesos),
                      stringsAsFactors = FALSE)
}

setnames(xdata, old = colnames(xdata), new = c(Tasks,Month))
View(xdata)


#most common number (mode)
# Create the function.
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
# Create the vector with numbers.
v <- Rdata$DIR
# Calculate the mode using the user function.
result <- getmode(v)
print(result)
