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

## Plot 2 to .png
png(filename="plot2.png")
plot(twoDays$DateTime,twoDays$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()
