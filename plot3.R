
# Download and unzip data:
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileURL, temp, method = "curl")

unzip(temp)
unlink(temp)

rm(fileURL)
rm(temp)

#Reading the data into a data frame:
classes<-sapply(read.table("household_power_consumption.txt", header = TRUE, sep=";",nrow=1),class)
powerConsTemp<-read.table("household_power_consumption.txt", header = TRUE, sep=";",na.strings = c("?"),colClasses = classes)

#We only need the data from the relevant dates:
indices<-grep("^[12]/2/2007",powerConsTemp$Date)
powerCons<-powerConsTemp[indices, ]


#Convert date and time into Date and Time formats:
powerCons$Date<-as.Date(powerCons$Date,format="%d/%m/%Y")
powerCons$timetemp <- paste(powerCons$Date, powerCons$Time) 
powerCons$Time <- strptime(powerCons$timetemp, format = "%Y-%m-%d %H:%M:%S")  
powerCons$NewTime <- as.POSIXct(powerCons$Time)
head(powerCons$Date)
head(powerCons$timetemp)
head(powerCons$NewTime)
class(powerCons$NewTime)

#Create the plot 
png(file = "plot2.png")  
with(powerCons, plot(
  Time,Sub_metering_1, 
  type = "l",
  ylab = "Energy sub metering")
)
dev.off()  


