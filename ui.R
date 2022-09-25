ui=fluidPage(theme=shinytheme('lumen'),
            titlePanel('Fred Backtest Index'),
            sidebarLayout(
              sidebarPanel(
                textInput('freddt','Fred Data:',value='UNRATE',placeholder = 'Enter The Fred series ID'),
                dateRangeInput('minmaxdate','Date Range',start=as.Date('1900-01-01'),
                               end=as.Date(Sys.Date()-1),min=as.Date('1900-01-01'),max=as.Date(Sys.Date()-1),
                               ),
                actionButton('submit','Submit'),
                fluidRow(paste('The dates here are for when it was actually calculated.  You can think of it as like fiscal years')),
                fluidRow(paste('The csv dump will include restatements, the graph does not'))
              ),
              mainPanel(
                #MainPanel Here
                plotlyOutput('plot'),
                dataTableOutput('table')
              )
            ))