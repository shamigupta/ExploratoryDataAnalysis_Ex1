# Create sub directory for PNG Files in current working directory if it doesn't exist
if(!file.exists("./Output")){dir.create("./Output")}

# File access and data frame build - Downloaded Unzipped and saved in working folder
fhpc <- file("household_power_consumption.txt")
hpc <- read.table(text = grep("^[1,2]/2/2007", readLines(fhpc), value = TRUE), sep = ";", header = TRUE)
close(fhpc)
colnames <- read.table("household_power_consumption.txt",nrows=1,sep=";",header=TRUE)               
names(hpc) <- names(colnames)

# Draw Plot 2
datetime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")
hpc <- cbind(hpc,datetime)
plot(data=hpc, Global_active_power ~ datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file = "./Output/plot2.png")
dev.off()
