#######
# 
#  Dataset : Electric power consumption
#  Source : UC Irvine Machine Learning Repository
#  URL : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
#  Energy sub-metering consumption from the dates 2007-02-01 and 2007-02-02
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

## Build and display graph of active power (Plot 3)
# Sub_metering_1 : energy sub-metering corresponding to the kitchen : dishwasher, oven, microwave
# Sub_metering_2 : energy sub-metering corresponding to the laundry room : washing-machine, tumble-drier, refrigerator, a light
# Sub_metering_3 : energy sub-metering corresponding to an electric water-heater and an air-conditioner
with(data, {
  plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})

## Legend definition
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.75)

## Edit the PNG file
dev.copy(png, file="plot3.png", height=480, width=480)

## Close the file
dev.off()