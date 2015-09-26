#######
# 
#  Dataset : Fine particulate matter (PM2.5) emissions data for 1999, 2002, 2005, and 2008
#  Source : US National Emissions Inventory (NEI)
#  URL : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#
#  ## MISSION ## :
#  Have total emissions from PM2.5 decreased in the 
#  Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#  Use the base plotting system to make a plot answering this question.
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

# Have total emissions from PM2.5 decreased in Baltimore City, Maryland from
# 1999 to 2008?
bmore.emissions <- NEI[NEI$fips=="24510",]

# Aggregate by sum the total of emissions by year
bmore.emissions.by.year <- aggregate(Emissions ~ year, bmore.emissions, sum)

## Set image features
png("plot2.png",width=480,height=480,units="px",bg="transparent")

## Build the histogram 'plot2.png'
barplot(height=bmore.emissions.by.year$Emissions,
        names.arg=bmore.emissions.by.year$year,
        xlab="years", ylab=expression('total PM'[2]*' emission'),
        main=expression('Total PM'[2]*' emissions in Baltimore City, '*
                          'Maryland at various years'))

## Close the file
dev.off()

## Display 'plot2.png'
browseURL("plot2.png")
