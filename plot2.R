#Create a line graph of Kilowatt Global power, minute by minute, for 2 days
#download file from internet & unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./household_power_consumption2.txt")
file <- read.table(unz("household_power_consumption2.txt", "household_power_consumption.txt") , sep = ";", skip = 60000, nrows = 30000, colClasses = "character")
file$V1 <- as.Date(file$V1, format = "%d/%m/%Y")

mydata <- file[file$V1 >= "2007-02-01" & file$V1 < "2007-02-03",]
a <- mydata[,1]
b <- mydata[,2]
#create a time variable by combinng date & time
mydata$Combo <- paste(a,b)
#turn the column numeric
mydata[,3] <- as.numeric(mydata[,3])
#gapk is our vector renamed stands for global active power in kilowatts
gapk <- mydata[,3]
c <- mydata$Combo
#creating a vector that converts our character string of date and time, into a time that includes date in it.
#so wednesday at noon is higher than tuesday at noon.
hy <- strptime(c, format = "%Y-%m-%d %H:%M:%S")
#create a line chart, type = "l"
plot(hy, gapk, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
#create a png file of our histogram
dev.copy(png, file = "plot2.png")
dev.off()
