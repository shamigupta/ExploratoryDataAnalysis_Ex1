# Create sub directory for PNG Files in current working directory if it doesn't exist
if(!file.exists("./Output")){dir.create("./Output")}

# File access and data frame build - Downloaded Unzipped and saved in working folder
fhpc <- file("household_power_consumption.txt")
hpc <- read.table(text = grep("^[1,2]/2/2007", readLines(fhpc), value = TRUE), sep = ";", header = TRUE)
close(fhpc)
colnames <- read.table("household_power_consumption.txt",nrows=1,sep=";",header=TRUE)               
names(hpc) <- names(colnames)

# Draw Plot 3
datetime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")
hpc <- cbind(hpc,datetime)
with(hpc, {
  plot(Sub_metering_1 ~ datetime, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ datetime, col = 'Red')
  lines(Sub_metering_3 ~ datetime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))  
})
dev.copy(png, file = "./Output/plot3.png")
dev.off()
