library(graphics)
library(ggplot2)
library(ggmap)
library(mapproj)
map <- get_map(location = 'Taiwan', zoom = 7)
ggmap(map)

