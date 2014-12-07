# import lib
library(data.table)

setwd("/Users/gryanfawcett/JHDataScience/ExData_Plotting1")

### IMPORT Data ####
mydata <- fread('~/Downloads/household_power_consumption.txt',na.strings="?")

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
subdata$Date_Time <- strptime(subdata$Date_Time, format="%Y-%m-%d %H:%M:S")
class(subdata$Date_Time)

#plot 1
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6,6,5,4))
hist(subdata$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)")
dev.off()
