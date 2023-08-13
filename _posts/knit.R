library(knitr)
filename <- "2023-08-12-아마존과-경쟁하는-CVS-기업분석"

base.dir <- paste0("C:\\brighter0630.github.io\\_posts\\")
base.url <- ""
fig.path <- paste0("figure/")
paste0(base.dir, fig.path)
opts_knit$set(base.dir = base.dir, base.url = base.url)
opts_chunk$set(fig.path = fig.path) 
setwd('C:\\brighter0630.github.io\\_posts\\')

library(rmarkdown)
render(paste0(filename, '.Rmd'), md_document(variant = "gfm"), output_yaml = TRUE)
