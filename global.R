library(lubridate)
library(fredr)
library(data.table)
library(shinythemes)
library(shinyjs)
library(plotly)
library(DT)

grab_macro_manually=function(identity,sdate,edate){
  #FRED
  require(fredr)
  fredr_set_key('fcb0ac03b1c5921da839803a1b2c1157')
  real_SDATE=sdate
  real_EDATE=edate
  xyz=fredr(series_id=identity,
            realtime_start = real_SDATE,  #this is the associated time value
            realtime_end =  real_EDATE
  )
  xyz=as.data.table(xyz)
  setorder(xyz,realtime_start,date)
  xyz=unique(xyz,by=c('date'))
  #xyza=xyz[,c('date','series_id','value')]
  return(xyz)
}

search_macro_database=function(search='unemployment'){
  #FRED
  fredr_set_key('fcb0ac03b1c5921da839803a1b2c1157')
  xyz=fredr_series_search_id(search_text = search,limit=1)[1,]
  xyza=xyz$title
  return(xyza)
}
