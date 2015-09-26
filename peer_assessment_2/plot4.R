#######
# 
#  Dataset : Fine particulate matter (PM2.5) emissions data for 1999, 2002, 2005, and 2008
#  Source : US National Emissions Inventory (NEI)
#  URL : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#
#  ## MISSION ## :
#  Across the United States, how have emissions from coal 
#  combustion-related sources changed from 1999-2008?
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

# Find coal combustion-related sources
is.combustion.coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustion.coal.sources <- SCC[is.combustion.coal,]

# Find emissions from coal combustion-related sources
emissions <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]

# Compute the sum of the total emissions per year
emissions.by.year <- aggregate(Emissions ~ year, data=emissions, FUN=sum)

## Check for installed package before running install
pkgTest("ggplot2")

## Set image features
png("plot4.png",width=480,height=480,units="px",bg="transparent")

## Build the histogram 'plot4.png'
ggplot(emissions.by.year, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emissions")) +
  ggtitle("Emissions from coal combustion-related sources")

## Close the file
dev.off()

## Display 'plot4.png'
browseURL("plot4.png")
