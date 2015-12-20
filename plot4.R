#downloading and unzipping dataset

fileUrl<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl,destfile = "./hpc.zip")
unzip("hpc.zip", exdir = ".")
#read the file
mydata<-read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "?")
#create a new varible with date and time
mydata$DateTime<-paste(mydata$Date, mydata$Time, sep = " ")

mydata$DateTime<-strptime(mydata$DateTime, format="%d/%m/%Y %H:%M:%S")
#as.date for the date var, may be skipped
mydata$Date<-as.Date(mydata$Date, "%d/%m/%Y")

#subsetting the data to only two dates: 1st and 2nd of February, 2007
select<-mydata$Date=="2007-02-01"|mydata$Date=="2007-02-02"
mydata1<-mydata[select,]

#plotting the fourth plot
#specifying the panels and margins
par(mfrow=c(2,2), mar = c(4, 4, 1, 1))
#plotting in col1, row1
plot(mydata1$DateTime, mydata1$Global_active_power, type = "l",
	ylab = "Global Active Power (kilowatts)", xlab = "")
#plotting in col2, row1
plot(mydata1$DateTime, mydata1$Voltage, type = "l",
	ylab = "Voltage", xlab = "datetime")
#plotting in col1, row2
plot(mydata1$DateTime, mydata1$Sub_metering_1,  
	type = "l",
	ylab = "Energy sub metering", xlab = "")
lines(mydata1$DateTime, mydata1$Sub_metering_2, 
   	type = "l", col = "red")
lines(mydata1$DateTime, mydata1$Sub_metering_3, 
   	type = "l", col = "blue")
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"),  
   	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
	bty = "n")
#plotting in col2, row2
plot(mydata1$DateTime, mydata1$Global_reactive_power, type = "l",
	ylab = "Global_reactive_power", xlab = "datetime")
#saving the plot as .png file, quietly
invisible(dev.copy(png, 'plot4.png'))
invisible(dev.off())
