##me beltistopoihsh prepei na to kanw: function gia ta plots.
library(readtext)
##watch at https://cran.r-project.org/web/packages/readtext/vignettes/readtext_vignette.html
library(readxl)
library("writexl")
library(ggplot2)
library(plotly)
library(dplyr)
library(broom)
library(tidyselect)
library(ggthemes)
library(ggrepel)
library(ggpubr)
library(rgl)
##read.delim for manual choice
Rdata <- read.delim(file.choose())
View(Rdata)

Rdata_2D<-  select(Rdata, x, y, b,n,func)
Rdata_3D<-  select(Rdata, x, y, z, a,b,c,nx,ny,func)

Rdata<-Rdata_2D


x_b_data<-Rdata$x/Rdata$b
y_b<-Rdata$y/Rdata$b
n_data<-Rdata$n
f<-Rdata$func
n_unique<-unique(Rdata[c("n")])$n
x_b_unique<-unique(Rdata[c("x")]/Rdata[c("b")])$x





# create data
xb=12
x_b_unique[xb]
aval <- list()
for(n in 1:(length(n_unique))){
  aval[[n]] <-list(visible = FALSE,
                   name = paste0('n = ', n),
                   x=y_b[ which(x_b_data==x_b_unique[xb])[which(x_b_data==x_b_unique[xb]) %in% which(n_data==n_unique[n])]],
                   y=f[which(x_b_data==x_b_unique[xb])[which(x_b_data==x_b_unique[xb]) %in% which(n_data==n_unique[n])]][order(y_b[ which(x_b_data==x_b_unique[xb])[which(x_b_data==x_b_unique[xb]) %in% which(n_data==n_unique[n])]])])
}
aval[1][[1]]$visible = TRUE

# create steps and plot all traces
steps <- list()
fig <- plot_ly()
for (i in 1:(length(n_unique))) {
  fig <- add_lines(fig,x=aval[i][[1]]$x,  y=aval[i][[1]]$y, visible = aval[i][[1]]$visible, 
                   name = aval[i][[1]]$name, type = 'scatter', mode = 'lines', hoverinfo = 'name', 
                   line=list(color='00CED1'), showlegend = FALSE)
  
  step <- list(args = list('visible', rep(FALSE, length(aval))),
               method = 'restyle')
  step$args[[2]][i] = TRUE  
  steps[[i]] = step 
}  

# add slider control to plot
fig <- fig %>%
  layout(sliders = list(list(active = 1,
                             currentvalue = list(prefix = "n: "),
                             steps = steps)))

fig









#PROSOXH!!!
#ta steps den einai ftiagmena me sort, xreiazetai to to kanw gia na pairnw ay3ouses times tou x/b


# create data
n=2
avast<-list()
for(xb in 1:(length(x_b_unique))){
  avast[[xb]] <-list(visible = FALSE,
                     name = paste0('x/b = ', xb),
                     x=y_b[which(x_b_data==x_b_unique[xb])[which(x_b_data==x_b_unique[xb]) %in% which(n_data==n_unique[n])]],
                     y=f[which(x_b_data==x_b_unique[xb])[which(x_b_data==x_b_unique[xb]) %in% which(n_data==n_unique[n])]][order(y_b[ which(x_b_data==x_b_unique[xb])[which(x_b_data==x_b_unique[xb]) %in% which(n_data==n_unique[n])]])])
}
avast[1][[1]]$visible = TRUE

# create steps and plot all traces
steps <- list()
fig <- plot_ly()
for (i in 1:(length(x_b_unique))) {
  fig <- add_lines(fig,x=avast[i][[1]]$x,  y=avast[i][[1]]$y, visible = avast[i][[1]]$visible, 
                   name = avast[i][[1]]$name, type = 'scatter', mode = 'lines', hoverinfo = 'name', 
                   line=list(color='00CED1'), showlegend = FALSE)
  
  step <- list(args = list('visible', rep(FALSE, length(avast))),
               method = 'restyle')
  step$args[[2]][i] = TRUE  
  steps[[i]] = step 
}  

# add slider control to plot
fig <- fig %>%
  layout(sliders = list(list(active = 1,
                             currentvalue = list(prefix = "x/b: "),
                             steps = steps)))

fig

