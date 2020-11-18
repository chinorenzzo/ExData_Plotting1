## Plot the 3 energy sub metering measurements vs time

## Load packages

library(lubridate)
library(dplyr)

## Download and unzip raw data
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,"rawdata.zip")
unzip("rawdata.zip")

## Read only the data needed
rawData<-read.table(text = grep("(^[12]/2/2007)|^Date",readLines("household_power_consumption.txt"),value=T),sep = ";",header = T)

## Put correct type to variables
rawData$Date<-dmy(rawData$Date)
#rawData$Time<-hms(rawData$Time)
rawData$Global_active_power<-as.numeric(rawData$Global_active_power)
rawData$Global_reactive_power<-as.numeric(rawData$Global_reactive_power)
rawData$Voltage<-as.numeric(rawData$Voltage)
rawData$Global_intensity<-as.numeric(rawData$Global_intensity)
rawData$Sub_metering_1<-as.numeric(rawData$Sub_metering_1)
rawData$Sub_metering_2<-as.numeric(rawData$Sub_metering_2)

rawData<-mutate(rawData,dateTime=paste(Date,Time))
rawData$dateTime<-ymd_hms(rawData$dateTime)

## Open png device
png(filename = "plot3.png",width = 480, height = 480, units = "px")

## Visualization
plot(rawData$dateTime,rawData$Sub_metering_1,col="black",type = "l",xlab = "",ylab = "Energy sub metering")
points(rawData$dateTime,rawData$Sub_metering_2,col="red",type = "l")
points(rawData$dateTime,rawData$Sub_metering_3,col="blue",type = "l")
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Close png device
dev.off()