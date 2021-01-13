#AM:1110201800159
#Simopoulos Georgios
#Askisi 3

library(readxl)
library("writexl")
library(ggplot2)
library(dplyr)
library(broom)
library(tidyselect)
library(ggthemes)
library(ggrepel)
library(ggpubr)
library(zoom)
args(ggplot)

Rdata<-read_excel("NGC6934.xlsx")
View(Rdata)


V1place<-which(Rdata$V==16.617)+1
V2place<-which(Rdata$V==16.497)+1
V1place
V2place
ERV1<-Rdata$ERRV[V1place]
ERV2<-Rdata$ERRV[V2place]
ERV1
ERV2
ER<-sqrt(ERV1^2+ERV2^2)/2
ER

sqrt((0.0168)^2+(0.046)^2)
0.4605*0.049
(10^(10+0.13)-10^(10-0.13))/2