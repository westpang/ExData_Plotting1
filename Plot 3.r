library(data.table)

## Download and unzip the dataset:
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,"household_power_consumption.zip",mode="wb")
unzip("household_power_consumption.txt") 

## Read file and create required data table
dt <- fread("household_power_consumption.txt", select=c("Date","Time","Sub_metering_1","Sub_metering_2","Sub_metering_3"),header=TRUE,na.string=c("?"))
dt_sub <- subset(dt,dt$Date=="1/2/2007"| dt$Date=="2/2/2007")
                                                        
dt_sub$Timestamp <-paste(dt_sub$Date,dt_sub$Time)
                                                        
## Draw line plot

plot(x=strptime(dt_sub$Timestamp,"%d/%m/%Y %H:%M:%S"),dt_sub$Sub_metering_1,type="l",col="black",ylab = "Energy Sub-metering",xlab="")
lines(strptime(dt_sub$Timestamp, "%d/%m/%Y %H:%M:%S"), dt_sub$Sub_metering_2, type = "l", col = "red" )
lines(strptime(dt_sub$Timestamp, "%d/%m/%Y %H:%M:%S"), dt_sub$Sub_metering_3, type = "l", col = "blue" )

legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,filename="plot3.png",width = 480, height = 480)
dev.off()