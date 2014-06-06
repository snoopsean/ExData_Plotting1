#plot2.R

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

# this gets a line plot of Time vs Global-active-power
png(file="plot2.png",width=480,height=480)
par(mfrow=c(1,1))
plot(myData[,"PosixTime"],myData[,"Global_active_power"],type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()