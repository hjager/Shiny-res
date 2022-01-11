# run by typing: runApp("shinyRes", display.mode="showcase")

shinyUI <- fluidPage(

titlePanel(h2("Simulated thermal profiles for US reservoirs", align="center")),
#add_busy_spinner(spin = "fading-circle"),

sidebarLayout( position = "right",            
  sidebarPanel(
	sliderInput(inputId="pick.id", label=h4("Select reservoir id:"), value=4, min=0, max=18),

    tags$style(type='text/css', "{font-size: 25px; line-height: 24px;}"), 
	dateRangeInput(inputId="date.range", label=h4(" Choose date range:"), start=min.date, end=max.date, format="mm-yyyy", separator=' to ')
  ), # sidebarPanel
     
  ## Display profiles
  ## UI sets available plot area, server sets actual plot size
  mainPanel(
	tabsetPanel(
	    id="tabid1", 
		tabPanel(h3("overview"), 
		  fluidRow(
		    column(8, offset=0, div(style="padding: 0px 0px; margin:0%"), align='left', plotOutput("map", width="100%")), 
		    column(4, offset=0, div(style="padding: 0px 0px; margin:0%"),align='left', htmlOutput("my.text", style="font-size:16px;"))
		  )
		),
		
		tabPanel(h3("profiles"), tags$style(type='text/css', "{font-size:25px;)"), radioButtons(inputId="pick.profile", label=h4("Examine profile by:"), choices=c("layer","season"), selected="layer", inline=TRUE),
		plotlyOutput("profile", width="100%")),
		
		tabPanel(h3("time series"), plotlyOutput("timeseries", width="100%")),
		
		tabPanel(h3("data"), DT::dataTableOutput("current.table", width="100%"))
	)
  ) # mainPanel

) # sidebarLayout

) # fluidPage
