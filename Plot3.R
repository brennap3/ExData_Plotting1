library(plyr)
library(dplyr)
library (lattice)
library(reshape2)



power.consumption<-read.csv("household_power_consumption.txt",sep=";")##make sure the zip is downloaded to your local working directory 

power.consumption$Date_DT = as.Date(power.consumption$Date, format="%d/%m/%Y")
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")

power.consumption.subset = filter(power.consumption,
                                  power.consumption$Date_DT >= startDate & power.consumption$Date_DT <= endDate)

str(power.consumption.subset)

power.consumption.subset$Global_active_power_Nm<-as.numeric(as.character(power.consumption.subset$Global_active_power))


power.consumption.subset$Sub_metering_1_NM<-as.numeric(as.character(power.consumption.subset$Sub_metering_1))
power.consumption.subset$Sub_metering_2_NM<-as.numeric(as.character(power.consumption.subset$Sub_metering_2))
power.consumption.subset$Sub_metering_3_NM<-as.numeric(as.character(power.consumption.subset$Sub_metering_3))

power.consumption.subset$timestamp = strptime(paste(power.consumption.subset$Date, power.consumption.subset$Time, sep=" "),
                                              format="%d/%m/%Y %H:%M:%S", tz="UTC")

png("plot3.png", width=480, height=480,res=120)  ##call it plot 3
par(mfcol=c(1,1))
par(mar=c(2,2,2,2) + 0.1) ##set the margins
plot(power.consumption.subset$timestamp, power.consumption.subset$Sub_metering_1_NM, type="l", xlab="", ylab="Energy sub metering")
lines(power.consumption.subset$timestamp, power.consumption.subset$Sub_metering_2_NM, col="red")
lines(power.consumption.subset$timestamp, power.consumption.subset$Sub_metering_3_NM, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=par("lwd"))
dev.off()