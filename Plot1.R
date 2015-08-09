
## libarays i need (dont actaully need ggplot)

library(plyr)
library(dplyr)
library(ggplot2)
library (lattice)
library(reshape2)


##opem data for visualization tutorial
##this ocde is tutorial completed between
## 04082015 12:10 12:45
##https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##for coursera exploratory analysis week 1

power.consumption<-read.csv("household_power_consumption.txt",sep=";")##make sure the zip is downloaded to your local working directory 

power.consumption$Date_DT = as.Date(power.consumption$Date, format="%d/%m/%Y")
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")

power.consumption.subset = filter(power.consumption,
                                  power.consumption$Date_DT >= startDate & power.consumption$Date_DT <= endDate)

str(power.consumption.subset)

power.consumption.subset$Global_active_power_Nm<-as.numeric(as.character(power.consumption.subset$Global_active_power))

## Creating the plot


png("plot1.png", width=480, height=480,res=120)  ##call it plot 1
par(mfcol=c(1,1)) ##use one column and one row
par(mar=c(4,4,4,4) + 0.1) ##set the margins
hist(power.consumption.subset$Global_active_power_Nm, main="Global Active Power",
     xlab="Global Active Power (kilowats)", ylab="Frequency",col="red")
axis(1, at=c(0,200,400,600,800,1000,1200), col.axis="black", las=0)
axis(2, at=c(0,2,4,6), col.axis="black", las=0)
dev.off()


##plot 1