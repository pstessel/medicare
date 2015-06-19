setwd("/Volumes/HD2/Users/pstessel/Documents/Git_Repos/medicare")
library(shiny)

counties <- readRDS("census-app/data/counties.rds")
head(counties)

library(maps)
library(mapproj)
source("census-app/helpers.R")
counties <- readRDS("census-app/data/counties.rds")
percent_map(counties$white, "darkgreen", "% white")
