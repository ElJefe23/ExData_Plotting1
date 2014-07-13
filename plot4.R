## Data loading and parsing.
if (file.exists("./twoDays.RData")) {
  load("./twoDays.RData")
} else {
  dfData<-read.table("household_power_consumption.txt",sep=";",na.strings="?",header=TRUE,stringsAsFactors=FALSE)
  twoDays<-subset(dfData,dfData$Date=="1/2/2007" | dfData$Date=="2/2/2007")
  dateTime<-paste(twoDays$Date,twoDays$Time)
  newDateTime<-strptime(dateTime,"%d/%m/%Y %H:%M:%S")
  twoDays$DateTime<-newDateTime
  save(twoDays,file="./twoDays.RData")
}

## The 2x2 plots to .png
png(filename="plot4.png")
par(mfrow=c(2,2))
hist(twoDays$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
plot(twoDays$DateTime,twoDays$Voltage,type="l",ylab="Voltage",col="black",xlab="datetime")
plot(twoDays$DateTime,twoDays$Sub_metering_1,type="l",ylab="Energy sub metering",col="black",xlab="")
points(twoDays$DateTime,twoDays$Sub_metering_2,type="l",col="red")
points(twoDays$DateTime,twoDays$Sub_metering_3,type="l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_Metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n")
plot(twoDays$DateTime,twoDays$Global_reactive_power,type="l",ylab="Global_reactive_power",col="black",xlab="datetime")
dev.off()
