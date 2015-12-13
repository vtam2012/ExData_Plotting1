#download and read in data into a dataframe
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header= T, sep=";",na.strings= "?")
unlink(temp)

#change the date format
data$Date<-as.Date(data$Date, "%d/%m/%Y")

#subset the data to only include the first two days of February in the year 2007
subdata<-subset(data,data$Date == "2007-02-01" | data$Date == "2007-02-02")

#Format the date and time
subdata$DateAndTime <- paste(subdata$Date, subdata$Time, sep=" ")
subdata$DateAndTime <- strptime(subdata$DateAndTime, "%Y-%m-%d %H:%M:%S")

#plot the png file
png("plot3.png", width= 480, height= 480)
plot(subdata$DateAndTime,subdata$Sub_metering_1, type= "l", xlab= "", ylab= "Energy sub metering", col= "black")
lines(subdata$DateAndTime,subdata$Sub_metering_2,col="red")
lines(subdata$DateAndTime,subdata$Sub_metering_3,col="blue")
legend("topright", legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"), lwd= 1)
dev.off()