# Create sub directory for PNG Files in current working directory if it doesn't exist
if(!file.exists("./Output")){dir.create("./Output")}

# File access and data frame build - Downloaded Unzipped and saved in working folder
fhpc <- file("household_power_consumption.txt")
hpc <- read.table(text = grep("^[1,2]/2/2007", readLines(fhpc), value = TRUE), sep = ";", header = TRUE)
close(fhpc)
colnames <- read.table("household_power_consumption.txt",nrows=1,sep=";",header=TRUE)               
names(hpc) <- names(colnames)

# Draw Plot 4
datetime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")
hpc <- cbind(hpc,datetime)
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(1,0,1,0))
with(hpc, {
  plot(Global_active_power ~ datetime, type = "l", 
       ylab = "Global Active Power", xlab = "")
  plot(Voltage ~ datetime, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy sub metering",
       xlab = "")
  lines(Sub_metering_2 ~ datetime, col = 'Red')
  lines(Sub_metering_3 ~ datetime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ datetime, type = "l", 
       ylab = "Global_rective_power", xlab = "datetime")
})
dev.copy(png, file = "./Output/plot4.png")
dev.off()
