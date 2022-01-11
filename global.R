##-----------------------------------------------------------
##
## global.R contains global code and functions
## run by typing: 
##   setwd("C:/Users/zij/Dropbox (ORNL)/MyProjects/Grid_Modernization/")
##   runApp("shinyRes", display.mode="showcase")
##
##------------------------------------------------------------
rm(list=ls()); # bad idea?

# Navigate to shiny application folder
pc <- Sys.getenv('COMPUTERNAME')
if (pc %in% c("BESD-JAGER-Z820"))
{
	root <- "D:/Dropbox (ORNL)/"
} else {
	root <- "C:/Users/zij/Dropbox (ORNL)/"
}
shiny.path <- paste0(root, "MyProjects/Grid_Modernization/shinyRes/")
setwd(shiny.path)

# Load shiny, lets see if that's enough
## Load needed libraries 
get.lib <- function(pack){
    create.pkg <- pack[!(pack %in% installed.packages()[, "Package"])]
    if (length(create.pkg))
      install.packages(create.pkg, dependencies = TRUE)
    sapply(pack, require, character.only = TRUE)
}
lib.list <- c('tidyverse','data.table','sf','sp','spData','plotly','gganimate','xts','lubridate','clock','lutz','shinythemes','shinydashboard','shinybusy','shiny','reactlog','DT')
lapply(lib.list, 'get.lib')

# Set options, including those needed for debugging
# these are now in Readme.txt to run before this
#options(shiny.reactlog=TRUE) 
#options(shiny.trace = TRUE)

# Read global functions
source('shiny.functions.R')

# Load monthly averaged data, 10 years, 18 reservoirs
# This loads long version
#load(file=paste0(shiny.path, "Monthly.Rdata"), verbose=TRUE)
load(file="Monthly.Rdata", verbose=TRUE)

# Map reservoir ids to facilitate choice
id.map <- get.conus(DT=Monthly.long.dt)
print('Created site map')

# Define endpoints in date slider bar
min.date <- min(Monthly.long.dt$date)
max.date <- max(Monthly.long.dt$date)
print(paste0('Dates are from ', min.date, ' to ', max.date))

RDSfilepath = paste0(root, 'MyPrograms/R/cmasher/RDS/')
cmr_cmaps = readRDS(file=paste0(RDSfilepath, 'cmr_cmaps.RDS'))

