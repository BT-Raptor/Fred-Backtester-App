search_macro_database=function(search='unemployment'){
  print('Starting to grab Macro Data')
  require(fredr)
  require(rdbnomics)
  #FRED
  require(fredr)
  require(purrr)
  fredr_set_key('e2123b0a0195152b8b83dd503d60416c')
  s_id=c()
  l=list()
  xyza=tryCatch({
    xyz=fredr_series_search_text(search_text = search,limit=100)[,c('id','title','observation_start','observation_end','frequency')]
    return(xyz)
  },
  error=function(cond){
    xyz=data.table(id=numeric(),title=numeric(),observation_start=numeric(),observation_end=numeric(),frequency=numeric())
    return(xyz)
  })
  
  return(xyza)
}

grab_macro_manually=function(identity='UNRATE',sdate=SDATE,edate=EDATE){
  print('Starting to grab Macro Data')
  require(fredr)
  require(rdbnomics)
  #FRED
  require(fredr)
  require(purrr)
  fredr_set_key('e2123b0a0195152b8b83dd503d60416c')
  s_id=c()
  o_SDATE=as.Date(paste(substr(sdate,1,4),substr(sdate,5,6),substr(sdate,7,8),sep='-'))
  o_EDATE=as.Date(paste(substr(edate,1,4),substr(edate,5,6),substr(edate,7,8),sep='-'))
  real_SDATE=o_SDATE
  real_EDATE=o_EDATE
  l=list()
  xyza=tryCatch({
    xyz=fredr(series_id=identity,
              observation_start = as.Date(o_SDATE),  #this is the associated time value
              observation_end =  as.Date(o_EDATE)
    )
    names(xyz)=c('Date','series','value')
    return(xyz)
  },
  error=function(cond){
    xyz=data.table(Date=as.numeric(),series=as.numeric(),value=as.numeric())
    return(xyz)
  })
  return(xyza)

}



