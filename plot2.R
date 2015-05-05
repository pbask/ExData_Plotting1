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
dev.copy(png, file="plot2.png", height=480, width=480)
png("plot2.png")
par(mar= c(4, 4, 2, 1))
plot(dtConsume$Global_active_power~dtConsume$Datetime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
dev.off()