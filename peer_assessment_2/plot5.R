#######
# 
#  Dataset : Fine particulate matter (PM2.5) emissions data for 1999, 2002, 2005, and 2008
#  Source : US National Emissions Inventory (NEI)
#  URL : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#
#  ## MISSION ## :
#  How have emissions from motor vehicle sources changed 
#  from 1999-2008 in Baltimore City?
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

## Get data from Baltimore, Maryland : fips == "24510"
## from motor vehicle sources
bmore.emissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]

# Compute the sum of the total emissions "ON-ROAD" per year
bmore.emissions.aggr <- aggregate(Emissions ~ year, data=bmore.emissions, FUN=sum)

## Check for installed package before running install
pkgTest("ggplot2")

## Set image features
png("plot5.png",width=480,height=480,units="px",bg="transparent")

## Build the histogram 'plot5.png'
ggplot(bmore.emissions.aggr, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emissions")) +
  ggtitle("Emissions from motor vehicle sources in Baltimore City")

## Close the file
dev.off()

## Display 'plot5.png'
browseURL("plot5.png")
