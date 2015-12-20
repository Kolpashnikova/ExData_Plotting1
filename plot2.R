#downloading and unzipping the dataset
fileUrl<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl,destfile = "./hpc.zip")
unzip("hpc.zip", exdir = ".")
#reading file
mydata<-read.table("household_power_consumption.txt", header=T, sep=";", 
	na.strings = "?")
#creating new varible with date and time together
mydata$DateTime<-paste(mydata$Date, mydata$Time, sep = " ")

mydata$DateTime<-strptime(mydata$DateTime, format="%d/%m/%Y %H:%M:%S")
#as.date for date var, can be skipped
mydata$Date<-as.Date(mydata$Date, "%d/%m/%Y")

#subsetting the data to only two dates: 1st and 2nd of February, 2007
select<-mydata$Date=="2007-02-01"|mydata$Date=="2007-02-02"
mydata1<-mydata[select,]

#plotting the second plot 
#choosing the number of panels in the plot and margins
par(mfrow=c(1,1), mar = c(4, 4, 1, 1))
#actual plotting with axis names
plot(mydata1$DateTime, mydata1$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
#saving the plot as .png file, quietly
invisible(dev.copy(png, 'plot2.png'))
invisible(dev.off())
