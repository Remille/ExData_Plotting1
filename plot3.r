#plot3 subset metering 1 through 3 v. time
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
png("plot3.png",width=480,height=480,units="px")

#plot each sub_metering column
plot(dat$DateTime,dat$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(dat$DateTime,dat$Sub_metering_2,type="l",col="red")
lines(dat$DateTime,dat$Sub_metering_3,type="l",col="blue")

#set up the legend with appropriate colors
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.off()
file.remove("household_power_consumption.txt")
