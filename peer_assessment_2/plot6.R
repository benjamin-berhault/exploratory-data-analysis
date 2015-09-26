#######
# 
#  Dataset : Fine particulate matter (PM2.5) emissions data for 1999, 2002, 2005, and 2008
#  Source : US National Emissions Inventory (NEI)
#  URL : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#
#  ## MISSION ## :
#  Compare emissions from motor vehicle sources in Baltimore 
#  City with emissions from motor vehicle sources in 
#  Los Angeles County, California (fips == "06037"). 
#  Which city has seen greater changes over time in motor 
#  vehicle emissions?
#
#######

## clear environment variable
# rm(list=ls(all=TRUE))

## Only load data if it isn't already done
if (!(exists("NEI")) || !(exists("SCC"))) { 
  source("my_init_ExpData_PeerAssessment2.R")
}

#######
# INTERESTING CODE JUST BELOW
##

normalize <- function(x) {(x-min(x)) / (max(x)-min(x))}

# Get Baltimore emissions from motor vehicle sources
bmore.emissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
bmore.emissions.aggr <- aggregate(Emissions ~ year, data=bmore.emissions, FUN=sum)

# Get Los Angeles emissions from motor vehicle sources
la.emissions <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]
la.emissions.aggr <- aggregate(Emissions ~ year, data=la.emissions, FUN=sum)

bmore.emissions.aggr$County <- "Baltimore City, MD"
la.emissions.aggr$County <- "Los Angeles County, CA"
both.emissions <- rbind(bmore.emissions.aggr, la.emissions.aggr)

## Check for installed package before running install
pkgTest("ggplot2")

## Set image features
png("plot6.png",width=480,height=600,units="px",bg="transparent")

## Build the histogram 'plot6.png'
ggplot(both.emissions, aes(x=factor(year), y=Emissions, fill=County)) +
  geom_bar(stat="identity") + 
  facet_grid(County  ~ ., scales="free") +
  ylab("total emissions (tons)") + 
  xlab("year") +
  ggtitle(expression("Motor vehicle emission variation\nin Baltimore and Los Angeles"))

## Close the file
dev.off()

## Display 'plot6.png'
browseURL("plot6.png")
