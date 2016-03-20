#plot2
#day vs global active power (kilowatts)
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
png("plot2.png",width=480,height=480,units="px")

#plot a time series graph
plot.ts(dat$Global_active_power,ylab = "Global Active Power (kilowatts)", xlab = "",xaxt="n")

#relabel axes to days, with partitions between time period of a day, each day had 1440 samplings
axis(1, labels = c("Thu", "Fri", "Sat"), at = c(1, 1440, 2880))
dev.off()
file.remove("household_power_consumption.txt")
