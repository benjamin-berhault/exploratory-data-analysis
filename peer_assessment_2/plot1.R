#######
# 
#  Dataset : Fine particulate matter (PM2.5) emissions data for 1999, 2002, 2005, and 2008
#  Source : US National Emissions Inventory (NEI)
#  URL : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#
#  ## MISSION ## :
#  Have total emissions from PM2.5 decreased in the United 
#  States from 1999 to 2008? Using the base plotting system,
#  make a plot showing the total PM2.5 emission from all 
#  sources for each of the years 1999, 2002, 2005, and 2008
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

# Aggregate by sum the total emissions by year
total.emissions <- aggregate(Emissions ~ year, NEI, sum)

## Set image features
png("plot1.png",width=480,height=480,units="px",bg="transparent")

## Build the histogram 'plot1.png'
barplot(height=total.emissions$Emissions, names.arg=total.emissions$year,
        xlab="years", ylab=expression('total PM'[2]*' emission'),
        main=expression('Total PM'[2]*' emissions at various years'))

## Close the file
dev.off()

## Display 'plot1.png'
browseURL("plot1.png")
  