##---------------------------------------------------------------
##
## Global functions: shiny.functions.R
##   get.conus
##   plot.profile
##   plot.thermocline
##
##---------------------------------------------------------------
## Create map to guide selecting reservoir
get.conus <- function(DT)
{
	my.proj <- 5070
	data(us_states); #4269
	st_set_crs(us_states, 4269)
	conus.sf <- st_transform(us_states, my.proj)

	# convert to numeric lat, long
	locs.dt <- read.table(file='reservoirs.txt', colClasses=c('numeric','character'), sep='_', header=FALSE, stringsAsFactors = FALSE)
	locs.dt <- data.table(locs.dt)
	names(locs.dt)[1:2] <- c('lat.dd','lon.dd')
	locs.dt[, lon.dd := as.numeric(str_replace(lon.dd, '.txt',''))]
	locs.dt$id <- seq(from=1, to=nrow(locs.dt), by=1)

	# Add latitude, longitude to profile data
	DT2 <- merge(DT, locs.dt, by=c('id'), all.x=TRUE)
	Monthly.sf <- st_as_sf(DT2, coords=c('lon.dd', 'lat.dd'), crs=4326)
	st_is_longlat(Monthly.sf)
	Monthly.sf <- st_transform(Monthly.sf, crs=my.proj)

	this.sf <- subset(Monthly.sf, year==2000 & month==1)
	id.map <- ggplot() + geom_sf(data=conus.sf) + geom_sf_label(data=this.sf, aes(label=id, fill=avg.depth.m), size=3, alpha=0.5) + scale_fill_gradient2(name='depth, m', low='skyblue1', high='cyan3') + xlab('') + ylab('') + theme_bw(20) + theme(axis.text=element_text(size=14), legend.title=element_text(size=14), legend.text=element_text(size=12), legend.position='bottom', legend.key.width=unit(3.2,"cm"))
	
	#ggsave(id.map, file=paste0(shiny.path, 'site.map.jpg'), dpi=300, height=3.5, width=4)
	
	return(id.map)
}

# Function plot.profile returns interactive depth profiles 
# color.var='layer' or 'month'
plot.profile <- function(DT, titles, color.var)
{
#  DT <- Monthly.long.dt[id==6 & year==2000 & !is.na(TdegC) & !is.nan(TdegC),]
#  color.var <- 'layer'
#  color.var <- 'season'
#  title <- 'title'

  DT <- droplevels(data.table(DT))
  setorderv(DT, c('id', 'date', 'layer'))

  gg1 <- ggplot(DT) + labs(title=unlist(titles[1]), caption=unlist(titles[2]))
  gg2 <- gg1 + geom_jitter(aes(x=TdegC, y=depth.m, color = get(color.var)))

  # circular palettes:
  # https://cmasher.readthedocs.io/user/introduction.html
  #RDSfilepath = paste0(root, 'MyPrograms/R/cmasher/RDS/')
  #cmr_cmaps = readRDS(file=paste0(RDSfilepath, 'cmr_cmaps.RDS'))  
  if (color.var=='layer')
  {
    gg3 <- gg2 + scale_color_gradientn(name=color.var, colors=rev(cmr_cmaps$infinity))
  } else {
    gg3 <- gg2 + scale_color_manual(name=color.var, values=c('darkgoldenrod1','aquamarine4','brown1','deepskyblue'))
  }
  gg4 <- gg3 + scale_x_continuous(name='Water temperature (C)', limits=c(0, 35)) + scale_y_reverse(name='Mid-layer depth (m)') 

  gg5 <- gg4 + theme_grey() + theme(plot.title=element_text(14, hjust=0.5), plot.subtitle=element_text(12, hjust=0.5, color='blue'), axis.title=element_text(18), axis.text=element_text(16), panel.grid.major= element_blank(), panel.grid.minor=element_blank(), panel.border=element_rect(colour = "black", fill=NA, size=2), legend.title=element_text(size=16), legend.text=element_text(size=13))
  
  return(gg5)
}

plot.thermocline <- function(DT, titles)
{
  # thermo.depth is the same across layers
  DT <- unique(data.table(DT[layer==1 & !is.na(thermo.depth),]))
  setorderv(DT, c('id','date'))
  gg1 <- ggplot(DT) + labs(title=unlist(titles[1]), subtitle=unlist(titles[2]))
  gg2 <- gg1 + geom_jitter(aes(x=date, y=thermo.depth, color=season), size=2.5)
  gg3 <- gg2 + scale_color_manual(name="", values=c('darkgoldenrod1','aquamarine4','brown1','deepskyblue'))
  gg4 <- gg3 + scale_x_date(name="", date_labels = "%b-%y") + scale_y_reverse(name='Thermocline depth (m)') 
  gg5 <- gg4 + theme_grey() + theme(plot.title=element_text(14, hjust=0.5), plot.subtitle=element_text(12, hjust=0.5, color='blue'), axis.title=element_text(18), axis.text=element_text(16), panel.grid.major= element_blank(), panel.grid.minor=element_blank(), panel.border=element_rect(colour = "black", fill=NA, size=2), legend.title=element_text(size=16), legend.text=element_text(size=11))
  
  return(gg5)
}
