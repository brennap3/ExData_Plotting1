
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

power.consumption.subset$Voltage_Nm<-as.numeric(as.character(power.consumption.subset$Voltage))

power.consumption.subset$Global_reactive_power_Nm<-as.numeric(as.character(power.consumption.subset$Global_reactive_power))

###

str(power.consumption.subset)

###
png("plot4.png", width=480, height=480,res=120)  ##call it plot 4
# Setting the canvas for 4 plots
par(mfcol=c(2,2))
par(mar=c(2.5,2.5,2.5,2.5) + 0.1)
# First plot
plot(power.consumption.subset$timestamp, power.consumption.subset$Global_active_power_Nm, type="l", xlab="",
     ylab="Global Active Power")

# Second plot
plot(power.consumption.subset$timestamp, power.consumption.subset$Sub_metering_1_NM, type="l", xlab="",
     ylab="Energy sub metering")
lines(power.consumption.subset$timestamp, power.consumption.subset$Sub_metering_2_NM, col="red")
lines(power.consumption.subset$timestamp, power.consumption.subset$Sub_metering_3_NM, col="blue")
legend("topright", legend=c("Server_Sub_metering_1", "Server_Sub_metering_2", "Server_Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=par("lwd"), bty="n",cex=0.5)

# Third Plot
plot(power.consumption.subset$timestamp, power.consumption.subset$Voltage_Nm, type="l",
     xlab="date/time", ylab="Voltage")

# Fourth plot
plot(power.consumption.subset$timestamp, power.consumption.subset$Global_reactive_power_Nm, type="l",
     xlab="date/time", ylab="CPU_SERVER_reactive_power")

dev.off()
