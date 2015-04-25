library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions 
#from 1999???2008 for Baltimore City? 
#Which have seen increases in emissions from 1999???2008? 
#Use the ggplot2 plotting system to make a plot answer this question


#point, nonpoint, onroad, nonroad
Baltimore =@NEI[NEI$fips == "24510",]
point = Baltimore[Baltimore$type == "POINT",]
nonpoint = Baltimore[Baltimore$type == "NONPOINT",]
onroad = Baltimore[Baltimore$type == "ON-ROAD",]
nonroad = Baltimore[Baltimore$type == "NON-ROAD",]

mean_frame =data.frame(
    year=c(rep( c("1999","2002","2005","2008"),4 )) ,
    type=c( rep("point",4) , rep("nonpoint",4) , rep("onroad",4), rep("nonroad",4)),
    Emissions =@c(
        log( mean(  point[point$year == 1999,]$Emissions )),
        log(mean(  point[point$year == 2002,]$Emissions )),
        log(mean(  point[point$year == 2005,]$Emissions )),
        log(mean(  point[point$year == 2008,]$Emissions )),
        log(mean(  nonpoint[nonpoint$year == 1999,]$Emissions )),
        log(mean(  nonpoint[nonpoint$year == 2002,]$Emissions )),
        log(mean(  nonpoint[nonpoint$year == 2005,]$Emissions )),
        log(mean(  nonpoint[nonpoint$year == 2008,]$Emissions )),
        log(mean(  onroad[onroad$year == 1999,]$Emissions )),
        log(mean(  onroad[onroad$year == 2002,]$Emissions )),
        log(mean(  onroad[onroad$year == 2005,]$Emissions )),
        log(mean(  onroad[onroad$year == 2008,]$Emissions )),
        log(mean(  nonroad[nonroad$year == 1999,]$Emissions )),
        log(mean(  nonroad[nonroad$year == 2002,]$Emissions )),
        log(mean(  nonroad[nonroad$year == 2005,]$Emissions )),
        log(mean(  nonroad[nonroad$year == 2008,]$Emissions ))
    )
)

ggplot(data = MD, aes(x = year, y = log(Emissions))) + facet_grid(. ~ type) + guides(fill = F) + geom_boxplot(aes(fill = type)) + stat_boxplot(geom = 'errorbar') + ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + ggtitle('Emissions per Type in Baltimore City, Maryland') + geom_jitter(alpha = 0.10) 


png(filename = "plot3.png")
qplot(year,Emissions,data=mean_frame,facets=type~.)
dev.off()


