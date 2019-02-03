remove(list=ls())

# Download the data if it is missing 
# ASSUMES the working directory is top level of repo
dataDir <- 'data'
zipPath <- paste(dataDir, 'exdata_data_household_power_consumption.zip', sep='/')
if(!dir.exists(dataDir) || !file.exists(zipPath)){
  dir.create(dataDir)
  
  dataUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(dataUrl, zipPath)
  
  unzip(zipPath, exdir=dataDir)
}

# Load the data
powerDF <- read.csv(paste(dataDir, 'household_power_consumption.txt', sep='/')
                    , header=TRUE, sep=';', na.strings="?")

# Extract the Dates we care about for this plot
powerDF <- powerDF[powerDF$Date %in% c('1/2/2007','2/2/2007'),]

# Create a new timestamp column from Time and Date
powerDF$DateTime <- as.POSIXct(paste(powerDF$Date, powerDF$Time), format='%d/%m/%Y %H:%M:%S')

# Create the plot
png(filename="plot4.png")

# Set the lattice and reset the margins (just in case the previous graphs messed with them)
par(mfrow=c(2,2), bg=NA, mar=c(5, 4, 4, 2) + 0.1)

# TOP LEFT: Same as plot 1
plot(powerDF$DateTime, powerDF$Global_active_power
     , type='l'
     , ylab='Global Active Power'
     , xlab='')

# TOP RIGHT: Same as plot 1 but plotting Voltage + x-axis label
plot(powerDF$DateTime, powerDF$Voltage
     , type='l'
     , ylab='Voltage'
     , xlab='datetime')

# BOTTOM LEFT: Same as plot 2 but legend does not have a border and has clear background
plot(powerDF$DateTime, powerDF$Sub_metering_1
     , type='l'
     , ylab='Energy sub metering'
     , xlab='')

lines(powerDF$DateTime, powerDF$Sub_metering_2, col='red')
lines(powerDF$DateTime, powerDF$Sub_metering_3, col='blue')

legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'), lty=c(1,1,1), box.lty=0, bg='transparent')

# BOTTOM RIGHT: Same as plot 1 but plotting Global_reactive_power + x-axis label
plot(powerDF$DateTime, powerDF$Global_reactive_power
     , type='l'
     , ylab='Global_reactive_power'
     , xlab='datetime')


dev.off()
