# R-shiny application for visualizing reservoir thermal structure
# DOI issued 1/11/2022 for GIThub repository v1, 
# https://zenodo.org/badge/latestdoi/446647361

# Set options, including those needed for debugging
#options(shiny.reactlog=FALSE)
#options(shiny.trace = TRUE)
#options(shiny.error = browser)
library('shiny')
library('rsconnect')
#library('reactlog')

# Deploy to shinyapp.io
# Remember to look at Logs on shinyapps.io
setwd("C:/Users/zij/Dropbox (ORNL)/MyProjects/Grid_Modernization/shinyRes")
rsconnect::setAccountInfo(name='yettas', token='61F350129E36963CECC600B7D1CE1CE0', secret='LGs49xq5ErrBWr9C27w7hGG/Qx5IW/XcQSJjip5Q')
deployApp(forceUpdate=TRUE, upload=TRUE, logLevel='verbose')

# Locally
#setwd("C:/Users/zij/Dropbox (ORNL)/MyProjects/Grid_Modernization/")
#runApp("shinyRes", launch.browser=TRUE, display.mode="showcase")
