server=function(input,output,session){
  #RenderUI graph here
  #hide graph initially
  #show upon button hit
  #hide('table')
  vals=eventReactive(input$submit,{
    abcd=grab_macro_manually(identity=input$freddt,sdate=input$minmaxdate[1],edate=input$minmaxdate[2])
    abcd
  })
  
  vals2=eventReactive(input$submit,{
    abcd=grab_macro_manually(identity=input$freddt,sdate=input$minmaxdate[1],edate=input$minmaxdate[2])
    setDT(abcd)
    setorder(abcd,date,realtime_start)
    abcd=unique(abcd,by=c('date'))
    abcd
  })
  
  titles=eventReactive(input$submit,{
    title=search_macro_database(input$freddt)
  })
  
  
  output$table=DT::renderDataTable(server=FALSE,{
    data=vals()
    
    
    datatable(data, extensions = 'Buttons', 
              options = list(paging = TRUE, searching = TRUE,
                             ordering = TRUE, dom = 'tB',
                             buttons = c('copy', 'csv', 'excel','pdf')))
  })
  output$plot=renderPlotly(
    plot_ly(vals2(),x=~date,y=~value,type='scatter',mode='lines') %>%
      layout(hovermode='compare',title=titles())
  )
}