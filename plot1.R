#create a png of histogram of Global Active Power
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./household_power_consumption2.txt")
file <- read.table(unz("household_power_consumption2.txt", "household_power_consumption.txt") , sep = ";", skip = 60000, nrows = 30000, colClasses = "character")
file$V1 <- as.Date(file$V1, format = "%d/%m/%Y")
#filter down to the 2 days
mydata <- file[file$V1 >= "2007-02-01" & file$V1 < "2007-02-03",]
mydata[,3] <- as.numeric(mydata[,3])
w <- mydata[,3]
hist(w, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
#create a png file of our histogram
dev.copy(png, file = "plot1.png")
dev.off()