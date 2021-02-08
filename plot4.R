library(tidyverse)
library(png)
library(lubridate)
#read data
dat <- read.table('/Volumes/Amrit_Mac/Certifications/Exploratory Data Analysis/week1/household_power_consumption.txt', 
                  na.strings ="?", header = TRUE, sep = ";")
#explore dimensions, head and structure of data
dim(dat)
head(dat)
str(dat)
#convert date variable to date format
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")
#Subset to the two required dates only
dat2 <- filter(dat, Date==as.Date("2007-02-01") | Date==as.Date("2007-02-02"))
#create new variable DatTime with combined infor from Date and Time
dat2$DatTime <- with(dat2, ymd(Date)+ hms(Time))
#Send plot to png file using png function
png(filename = "/Users/Amrit/Desktop/ExData_Plotting1/plot4.png", width = 480, height = 480,
    units = "px")
par(mfcol=c(2,2))
#plot1
plot(dat2$DatTime, dat2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
#plot2
matplot(dat2$DatTime, cbind(dat2$Sub_metering_1, dat2$Sub_metering_2, dat2$Sub_metering_3), 
        type = "l", xlab = "", ylab = "Energy sub meeting", col = c("black", "red", "blue"),
        lty = 1)
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, box.lwd=0)
#plot3
plot(dat2$DatTime, dat2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
#plot4
plot(dat2$DatTime, dat2$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off()

