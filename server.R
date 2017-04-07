library(shiny)
library(plotly)
# Define server logic required to draw a histogram
shinyServer(function(input, output) { 
  
  database <- Sys.glob("*-perform.csv")
  sum <- read.csv("perform-summary.csv")
  
  output$variables <- renderPrint({read.csv(database[1])[0,]})
  output$model <- renderPlotly({
    modelData <- as.data.frame(table(sum[,3]))
    ggplotly(plot_ly(data = modelData, 
                     x = modelData[,1], 
                     y = modelData[,2], 
                     type = 'bar') %>% layout(title = "Frequency of Models", 
                                                                    xaxis = list(title = "Model Type"), 
                                                                    yaxis = list(title = "Frequency")))
    
  })
  output$company <- renderPrint({
    data <- as.data.frame(table(sum[,2]))
    colnames(data) <- c("Company", "Freq.")
    data
  })
  
  output$writeSummary <- renderPrint({
    if(!is.na(as.numeric(input$choice)) && as.numeric(input$choice) > 0 && as.numeric(input$choice) <= length(database)){
      summary(read.csv(database[as.numeric(input$choice)])[,c(12:41)])}
    else "System ID does not exist."
  })
  output$readSummary <- renderPrint({
    if(!is.na(as.numeric(input$choice)) && as.numeric(input$choice) > 0 && as.numeric(input$choice) <= length(database)){
      summary(read.csv(database[as.numeric(input$choice)])[,c(42:70)])}
    else "System ID does not exist."
  })
  output$totalSummary <- renderPrint({
    if(!is.na(as.numeric(input$choice)) && as.numeric(input$choice) > 0 && as.numeric(input$choice) <= length(database)){
      summary(read.csv(database[as.numeric(input$choice)])[,c(71:99)])}
    else "System ID does not exist."   
  })
  output$bandwidthSummary <- renderPrint({
    if(!is.na(as.numeric(input$choice)) && as.numeric(input$choice) > 0 && as.numeric(input$choice) <= length(database)){
      summary(read.csv(database[as.numeric(input$choice)])[,c(100:102)])}
    else "System ID does not exist." 
  })
  output$ioSummary <- renderPrint({
    if(!is.na(as.numeric(input$choice)) && as.numeric(input$choice) > 0 && as.numeric(input$choice) <= length(database)){
      summary(read.csv(database[as.numeric(input$choice)])[,c(109:111)])}
    else "System ID does not exist."      
  })
  
  output$customPlot1 <- renderPlotly({
    if(!is.na(as.numeric(input$in1)) && as.numeric(input$in1) > 0 && as.numeric(input$in1) <= length(database)){
      xVar <- switch(input$x, "readsGt32msPct" = 42, "writesGt32msPct" = 13, "readsGt64msPct" = 43, "writesGt64msPct" = 14)
      yVar <- switch(input$y, "readsGt32msPct" = 42, "writesGt32msPct" = 13, "readsGt64msPct" = 43, "writesGt64msPct" = 14)
      
      ggplotly(plot_ly(data = read.csv(database[as.numeric(input$in1)]), 
                       x = read.csv(database[as.numeric(input$in1)])[,xVar], 
                       y = read.csv(database[as.numeric(input$in1)])[,yVar], 
                       type = 'scatter', mode = 'markers') %>% layout(title = paste0("System ", input$in1), 
                                                                      xaxis = list(title = input$x), 
                                                                      yaxis = list(title = input$y)))
    } 
    else{
      ggplotly(ggplot(NULL))  
    }
  })
  
  output$customPlot2 <- renderPlotly({
    if(!is.na(as.numeric(input$in2)) && as.numeric(input$in2) > 0 && as.numeric(input$in2) <= length(database)){
      xVar <- switch(input$x, "readsGt32msPct" = 42, "writesGt32msPct" = 13, "readsGt64msPct" = 43, "writesGt64msPct" = 14)
      yVar <- switch(input$y, "readsGt32msPct" = 42, "writesGt32msPct" = 13, "readsGt64msPct" = 43, "writesGt64msPct" = 14)
      
      ggplotly(plot_ly(data = read.csv(database[as.numeric(input$in2)]), 
                       x = read.csv(database[as.numeric(input$in2)])[,xVar], 
                       y = read.csv(database[as.numeric(input$in2)])[,yVar], 
                       type = 'scatter', mode = 'markers') %>% layout(title = paste0("System ", input$in2), 
                                                                      xaxis = list(title = input$x), 
                                                                      yaxis = list(title = input$y)))
    }
    else{
      ggplotly(ggplot(NULL))  
    }
  })
})