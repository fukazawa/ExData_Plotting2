## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#2.Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

Baltimore =@NEI[NEI$fips == "24510",]

mvec =@c(
    mean(  Baltimore[Baltimore$year == 1999,]$Emissions ),
    mean(  Baltimore[Baltimore$year == 2002,]$Emissions ),
    mean(  Baltimore[Baltimore$year == 2005,]$Emissions ),
    mean(  Baltimore[Baltimore$year == 2008,]$Emissions )
)
png(filename = "plot2.png")
barplot(mvec ,  names.arg=c("1999","2002","2005","2008"),
        xlab="year", ylab="Emissions")
dev.off()


