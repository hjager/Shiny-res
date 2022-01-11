##-----------------------------------------------------------
##
## global.R contains global code and functions
## locate this file in the Shiny <appname> directory 
##        where ui and server.R are
## This is the first thing executed
##
## Be sure that paths are relative, but specify R version
## Objects defined in global.R are similar to those defined in app.R outside of the server function definition, 
## with one important difference: they are also visible to the code in the ui object. This is because they are 
## loaded into the global environment of the R session; all R code in a Shiny app is run in the global environment 
## or a child of it.
##
## run by typing: 
##   setwd("C:/Users/zij/Dropbox (ORNL)/MyProjects/Grid_Modernization/")
##   runApp("shinyRes", display.mode="showcase")
##
##------------------------------------------------------------
options(repos = c(CRAN = "https://cloud.r-project.org/"), encoding = "utf-8")
# r.version <- 4.0.5

## Name of app
app.name <- 'shinyRes'
## Where am I?
shiny.path <- getwd();
# /srv/connect/apps/shinyres 
# I don't think this app uses subfolders, but for future reference
#addResourcePath("pdf_folder", shiny.path)

## extract root directory -- note there will not be one
## if this is on shinyio server
#end   <- regexpr(app.name, shiny.path)[1]-2
#root  <- substr(shiny.path, 1, end)
print(paste0('Initiating ', app.name))
#if (length(root) < 6) {
#   print('from shinyapps.io server ')
# } else {
	# # pc: identify shiny application folder
	# pc <- Sys.getenv('COMPUTERNAME')
	# if (pc %in% c("BESD-JAGER-Z820"))
	# {
		# root <- "D:/Dropbox (ORNL)/"
	# } else {
		# root <- "C:/Users/zij/Dropbox (ORNL)/"
	# }
	# # Don't do this in deployed app, generates error
	# shiny.path <- paste0(root, "MyProjects/Grid_Modernization/shinyRes/")
	# setwd(shiny.path)
# }   
print(paste0("Running Shiny app file global.R in ", shiny.path))

## Load needed libraries but do not use install.packages
## because you will get an error trying to write to server disks 
#lib.list <- c('tidyverse','data.table','sf','sp','spData','plotly','xts','lubridate','clock','shinythemes','shinydashboard','shinybusy','shiny','DT')
library('tidyverse')
library('data.table')
library('sf')
library('sp')
library('spData')
library('plotly')
library('xts')
library('lubridate')
library('clock')
library('shinythemes')
library('shinydashboard')
library('shiny')
library('DT')

# Read global functions
source('shiny.functions.R')

# Load monthly averaged data, 10 years, 18 reservoirs
# This loads long version
#load(file=paste0(shiny.path, "Monthly.Rdata"), verbose=TRUE)
# Monthly.long.dt
load(file="Monthly.Rdata", verbose=TRUE)

# If moving from windows to linux
# fix.encoding <- function(df, originalEncoding = "latin1") {
  # numCols <- ncol(df)
  # for (col in 1:numCols) Encoding(df[, col]) <- originalEncoding
  # return(df)
# }

print(summary(Monthly.long.dt))

# Map reservoir ids to facilitate choice
id.map <- get.conus(DT=Monthly.long.dt)
print('Created site map')

# Define endpoints in date slider bar
min.date <- min(Monthly.long.dt$date)
max.date <- max(Monthly.long.dt$date)
print(paste0('Dates are from ', min.date, ' to ', max.date))

#RDSfilepath = paste0(root, 'MyPrograms/R/cmasher/RDS/')
#cmr_cmaps = readRDS(file=paste0(RDSfilepath, 'cmr_cmaps.RDS'))
cmr_cmaps <- readRDS('cmr_cmaps.RDS')

