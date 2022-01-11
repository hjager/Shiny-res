# Set options, including those needed for debugging
#options(shiny.reactlog=FALSE)
#options(shiny.trace = TRUE)
#options(shiny.error = browser)
library('shiny')
library('rsconnect')
#library('reactlog')

# Deploy to shinyapp.io
setwd("C:/Users/zij/Dropbox (ORNL)/MyProjects/Grid_Modernization/shinyRes")
rsconnect::setAccountInfo(name='yettas', token='61F350129E36963CECC600B7D1CE1CE0', secret='LGs49xq5ErrBWr9C27w7hGG/Qx5IW/XcQSJjip5Q')
deployApp(forceUpdate=TRUE, upload=TRUE, logLevel='verbose')

# Remember to look at Logs on shinyapps.io

Rdata files seem to work fine going from windows to linux

# Debug locally: Hit cntl-F3 to generate log
setwd("C:/Users/zij/Dropbox (ORNL)/MyProjects/Grid_Modernization/")
runApp("shinyRes", launch.browser=TRUE, display.mode="showcase")
