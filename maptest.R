# http://www.milanor.net/blog/?p=594

rm(list=ls())

airports <- read.csv("/Volumes/HD2/Users/pstessel/Documents/Git_Repos/medicare/data/airports.dat", header = FALSE)
colnames(airports) <- c("ID", "name", "city", "country", "IATA_FAA", "ICAO", "lat", "lon", "altitude", "timezone", "DST")
head(airports)

library(rworldmap)
newmap <- getMap(resolution = "low")
plot(newmap, xlim = c(-20, 59), ylim = c(35, 71), asp = 1)

points(airports$lon, airports$lat, col = "red", cex = .6)

routes <- read.csv("/Volumes/HD2/Users/pstessel/Documents/Git_Repos/medicare/data/routes.dat", header=F)
colnames(routes) <- c("airline", "airlineID", "sourceAirport", "sourceAirportID", "destinationAirport", "destinationAirportID", "codeshare", "stops", "equipment")
head(routes)

# Starting from the routes dataset, let's count the both number of routes
# departing from and arriving to a particular airport. I'm using another very
# useful package by Hadley Wickham for this task.

library(plyr)

# counts the number of sourceAirportID rows in the file "routes" 
departures <- ddply(routes, .(sourceAirportID), "nrow")
# adds "flights" as label for column 2
names(departures)[2] <- "flights"

arrivals <- ddply(routes, .(destinationAirportID), "nrow")
names(arrivals)[2] <- "flights"

# Then, let's add the info on departing and arriving flights to the airports
# dataset (which contains the coordinates data.)

airportD <- merge(airports, departures, by.x = "ID", by.y = "sourceAirportID")
airportA <- merge(airports, arrivals, by.x = "ID", by.y = "destinationAirportID")

# The goal is now to plot the airports on the map of Europe as circles whose
# area is proportional to the number of departing flights.
# 
# The first step is to get the map from GoogleMaps (or one of the other
# available services), like was shown last time.

library(ggmap)
map <- get_map(location = 'Europe', zoom = 4)

# The following lines already get us quite close to producing the desired chart.

mapPoints <- ggmap(map) + 
  geom_point(aes(x = lon, y = lat, size = sqrt(flights)), data = airportD, alpha = .5)

mapPoints

# The ggmap command prepares the drawing of the map. The geom_point function
# adds the layer of data points, as would be normally done in a ggplot. A
# thorough explanation of ggplot is well beyond the scope of this post, but here
# are quick details on what is passed to geom_point: - aes indicates how
# aesthetics (points in this case) are to be generated; the lon variable is
# associated to the x axis, lat to y, and the size of the points is proportional
# to the value of the variable flights (actually to its square root;) - data
# indicates the dataset where the variable passed to aes are to be found; - the
# alpha parameter controls the transparency of the plotted points (some degree
# of transparency will make the overlapping circles distinguishable.)
# 
# And here's what appears on the R plotting window when one types mapPoints in
# the console.

mapPoints

# A few tweaks to the legend (so that it does report the actual number of
# departures rather than the square root,) and the chart is ready for
# publication.

mapPointsLegend <- mapPoints + 
  scale_size_area(breaks = sqrt(c(1, 5, 10, 50, 100, 500)), labels = c(1, 5, 10, 50, 100, 500), name = "departing routes")
mapPointsLegend
