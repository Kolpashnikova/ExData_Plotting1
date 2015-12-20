#d/ling and unzipping dataset

fileUrl<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl,destfile = "./hpc.zip")
unzip("hpc.zip", exdir = ".")
#reading the data
mydata<-read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "?")
#creating a new varible with date and time
mydata$DateTime<-paste(mydata$Date, mydata$Time, sep = " ")

mydata$DateTime<-strptime(mydata$DateTime, format="%d/%m/%Y %H:%M:%S")
#as.date for the date var, can be skipped
mydata$Date<-as.Date(mydata$Date, "%d/%m/%Y")

#subsetting the data to only two dates: 1st and 2nd of February, 2007
select<-mydata$Date=="2007-02-01"|mydata$Date=="2007-02-02"
mydata1<-mydata[select,]

#plotting the third plot
#specifying the number of panels
par(mfrow=c(1,1))
#plotting
plot(mydata1$DateTime, mydata1$Sub_metering_1,  
     type = "l",
     ylab = "Energy sub metering", xlab = "")
#adding to the plot
lines(mydata1$DateTime, mydata1$Sub_metering_2, 
     type = "l", col = "red")
#adding to the plot
lines(mydata1$DateTime, mydata1$Sub_metering_3, 
      type = "l", col = "blue")
#adding the legeng in the top right
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#saving the plot as .png file, quietly
invisible(dev.copy(png, 'plot3.png'))
invisible(dev.off())
