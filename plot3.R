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
png(filename="plot3.png")

# Setting the margins so we get a bit more graph in the output as we dont have an x-axis label
par(mar=c(2,4,4,2), bg=NA)

# Make a line plot (type='l')
plot(powerDF$DateTime, powerDF$Sub_metering_1
     , type='l'
     , ylab='Energy sub metering'
     , xlab='')

# Call lines to plot the two additional lines
lines(powerDF$DateTime, powerDF$Sub_metering_2, col='red')
lines(powerDF$DateTime, powerDF$Sub_metering_3, col='blue')

# Add the legend with appropriate labels, colors, and lines
legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'), lty=c(1,1,1))

dev.off()
