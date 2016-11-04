# Preamble
library(tidyverse)
library(stringr)

# Import data
wd <- "/Users/jeffgrover/Dropbox/Coursera/4 Exploratory Data Analysis/week4-project"
setwd(wd)
NEI <- readRDS(paste0(wd,"/exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds"))
SCC <- readRDS(paste0(wd,"/exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds"))


# Clean data
## Convert string variables to factors
NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)


# Plot
## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, California.
## Which city has seen greater changes over time in motor vehicle emissions?

## Merge in EI.Sector variable to identify source
SCC.code.EI.Sector <- select(SCC, SCC, EI.Sector) # Takes a minute
NEI.EI.Sector <- merge(NEI, SCC.code.EI.Sector, by="SCC", all.x=TRUE) #Also takes a minute

## Isolate Baltimore City and Los Angeles County motor vehicle sources
## Counting four EI.Sector groups: On-Road, both Diesel and Gasoline, both Heavy Duty and Light Duty Vehicles
NEI.EI.Sector$sector <- toString(NEI.EI.Sector$EI.Sector)
plot6data <- NEI.EI.Sector %>%
      filter(str_detect(EI.Sector, "Mobile - On-Road") & fips %in% c("24510", "06037")) %>%
      group_by(year, fips) %>%
      summarize(Emissions = sum(Emissions))

png("plot6.png")
with(plot6data, {
     plot(year, Emissions, 
     type = "n", 
     xlab = "Year",
     ylab = "Total Motor Vehicle Emissions (tons)", 
     main = "Total Motor Vehicle Emissions in Baltimore City and LA County from 1999-2008")
     lines(year[fips==24510], Emissions[fips==24510], col="blue")
     lines(year[fips=="06037"], Emissions[fips=="06037"], col="red") # For some reason, 24510 turned into an integer but 06037 stayed as a string
     })
dev.off()

## Total motor vehicle emissions in Baltimore City have decreased from 1999 to 2008.