library(sqldf)
zipUrl<-"http://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
zipFile<-"household_power_consumption.zip"
download.file(zipUrl,zipFile,method="auto")
unzip(zipFile)

textFile<-"household_power_consumption.txt"
myData<-read.csv.sql(textFile,sql="select * from file where Date='1/2/2007' OR Date='2/2/2007'",header=TRUE,sep=";")
png(file="plot1.png",width=480,height=480)
hist(myData$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()

#data<-read.table("./household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
#data[,"Date"]<-as.Date(data[,"Date"],format="%d/%m/%Y")
#mydata<-subset(data,Date=="2007-02-01" | Date=="2007-02-02")