#RDA for ADAMS DATA

setwd("C:/Users/z5188231/Desktop/Coding/Files/AdditionalWork/AdamsPaper")

library(maps)
library(mapdata)
library(maptools)
library(scales)
library(raster)
library(sp)

gendata <- read.csv("snps_05_3_5.012.imp.csv", sep=",", header=FALSE)
nrow(gendata)
ncol(gendata)
gendata <- gendata[2:500,2:16178]
gendata[1:20,1:20]

envdata <- read.csv("RDAmetadata.csv", sep=",", header=TRUE)
envdata <- envdata[,2:3]
envdata <- as.data.frame(envdata)
str(envdata)

#Environmental predictors
climdata <- getData('worldclim',download=TRUE,var='bio',res=5)
climdata <- climdata[[c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19)]]

# using only coordinates found in vcf (missing US3 outlier)
colnames(envdata) <- c("long","lat")

# pull out data
points <- SpatialPoints(envdata, proj4string=climdata@crs)

# write to file
values <- extract(climdata,points)
popenv <- cbind.data.frame(envdata,values)
str(popenv)
colnames(popenv) <- c("long","lat","AnnualMeanTemperature","MeanDiurnalRange","Isothermality","TemperatureSeasonality","MaxTemperatureofWarmestMonth","MinTemperatureofColdestMonth","TemperatureAnnualRange","MeanTemperatureofWettestQuarter","MeanTemperatureofDriestQuarter","MeanTemperatureofWarmestQuarter","MeanTemperatureofColdestQuarter","AnnualPrecipitation","PrecipitationofWettestMonth","PrecipitationofDriestMonth","PrecipitationSeasonality","PrecipitationofWettestQuarter","PrecipitationofDriestQuarter","PrecipitationofWarmestQuarter","PrecipitationofColdestQuarter")
str(popenv)

#for version 2 env predictors
popenv <- read.csv("RDAmetadata.csv", sep=",", header=TRUE)
popenv <- read.csv("RDAmetadata_simplenames.csv", sep=",", header=TRUE) #shorter var names

################################# RDA ########################################
# Step 1: prep datasets
# environmental data
env.df <- as.data.frame(popenv)
str(env.df)

pred <- env.df[]
pred <- as.data.frame(lapply(pred, as.numeric))

# check which variables are correlated
#pred <- pred[c(3:21)] #pred vversion 1
pred <- pred[c(3:19)] #pred vversion 2
str(pred)


# Step 2: read in imputed genetic data
str(gendata)
# check no missing data
sum(is.na(gendata))

# this fix is needed to get correlations with predictors
# check that all values are numeric
gendata <- as.data.frame(gendata)
gendata[,1:16177] <- lapply(gendata[,1:16177], as.numeric)
# remove letters from colnames
colnames(gendata) <- gsub("[a-zA-Z ]", "", colnames(gendata))
str(gendata)

# Step 3: ordinate genotypes
library(vegan)


#AusStar.rda <- rda(gendata ~ Isothermality + TemperatureSeasonality + AnnualPrecipitation, data=pred, scale=T)
#AusStar.rda <- rda(gendata ~ Isothermality + MinTemperatureofColdestMonth + MeanTemperatureofDriestQuarter + PrecipitationSeasonality + PrecipitationofWarmestQuarter + PrecipitationofColdestQuarter, data=pred, scale=T)
#AusStar.rda <- rda(gendata ~ Elevation + Isothermality + MinTemperatureofColdestMonth + PrecipitationofWettestMonth + PrecipitationSeasonality + mnNDVI + varDL, data=pred, scale=T)
AusStar.rda <- rda(gendata ~ Elev + Bio03 + Bio06 + Bio13 + Bio15 + mnNDVI + varDL, data=pred, scale=T)

AusStar.rda

RsquareAdj(AusStar.rda)

screeplot(AusStar.rda) # pretty uniform

signif.full <- anova.cca(AusStar.rda, parallel=getOption("mc.cores")) # test for significance
signif.full

# get variance inflation factors for each predictor
vif.cca(AusStar.rda)


################################## Plotting ################################## 

plot(AusStar.rda, scaling=3)

#formating it to make it intuative
location <- c((rep("Munglinup",3)),(rep("Albury",24)),(rep("Austral Eden",21)),(rep("Bendigo",25)),
              (rep("Cygnet",17)),(rep("Dubbo",20)),(rep("Hay",26)),(rep("KingIsland",14)),
             (rep("Lemon",24)),(rep("Lismore",22)),(rep("Maitland",25)),(rep("Moree",24)),
             (rep("Nowra",25)),(rep("Nyngan",25)),(rep("Orbost",22)),(rep("Sheffield",21)),
             (rep("Condingup",3)),(rep("Coorabie",1)),(rep("Munglinup",1)),(rep("Condingup",1)),
             (rep("Munglinup",2)),(rep("Condingup",1)),(rep("Munglinup",2)),(rep("Condingup",3)),
             (rep("Munglinup",1)),(rep("McLarenvale",20)),(rep("Coorabie",18)),(rep("Munglinup",4)),
             (rep("Condingup",2)),(rep("StreakyBay",8)),
             (rep("TumbyBay",22)),(rep("StreakyBay",1)),(rep("Munglinup",4)),(rep("Condingup",1)),
             (rep("Munglinup",2)),(rep("Condingup",5)),(rep("Munglinup",2)),(rep("Tamworth",11)),
             (rep("Warnambool",24)),(rep("Wonthaggi",22))
             ) #BY LOCATION

#location <- c((rep("WA",3)),(rep("NSW",49)),(rep("VIC",25)),(rep("TAS",20)),(rep("NSW",46)),(rep("TAS",16)),
#             (rep("QLD",24)),(rep("NSW",123)),(rep("VIC",24)),(rep("TAS",24)),
#             (rep("WA",3)),(rep("SA",1)),(rep("WA",12)),(rep("SA",41)),(rep("WA",7)),(rep("SA",37)),
#             (rep("WA",18)),(rep("NSW",11)),(rep("VIC",46))
#             ) #BY STATE

#location <- c((rep("Dry subhumid",25)),(rep("Not arid",24)),(rep("Semi-arid",68)),(rep("Not arid",20)),
#             (rep("Semi-arid",46)),(rep("Not arid",16)),(rep("Semi-arid",24)),(rep("Not arid",48)),
#             (rep("Dry subhumid",20)),(rep("Semi-arid",47)),(rep("Not arid",25)),(rep("Semi-arid",25)),(rep("Not arid",48)),
#             (rep("Semi-arid",48)),(rep("Not arid",46))
#             ) #BY type


str(location)
popenv <- cbind(env.df,location)
str(popenv)
levels(popenv$location)
levels(popenv$location) <- c("Albury NSW","Austral Eden NSW","Bendigo VIC","Condingup WA","Coorabie SA","Cygnet TAS","Dubbo NSW","Hay NSW","KingIsland TAS",
                            "Lemon QLD","Lismore NSW","Maitland NSW","McLarenvale SA","Moree NSW","Munglinup WA","Nowra NSW","Nyngan NSW","Orbost VIC","Sheffield TAS",
                            "StreakyBay SA","Tamworth NSW","TumbyBay SA","Warnambool VIC","Wonthaggi VIC") #BY LOCATION


popenv$location <- factor(popenv$location, levels = c("Munglinup WA", "Condingup WA", "Coorabie SA", "StreakyBay SA", "TumbyBay SA", "McLarenvale SA",
                                                      "Warnambool VIC", "Bendigo VIC", "Wonthaggi VIC", "Orbost VIC", "KingIsland TAS", "Sheffield TAS", "Cygnet TAS",
                                                      "Albury NSW", "Hay NSW", "Dubbo NSW", "Nyngan NSW", "Nowra NSW", "Maitland NSW", "Austral Eden NSW",
                                                      "Tamworth NSW", "Moree NSW", "Lismore NSW", "Lemon QLD"))


#levels(popenv$location) <- c("NSW","QLD","SA","TAS","VIC","WA") #BY STATE

eco <- popenv$location
str(eco)

bg <- c("maroon2","plum2","orange","salmon1","darkorange3","sienna2","lightgreen","greenyellow","mediumseagreen",
        "chartreuse4","gold","goldenrod","gold4","slateblue1","cornflowerblue","royalblue3","darkblue","blue1",
        "deepskyblue3","deepskyblue4","cadetblue3","cadetblue1","turquoise","darkmagenta")

#bg <- c("orangered3","cadetblue1","greenyellow") # 3  colors for our pops #BY TYPE

#bg <- c("indianred1","deepskyblue3","aquamarine3","gold","blueviolet","orange") # 5  colors for our pops #BY STATE

# Add extra space to right of plot area; change clipping to figure
par(mar=c(5.1, 4.1, 4.1, 10.1), xpd=TRUE)

#par(mar=c(2, 2, 2, 2), xpd=FALSE)

#Plot
plot(AusStar.rda, type="n", scaling=3)
points(AusStar.rda, display="species", pch=20, cex=0.7, col="gray32", scaling=4)           # the SNPs - change scaling to 3 to add
points(AusStar.rda, display="sites", pch=21, cex=1.3, col="gray32", scaling=3, bg=bg[eco]) # the birds
text(AusStar.rda, scaling=3, display="bp", col="grey10", cex=1.2, lwd = 1.5)                 # the predictors
legend("topright", inset=c(-0.32,0.1), title="Locations", legend=levels(eco), bty="n", col="gray32", pch=21, cex=1, pt.bg=bg)



################################## SNPS ################################## 

load.rda <- scores(AusStar.rda, choices=c(1:3), display="species")
outliers <- function(x,z){
  lims <- mean(x) + c(-1, 1) * z * sd(x)     # find loadings +/-z sd from mean loading     
  x[x < lims[1] | x > lims[2]]               # locus names in these tails
}

# check for normal distribution
hist(load.rda[,1], main="Loadings on RDA1")
hist(load.rda[,2], main="Loadings on RDA2")
hist(load.rda[,3], main="Loadings on RDA3") 

# get number of candidates > 3 SDs from mean loading
cand1 <- outliers(load.rda[,1],3) 
cand2 <- outliers(load.rda[,2],3) 
cand3 <- outliers(load.rda[,3],3)

ncand <- length(cand1) + length(cand2) + length(cand3)
length(cand1)
length(cand2)
length(cand3)
ncand # 111

cand1 <- cbind.data.frame(rep(1,times=length(cand1)), names(cand1), unname(cand1))
cand2 <- cbind.data.frame(rep(2,times=length(cand2)), names(cand2), unname(cand2))
cand3 <- cbind.data.frame(rep(3,times=length(cand3)), names(cand3), unname(cand3))

colnames(cand1) <- c("axis","SNPlist","loading")
colnames(cand2) <- c("axis","SNPlist","loading")
colnames(cand3) <- c("axis","SNPlist","loading")
cand1
cand2
cand3

LoadingsRDA <- c(cand1,cand2,cand3)
LoadingsRDA
write.table(cand1, file = "Loadingscand1.csv", sep = ",", row.names = TRUE, col.names = NA)
write.table(cand2, file = "Loadingscand2.csv", sep = ",", row.names = TRUE, col.names = NA)
write.table(cand3, file = "Loadingscand3.csv", sep = ",", row.names = TRUE, col.names = NA)

#list of 012 SNPs that are candidates
#can't be fd to make for loop. do one at a time
SNPlist <- as.numeric(paste(cand1[,2]))
SNPlist <- sort(SNPlist)
SNPlist <- as.data.frame(SNPlist)

SNPlist <- as.numeric(paste(cand2[,2]))
SNPlist <- sort(SNPlist)
SNPlist <- as.data.frame(SNPlist)

SNPlist <- as.numeric(paste(cand3[,2]))
SNPlist <- sort(SNPlist)
SNPlist <- as.data.frame(SNPlist)

#####PREPARE REFERENCE TO MAP BACK TO ORIGINAL SNP 
#vcf SNP names
posdata <- read.csv("snps_05_3_5.012.pos.csv", sep="\t", header=FALSE)
posdata <- as.data.frame(posdata[,2])
nrow(posdata) #16177
ncol(posdata) #1
posdata

#Grab 012 SNP names
str(gendata)
rowdata <- colnames(gendata) #row numbers in same order as posdata
rowdata <- as.data.frame((rowdata))
str(rowdata)
nrow(rowdata) #16177
ncol(rowdata) #1
rowdata

#align up 012 and vcf file snp names
fullsnps <- c(posdata, rowdata)
fullsnps <- as.data.frame(fullsnps)
colnames(fullsnps) <- c("VCFsnp","SNPlist")
colnames(fullsnps)
str(fullsnps)
fullsnps

####MAP CANDIDATE LISTS TO POPER SNP REFERENCE
#Keep only the SNPs that we find are candidates i.e. SNPlist
candidatesnps <-merge(x = SNPlist, y = fullsnps, by = "SNPlist", all.x = TRUE)
str(candidatesnps)
write.table(candidatesnps, file = "candidate_rda3.txt", sep = "\t", row.names = TRUE, col.names = NA)



