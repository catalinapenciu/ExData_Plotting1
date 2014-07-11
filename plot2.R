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

#plot2
png("plot2.png", width = 480, height = 480)
plot(Global_active_power ~ new_d, df, type="l",yaxt="n", ylab="Global active power (kilowatts)", xlab="", ylim=c(0,8))
axis(2, at=c(0,2,4,6), labels=c(0,2,4,6))
dev.off()



