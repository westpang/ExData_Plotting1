library(data.table)

## Download and unzip the dataset:
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,"household_power_consumption.zip",mode="wb")
unzip("household_power_consumption.txt") 

## Read file and create required data table
dt <- fread("household_power_consumption.txt", select=c("Date","Global_active_power"),header=TRUE,na.string=c("?"))
dt_sub <- subset(dt,dt$Date=="1/2/2007"|dt$Date=="2/2/2007")

## Draw histogram
hist(dt_sub$Global_active_power, col = "red", main = "Global Active Power",xlab = "Global Active Power (killowatts)", ylab = "Frequency")

dev.copy(png,filename="plot1.png",width = 480, height = 480)
dev.off()