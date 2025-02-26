#Clear the memory
rm(list=ls())
#Download some important packages
library(maps)
library(mapdata)
library(maptools)
library(rgdal)
library(ggmap)
library(ggplot2)
library(rgeos)
library(broom)
library(plyr)

shapefile <- readOGR(
  dsn="C:/Users/Justin and Hope/Documents/R/facebook-mobility/shapefile", 
  layer="gadm36_GBR_3")

#Reshape for ggplot2 using the Broom package
mapdata <- tidy(
    shapefile,
    region="GID_3")

#Check the shapefile has loaded correctly by plotting an outline map of the UK
gg <- ggplot() + geom_polygon(data = mapdata, aes(x = long, y = lat, group = group), color = "#FFFFFF", size = 0.25)
gg <- gg + coord_fixed(1) #This gives the map a 1:1 aspect ratio to prevent the map from appearing squashed
print(gg)


#Create some data to use in the heatmap - here we are creating a random "value" for each county (by id)
mydata <- data.frame(id=unique(mapdata$id), value=sample(c(0:100), length(unique(mapdata$id)), replace = TRUE))


#Join mydata with mapdata
df <- join(mapdata, mydata, by="id")

#Create the heatmap using the ggplot2 package
gg <- ggplot() + geom_polygon(data = df, aes(x = long, y = lat, group = group, fill = value), color = "#FFFFFF", size = 0.25)
gg <- gg + scale_fill_gradient2(low = "blue", mid = "red", high = "yellow", na.value = "white")
gg <- gg + coord_fixed(1)
gg <- gg + theme_minimal()
gg <- gg + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = 'none')
gg <- gg + theme(axis.title.x=element_blank(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
gg <- gg + theme(axis.title.y=element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank())
print(gg)