#######
# 
#  Dataset : Fine particulate matter (PM2.5) emissions data for 1999, 2002, 2005, and 2008
#  Source : US National Emissions Inventory (NEI)
#  URL : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#
#  ## MISSION ## :
#  Of the four types of sources indicated by the type 
#  (point, nonpoint, onroad, nonroad) variable, which 
#  of these four sources have seen decreases in emissions 
#  from 1999-2008 for Baltimore City? Which have seen 
#  increases in emissions from 1999-2008? Use the ggplot2 
#  plotting system to make a plot answer this question.
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
bmore.emissions <- NEI[NEI$fips=="24510",]

# Aggregate by sum the total emissions by year and type of the source
bmore.emissions.aggr <- aggregate(Emissions ~ year + type,
                                  data=bmore.emissions,
                                  FUN=sum)

## Check for installed package before running install
pkgTest("ggplot2")

## Set image features
png("plot3.png",width=960,height=480,units="px",bg="transparent")

## Build the histogram 'plot3.png'
ggplot(bmore.emissions.aggr, aes(x=factor(year), y=Emissions, fill=type)) +
  geom_bar(stat="identity") +
  facet_grid(. ~ type) +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emission")) +
  ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                     "City by various source types", sep="")))

## Close the file
dev.off()

## Display 'plot3.png'
browseURL("plot3.png")
