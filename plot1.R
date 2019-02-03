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

# Create the plot
png(filename="plot1.png")

# Make the background of the plot transparent
par(bg=NA)

# The default histogram works great as is for this plot, just need to make the bars red!
hist(powerDF$Global_active_power
     , col='red'
     , main='Global Active Power'
     , xlab='Global Active Power (kilowatts)')

dev.off()
