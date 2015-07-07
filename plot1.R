# Create sub directory for Output(PNG) Files in current working directory if it doesn't exist
if(!file.exists("./Output")){dir.create("./Output")}

# File access and data frame build - Downloaded Unzipped and saved in working folder
fhpc <- file("household_power_consumption.txt")
hpc <- read.table(text = grep("^[1,2]/2/2007", readLines(fhpc), value = TRUE), sep = ";", header = TRUE)
close(fhpc)

colnames <- read.table("household_power_consumption.txt",nrows=1,sep=";",header=TRUE)               
names(hpc) <- names(colnames)

# Draw Plot 1 
hist(hpc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "./Output/plot1.png")
dev.off()