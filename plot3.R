#creates 3 line graphs on one plot, sub-metering energy 1, 2, 3 on minute by minute basis for 2 days
png(file = "plot3.png")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./household_power_consumption2.txt")
file <- read.table(unz("household_power_consumption2.txt", "household_power_consumption.txt") , sep = ";", skip = 60000, nrows = 30000, colClasses = "character")
file$V1 <- as.Date(file$V1, format = "%d/%m/%Y")
mydata <- file[file$V1 >= "2007-02-01" & file$V1 < "2007-02-03",]
a <- mydata[,1]
b <- mydata[,2]
#creates a time variable by combining date and minute
mydata$Combo <- paste(a,b)
mydata[,3] <- as.numeric(mydata[,3])
mydata[,7] <- as.numeric(mydata[,7])
mydata[,8] <- as.numeric(mydata[,8])
mydata[,9] <- as.numeric(mydata[,9])


#gapk is our vector renamed stands for global active power in kilowatts
gapk <- mydata[,3]
sub1 <- mydata[,7]
sub2 <- mydata[,8]
sub3 <- mydata[,9]

c <- mydata$Combo
#creating a vector that converts our character string of date and time, into a time that includes date in it.
#so wednesday at noon is higher than tuesday at noon.
hy <- strptime(c, format = "%Y-%m-%d %H:%M:%S")
#create a line chart, type = "l"
#create blank slate plot, no data yet
plot(hy, sub1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(hy, sub1)
lines(hy, sub2, col = "red")
lines(hy, sub3, col = "blue")
legend("topright" , legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))

#create a png file of our histogram
dev.off()
