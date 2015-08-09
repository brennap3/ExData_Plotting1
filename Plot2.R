
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



power.consumption.subset$datetimePOSIX<-strptime(paste(power.consumption.subset$Date, power.consumption.subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

png("plot2.png", width=480, height=480,res=120)  ##call it plot 2
par(mfcol=c(1,1)) ##use one column and one row
par(mar=c(4,4,4,4) + 0.1) ##set the margins
plot(power.consumption.subset$datetimePOSIX, power.consumption.subset$Global_active_power_Nm, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()