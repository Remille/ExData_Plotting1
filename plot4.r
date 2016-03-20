#plot 4 
#4 plots
#upleft(1,1) - time v global active power (plot2)
#upright(1,2) - time v voltage
#downleft(2,1) - time v subset metering 1-3 (plot 3)
#downright(2,2) - time v global reactive power
library(lubridate)

#set up data
if (!file.exists("dat.zip")) {
	download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./dat.zip")
}
unzip("dat.zip")
dat <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";", quote = "\"", dec = ".", fill = TRUE, comment.char = "", 
colClasses = c("character","character",rep("numeric",7)), na.strings="?",skip = 66637,nrows = 2880)

#add the labels because row 1 was skipped
names(dat) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

dat$DateTime <- as.POSIXct(paste(dat$Date,dat$Time),format = "%d/%m/%Y %H:%M:%S", tz = "EST")

#set up graphical device
png("plot4.png",width=480,height=480,units="px")

#4 plots parameters
par(mfrow = c(2,2))

#plot 1,1
#plot a time series graph
plot.ts(dat$Global_active_power,ylab = "Global Active Power (kilowatts)", xlab = "",xaxt="n")
#relabel axes
axis(1, labels = c("Thu", "Fri", "Sat"), at = c(1, 1440, 2880))

#plot 1,2
#time v voltage
plot.ts(dat$Voltage,ylab = "datetime", xlab = "Voltage",xaxt="n",lwd=1)
axis(1, labels = c("Thu", "Fri", "Sat"), at = c(1, 1440, 2880))

#plot 2,1
#plot each sub_metering 
plot(dat$DateTime,dat$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(dat$DateTime,dat$Sub_metering_2,type="l",col="red")
lines(dat$DateTime,dat$Sub_metering_3,type="l",col="blue")

#set up the legend with appropriate colors
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

#plot 2,2
#time v global reactive power
plot.ts(dat$Global_reactive_power,ylab = "datetime", xlab = "Global_reactive_power",xaxt="n")
axis(1, labels = c("Thu", "Fri", "Sat"), at = c(1, 1440, 2880))

dev.off()
file.remove("household_power_consumption.txt")