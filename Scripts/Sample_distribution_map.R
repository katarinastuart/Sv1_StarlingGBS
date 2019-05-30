# This code will be used to producing a map of locations for the 
# methods section of the morph chapter.

workwd <- 'C:/Users/z5188231/Desktop/Coding/Scripts/AdditionalWork/AdamPaper/Maps'

setwd(workwd)

# Now we can bring in the data for analysis. The data we will be
# looking at 
data <- read.table('key-file_morph_env_allplates.txt', sep = '\t', 
                header = TRUE)


# First we will get the mean location for each of our collection
# localities.

dflon <- do.call(data.frame, aggregate(x ~ location,
                                       data = data,
                                       function(x) c(mean(x),
                                                     length(x)),
                                       na.action = na.omit))

dflat <- do.call(data.frame, aggregate(y ~ location,
                                       data = data,
                                       function(x) c(mean(x),
                                                     length(x)),
                                       na.action = na.omit))

location.dat <- data.frame(dflat[,1:2], dflon[,2:3])
location.dat


colnames(location.dat) <- c("loc", "lat", "lon", "n")
loc.dat <- location.dat[order(location.dat$lat),]


ord <- read.table("pop_ordered_across_aust.txt", header = FALSE, sep = '\t')
loc.dat <- merge(loc.dat, ord, by.x = 'loc', by.y = 'V1')
colnames(loc.dat)[5] <- 'mapNo'

genGrp <- data[, c('location', 'genpopW.B.BS')]
genGrp <- do.call(data.frame, aggregate(genpopW.B.BS ~ location,
                                 data = data,
                                 function(x) median(x),
                                 na.action = na.omit))
loc.dat <- merge(loc.dat, genGrp, by.x = 'loc', by.y = 'location', all.y = FALSE)


loc.dat$samp <- ifelse(loc.dat$mapNo < 2, 0, 
                       ifelse(loc.dat$mapNo < 14, 1, 
                              ifelse(loc.dat$mapNo < 16, 2,
                                     ifelse(loc.dat$mapNo == 18, 2, 3))))


loc.dat$Col <- ifelse(loc.dat$mapNo < 2, 'plum2', 
                       ifelse(loc.dat$mapNo < 14, 'khaki', 
                              ifelse(loc.dat$mapNo < 16, 'sandybrown',
                                     ifelse(loc.dat$mapNo == 18, 'sandybrown', 'powderblue'))))

loc.dat$Env <- ifelse(loc.dat$mapNo < 7, 21, 
                      ifelse(loc.dat$mapNo == 8, 22,
                         ifelse(loc.dat$mapNo < 14 | loc.dat$mapNo == 16 | loc.dat$mapNo == 17 | loc.dat$mapNo == 20 | loc.dat$mapNo == 23, 22, 23)))



#install.packages("sp")
#install.packages("proj4")
#install.packages("raster")
#install.packages("rgeos")
#install.packages("rgdal")
#install.packages("maptools")
#install.packages("maps")
#install.packages("mapdata")
#install.packages("scales")
#install.packages("plotrix")
#install.packages("mapproj")
#install.packages("multichull")
#install.packages("rgeos")


library(multichull)
library(sp)
library(proj4)
library(raster)
library(rgeos)
library(rgdal)
library(maptools)
library(maps)
library(mapdata)
library(scales)
library(plotrix)
library(mapproj)
library(rgeos)

coordinates(loc.dat) <- ~ lon + lat
projection(loc.dat) <- '+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs'
loc.dat$cex <- loc.dat$n/10


# Now that we have the locations imported and the mean values
# we will bring in the australian map.
#map('worldHires', 'Australia', xlim = c(110, 155),
#    ylim = c(-44, -10), col = 'cornsilk', fill = TRUE)
aus <- readShapePoly("ausMap-states/AUS_adm1.shp")
plot(NA, xlim = c(110, 155), ylim = c(-44, -10), xlab="", ylab="", xaxt="n", yaxt="n", bty="n")
plot(aus, add = T, col = "grey85", border = "grey10", lwd=0.25)
points(loc.dat, pch = 22, cex = 2.75, lwd = 1,
       col = 'black', bg = loc.dat$Col)
text(loc.dat, labels = loc.dat$mapNo, cex = 0.75, col = 'black')
axis(1,las=1)
axis(2,las=1)
box()
compassRose(115, -40, cex = 0.6)
map.scale(120, -41, metric = TRUE, ratio = FALSE)

# Now we want to create a map that describes the genetic and environmental
# clustering.
minx <- min(data$x) - 1.5
maxx <- max(data$x) + 1.5
miny <- min(data$y) - 1.5
maxy <- max(data$y) + 1.5

#Environmental groupings
location.dat3 <- data.frame(location.dat$lon,location.dat$lat,loc.dat@data[["mapNo"]])
location.dat3

#Lon/Lat for great dividing range
GDR <- read.csv("GreatDivRange.txt", sep="\t", quote = "")
GDR <- data.frame(GDR)

#More detailed map

pdf("rplot.pdf") 

plot(NA, xlim = c(minx, maxx), ylim = c(miny, maxy), xlab="", ylab="", xaxt="n", yaxt="n", bty="n")
plot(aus, add = T, col = "grey80", border = "grey10", lwd=0.25)
points(loc.dat, pch = loc.dat$Env, cex = 2.75, lwd = 1,
       col = 'black', bg = loc.dat$Col)
lines(x = GDR$Lon, y = GDR$Lat, col = "blue", lwd = 2)
text(loc.dat, labels = loc.dat$mapNo, cex = 0.75, col = 'black')
plot(hull,add=T,border="green")
axis(1,las=1)
axis(2,las=1)
box()
compassRose(122, -42, cex = 0.8)
map.scale(127, -42, metric = TRUE, ratio = FALSE)

dev.off() 




#Unused Chull code
arid <- location.dat3[c(4,5,13,15,20,22),]
semiarid <- location.dat3[c(2,6,9,11,12,16,18,19,23,24),]
nonarid <- location.dat3[c(1,3,7,8,10,14,17,21),]

hpts <- chull(arid)
hpts2 <- c(hpts, hpts[1])
hpts2
lines(arid[hpts2, ], col = 'blue')

hpts <- chull(semiarid)
hpts
hpts2 <- c(hpts, hpts[1])
hpts2
lines(semiarid[hpts2, ], col = 'green')

hpts <- chull(nonarid)
hpts
hpts2 <- c(hpts, hpts[1])
hpts2
lines(nonarid[hpts2, ], col = 'red')

