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

#plot1
png("plot1.png", width = 480, height = 480)
hist(df$Global_active_power, xlab="Global active power (kilowatts)", ylab="Frequency",col="red", main="Global active power", xlim=c(0,6), ylim=c(0,1200))
dev.off()