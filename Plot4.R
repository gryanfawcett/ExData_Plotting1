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



png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c(2, 2), mar = c(14, 6, 2, 2), cex=.5)
# Plot 2 
plot(subdata$Date_Time, subdata$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power", type="n")

lines(subdata$Date_Time, subdata$Global_active_power, type="S")
# Top right graph
plot(subdata$Date_Time, subdata$Voltage, xaxt=NULL, xlab = "datetime", ylab = "Voltage", type="n")
lines(subdata$Date_Time, subdata$Voltage, type="S")
#Plot 3 
plot(subdata$Date_Time, subdata$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")
lines(subdata$Date_Time, subdata$Sub_metering_1, col = "black", type = "S")
# Plots for sub_metering_1
lines(subdata$Date_Time, subdata$Sub_metering_2, col = "red", type = "S")
## Plots for sub_metering_2
lines(subdata$Date_Time, subdata$Sub_metering_3, col = "blue", type = "S")
## Plots lines for sub_metering_3
legend("topright", bty = "n", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Bottom right graph
plot(subdata$Date_Time, subdata$Global_reactive_power, xaxt=NULL, xlab = "datetime", ylab = "Global_reactive_power", type="n")
lines(subdata$Date_Time, subdata$Global_reactive_power, type="S")
dev.off()
