#######
# 
#  Dataset : Electric power consumption
#  Source : UC Irvine Machine Learning Repository
#  URL : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
#  Household active power consumption histogram from the dates 2007-02-01 and 2007-02-02
#
#######

## Reset the graphical parameters back to default values
old.par <- par(mar = c(0, 0, 0, 0))
par(old.par)

## Getting full dataset
data_full <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## Take in charge the date format 
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## Concatenate date end time such as : "2007-02-01 00:00:00"
datetime <- paste(data$Date, data$Time)

## Convert our string's array into array of objects representing the date and time
data$Datetime <- as.POSIXct(datetime)

## Build the histogram (Plot 1)
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Edit the PNG file
dev.copy(png, file="plot1.png", height=480, width=480)

## Close the file
dev.off()