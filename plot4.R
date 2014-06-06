#plot4

#this section downloads the zip file and unzips it into the directory
zipUrl<-"http://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
zipFile<-"household_power_consumption.zip"
download.file(zipUrl,zipFile,method="auto")
unzip(zipFile)

# this section reads data for only the 2 dates in questions and saves 
# it as myData (which is a data.frame)
textFile<-"household_power_consumption.txt"
library(sqldf)
myData<-read.csv.sql(textFile,sql="select * from file where Date='1/2/2007' OR Date='2/2/2007'",header=TRUE,sep=";")

#this gets the POSIX time format, and adds that as a column to our myData data.frame
timevector1<-paste(myData[,"Date"],myData[,"Time"])
myData$PosixTime <- strptime(timevector1,format="%d/%m/%Y %H:%M:%S")

# this gets all 4 necessary plots. notice the third plot has
# two more 'lines' and a 'legend'
png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2))
with(myData, {
  plot(PosixTime,Global_active_power,type="l",xlab="",ylab="Global Active Power")
  plot(PosixTime,Voltage,type="l",xlab="datetime",ylab="Voltage")
  plot(PosixTime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
  lines(PosixTime,Sub_metering_2,col="red")
  lines(PosixTime,Sub_metering_3,col="blue")
  legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
  plot(PosixTime,Global_reactive_power,type="l",xlab="datetime")
})
dev.off()