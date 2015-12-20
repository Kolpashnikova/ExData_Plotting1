#download and unzip dataset

fileUrl<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl,destfile = "./hpc.zip")
unzip("hpc.zip", exdir = ".")

#read the file
mydata<-read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "?")
#create new variable with date and time
mydata$DateTime<-paste(mydata$Date, mydata$Time, sep = " ")

mydata$DateTime<-strptime(mydata$DateTime, format="%d/%m/%Y %H:%M:%S")
#as.date for the date var, can be skipped
mydata$Date<-as.Date(mydata$Date, "%d/%m/%Y")

#subsetting the data to only two dates: 1st and 2nd of February, 2007
select<-mydata$Date=="2007-02-01"|mydata$Date=="2007-02-02"
mydata1<-mydata[select,]

#Plotting the first plot
#defining the number of panels on the plot and margins
par(mfrow=c(1,1), mar = c(4, 4, 1, 1))
#plotting the histogram, with title and axis names, choosing colour
hist(mydata1$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     col = "red")
#managing the range of xaxis
xlabel <- seq(0, 6, by = 2)
axis(1, at = xlabel)
#managing the range of yaxis
ylabel <- seq(0, 1200, by = 200)
axis(2, at = ylabel)
#saving the plot as .png file, quietly
invisible(dev.copy(png, 'plot1.png'))
invisible(dev.off())
