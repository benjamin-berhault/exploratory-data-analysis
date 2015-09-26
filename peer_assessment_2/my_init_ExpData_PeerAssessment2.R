#######
# 
#  Dataset : Fine particulate matter (PM2.5) emissions data for 1999, 2002, 2005, and 2008
#  Source : US National Emissions Inventory (NEI)
#  URL : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#
#  Data loading
#
#######

#######
# Start of boring environment preparation...
##

## Install the package if needed
pkgTest <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(x,character.only = TRUE)) stop("Package not found")
  }
}
if(!file.exists('summarySCC_PM25.rds') || !file.exists('Source_Classification_Code.rds')){
  
  pkgTest("RCurl")
  
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                method='curl', destfile='exdata_data_NEI_data.zip')
  unzip('exdata_data_NEI_data.zip')
  
}

## This first line will likely take a few seconds. Be patient!
if (!(exists("NEI"))) { 
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!(exists("SCC"))) { 
  SCC <- readRDS("Source_Classification_Code.rds")
}

##
# End of boring environment preparation.
# Data is loaded in, let's go do some stuff with !!!
#######