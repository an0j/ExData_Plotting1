











## Download the file

filename <- "powerConsumption.zip"  
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, filename)


## Unzip the downloaded file

unzip(filename)


## Estimate memory requirements
#  memory requirement = number of columns * number of rows * 8 bytes(if numeric) / 2^20
#  9 * 2,075,259 * 8 / 2^20 = ~ 142MB


## Reading and loading the data

householdConsumption <- read.table("household_power_consumption.txt", header = TRUE,
                                   sep = ";", stringsAsFactors = FALSE, na.strings = "?")


## Adding date time column to householdConsumption

dateTime <- strptime(paste(householdConsumption$Date, 
                           householdConsumption$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
householdConsumption <- cbind(householdConsumption, dateTime)


## Correcting class type per columns

householdConsumption$Date <- as.Date(householdConsumption$Date, format = "%d/%m/%Y")
householdConsumption$Time <- format(householdConsumption$Time, format = "%H:%M:%S")
householdConsumption$Global_active_power <- as.numeric(householdConsumption$Global_active_power)
householdConsumption$Global_reactive_power <- as.numeric(householdConsumption$Global_reactive_power)
householdConsumption$Voltage <- as.numeric(householdConsumption$Voltage)
householdConsumption$Global_intensity <- as.numeric(householdConsumption$Global_intensity)
householdConsumption$Sub_metering_1 <- as.numeric(householdConsumption$Sub_metering_1)
householdConsumption$Sub_metering_2 <- as.numeric(householdConsumption$Sub_metering_2)
householdConsumption$Sub_metering_3 <- as.numeric(householdConsumption$Sub_metering_3)


## subsetting

subHouseholdConsumption <- subset(householdConsumption, Date == "2007-02-01" | Date =="2007-02-02")


## plotting to png

# set device to png

png("plot2.png", width = 480, height = 480)


# plot command

with(subHouseholdConsumption, plot(dateTime, Global_active_power, type = "l", xlab = "",
                      ylab = "Global Active Power (kilowatts)"))


# turning off png device 

dev.off()

