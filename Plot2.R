# import lib
library(data.table)

setwd("/Users/gryanfawcett/JHDataScience/ExData_Plotting1")

### IMPORT Data ####
mydata <- fread('~/Downloads/household_power_consumption.txt',na.strings=c("NA"))

#### Clean and seprate data ####
class(mydata$Date)
class(mydata$Time)

### Conver Data format ######
mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
class(mydata$Date)

#Convert and filter into data frame
subdata <- mydata[mydata$Date=="2007-02-01" | mydata$Date=="2007-02-02"]
class(subdata)
subdata <- data.frame(subdata)
for(i in c(3:9)) {
  subdata[,i] <- as.numeric(as.character(subdata[,i]))
}

#Create Date and Time Vars
subdata$Date_Time <- paste(subdata$Date,subdata$Time)

#Convert Data Time to correct Format
subdata$Date_Time <- strptime(subdata$Date_Time, format="%Y-%m-%d %H:%M:%S")
class(subdata$Date_Time)

#plot 1
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6,6,5,4))

plot(subdata$Date_Time, subdata$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power (kilowatts)", type="n")
lines(subdata$Date_Time, subdata$Global_active_power, type="S")

dev.off()
