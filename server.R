server = function(input, output) {
  
  # Introduction
  output$my.text <- renderText(paste('<h4>Welcome!</h4>', 'This visualization tool allows you to explore thermal profiles from reservoir temperature data simulated by running Res-strat, a multilayer reservior thermal stratification model developed by <a href=https://agupubs.onlinelibrary.wiley.com/doi/full/10.1029/2019MS001632>Yigzaw et al. (2019)</a>. Start by choosing a reservoir from the map below using the slider bar at right. Note that deeper reservoirs are more interesting to explore because they are simulated with more layers.', sep='<br/>') )

  # Show map of reservoirs on first table
  # this should be generated in global.R
  # Not sure how to add to wrap text: , style="float:right;"
  output$map <- renderPlot({
      id.map
  })
  
  plot.titles <- reactive({
      req(input$pick.id, input$date.range)
	  atitle <- paste0("Reservoir ", input$pick.id)
	  asubtitle <- paste0(input$date.range[1], ' to ', input$date.range[2])
	  return(list(atitle, asubtitle))
  })

  # Subset data and create title; this works
  plot.data <- reactive({
      req(input$pick.id, input$date.range)
      Data <- Monthly.long.dt %>%
		  filter(id==input$pick.id & between(date, input$date.range[1], input$date.range[2])) %>%
		  mutate(across(where(is.numeric), round, digits=3))
	  return(Data)
  })
  
  # Plot depth profiles based on 
  # selected site and year
  output$profile <- renderPlotly({
     plot.profile(plot.data(), titles=plot.titles(), color.var=input$pick.profile)
  })
  
  output$timeseries <- renderPlotly({
	 plot.thermocline(plot.data(), titles=plot.titles())
  })

  # data table
  output$current.table <- DT::renderDT({
	 datatable(plot.data(), options=list(scrollX=TRUE, scrollY=TRUE))
  })
  
}
