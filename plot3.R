#opening the file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- file.path(getwd(),"household_power_consumption.zip")
download.file(url, file, method = "curl")
doc <- read.csv(unz(file,"household_power_consumption.txt"), header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

#subsetting the file
doc$Date <- as.Date(doc$Date, format = "%d/%m/%Y")
dtConsume <-subset(doc, doc$Date >= "2007-02-01 " & doc$Date <= "2007-02-02")
datetime <- paste(as.Date(dtConsume$Date), dtConsume$Time)
dtConsume$Datetime <- as.POSIXct(datetime)


#plotting and saving the file
dev.copy(png, file="plot3.png", height=480, width=480)
png("plot3.png")
par(mar= c(4, 4, 2, 1))
plot(dtConsume$Sub_metering_1~dtConsume$Datetime, type="l",ylab="Energy sub metering", xlab="", col = "Black")
lines(dtConsume$Sub_metering_2~dtConsume$Datetime,col = "Red")
lines(dtConsume$Sub_metering_3~dtConsume$Datetime,col = "Blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()