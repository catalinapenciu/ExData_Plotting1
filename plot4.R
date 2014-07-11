con<-file(".\\exdata-data-household_power_consumption\\household_power_consumption.txt")
open(con)
data<-read.table(file=con, sep=";",na.strings="?",colClasses=c("character", "character", "double", "double", "double", "double", "double", "double", "double"), skip=1)
close(con)
colnames(data)<-c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  
df<-data[data$Date %in% c("1/2/2007","2/2/2007"),]
library(lubridate)
df$Date<-mdy(df$Date)
df$Date<-as.Date(df$Date)
df$new_d<-as.POSIXct(paste(df$Date, df$Time), format="%Y-%d-%m %H:%M:%S")

#plot4
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

plot(Global_active_power ~ new_d, df, type="l",yaxt="n", xlab="",ylab="Global Active Power", ylim=c(0,8))
axis(2, at=c(0,2,4,6), labels=c(0,2,4,6))

plot(Voltage ~ new_d, df, type="l",yaxt="n",ylab="Voltage", xlab="datetime", ylim=c(233,247))
axis(2, at=c(234,238,242,246), labels=c(234,238,242,246))

plot(Sub_metering_1 ~ new_d, df, type="l",yaxt="n", ylab="Energy sub metering", xlab="", ylim=c(0,40))
axis(2, at=c(0,10,20,30), labels=c(0,10,20,30))
par(new = TRUE)
plot(Sub_metering_2 ~ new_d, df, type="l",yaxt="n", ylab="Energy sub metering", xlab="", ylim=c(0,40), col="red")
par(new = TRUE)
plot(Sub_metering_3 ~ new_d, df, type="l",yaxt="n", ylab="Energy sub metering", xlab="", ylim=c(0,40), col="blue")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1:3, lwd=2, bty="n")

plot(Global_reactive_power ~ new_d, df, type="l",yaxt="n", xlab="datetime", ylim=c(0.0,0.5))
axis(2, at=c(0.0,0.1,0.2,0.3,0.4,0.5), labels=c("0.0",0.1,0.2,0.3,0.4,0.5))
dev.off()