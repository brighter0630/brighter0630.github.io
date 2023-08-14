library(knitr)
filename <- "2023-08-14-이강인의-PSG-데뷔전-분석"

base.dir <- paste0("C:\\brighter0630.github.io\\")
base.url <- "../"
fig.path <- paste0("images/", filename)
opts_knit$set(base.dir = base.dir, base.url = base.url)
opts_chunk$set(fig.path = fig.path)
opts_chunk$set(fig.align = 'center', fig.cap = "", fig.width = 8, fig.height = 6)
setwd('C:\\brighter0630.github.io\\')

knit(input = paste0('onworking/', filename, '.Rmd'),
     output = paste0('_posts/', filename, '.md'),
     encoding = 'UTF-8')

