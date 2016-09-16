library(data.table)

## Download and unzip the dataset:
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,"household_power_consumption.zip",mode="wb")
unzip("household_power_consumption.txt") 

## Read file and create required data table
dt <- fread("household_power_consumption.txt", select=c("Date","Time","Global_active_power","Voltage","Global_reactive_power","Sub_metering_1","Sub_metering_2","Sub_metering_3"),header=TRUE,na.string=c("?"))
dt_sub <- subset(dt,dt$Date=="1/2/2007"| dt$Date=="2/2/2007")

dt_sub$Timestamp <-paste(dt_sub$Date,dt_sub$Time)

## Draw line plot

par(mfrow=c(2,2),cex=0.5)


plot(x=strptime(dt_sub$Timestamp,"%d/%m/%Y %H:%M:%S"),dt_sub$Global_active_power,type="l",ylab = "Global Active Power(kilowatts)",xlab="")
plot(x=strptime(dt_sub$Timestamp,"%d/%m/%Y %H:%M:%S"),dt_sub$Voltage,type="l",ylab = "Voltage",xlab="dateTime")
plot(x=strptime(dt_sub$Timestamp,"%d/%m/%Y %H:%M:%S"),dt_sub$Sub_metering_1,type="l",col="black",ylab = "Energy Sub-metering",xlab="")
lines(strptime(dt_sub$Timestamp, "%d/%m/%Y %H:%M:%S"), dt_sub$Sub_metering_2, type = "l", col = "red" )
lines(strptime(dt_sub$Timestamp, "%d/%m/%Y %H:%M:%S"), dt_sub$Sub_metering_3, type = "l", col = "blue" )
legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(x=strptime(dt_sub$Timestamp,"%d/%m/%Y %H:%M:%S"),dt_sub$Global_reactive_power,type="l",ylab = "Global_reactive_power",xlab="dateTime")


dev.copy(png,filename="plot4.png",width = 480, height = 480)
dev.off()
par(mfrow=c(1,1),cex=1)