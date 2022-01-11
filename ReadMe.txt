# Set options, including those needed for debugging
options(shiny.reactlog=FALSE)
options(shiny.trace = TRUE)
options(shiny.error = browser)
library('shiny')
library('reactlog')
setwd("C:/Users/zij/Dropbox (ORNL)/MyProjects/Grid_Modernization/")

# Hit cntl-F3 to generate log
runApp("shinyRes", launch.browser=TRUE, display.mode="showcase")

runApp("shinyRes", launch.browser=TRUE)
, display.mode="showcase")
needed