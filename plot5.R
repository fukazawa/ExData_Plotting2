library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SRC <- readRDS("Source_Classification_Code.rds")

VEH <- grep("vehicle",SRC$EI.Sector,value=T,ignore.case=T) 
SRC.VEH <- subset(SRC, SRC$EI.Sector %in% VEH, select=SCC) 
BC <- subset(NEI, fips == "24510") 
NEI.VEH <- subset(BC, BC$SCC %in%  SRC.VEH$SCC) 
pd <- aggregate(NEI.VEH[c("Emissions")], list(year = NEI.VEH$year), sum) 
 
png('plot5.png') 
plot(pd$year, pd$Emissions, type = "l",  
    xlab = "Year", ylab = "Emissions") 
dev.off() 

