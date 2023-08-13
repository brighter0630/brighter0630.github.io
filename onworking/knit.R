library(knitr)
filename <- "2023-08-12-아마존과-경쟁하는-CVS-기업분석"

base.dir <- paste0("C:\\brighter0630.github.io\\")
base.url <- "/"
fig.path <- paste0("/_posts/figure/", filename)
paste0(base.dir, fig.path)
opts_knit$set(base.dir = base.dir, base.url = base.url)
opts_chunk$set(fig.path = fig.path) 
setwd('C:\\brighter0630.github.io\\')
knit(paste0('onworking\\', filename, '.Rmd'), output = paste0('onworking\\', filename, '.md'))
