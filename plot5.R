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
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

## Merge in EI.Sector variable to identify source
SCC.code.EI.Sector <- select(SCC, SCC, EI.Sector) # Takes a minute
NEI.EI.Sector <- merge(NEI, SCC.code.EI.Sector, by="SCC", all.x=TRUE) #Also takes a minute

## Isolate Baltimore City motor vehicle sources
## Counting four EI.Sector groups: On-Road, both Diesel and Gasoline, both Heavy Duty and Light Duty Vehicles
NEI.EI.Sector$sector <- toString(NEI.EI.Sector$EI.Sector)
plot5data <- NEI.EI.Sector %>%
      filter(str_detect(EI.Sector, "Mobile - On-Road"), fips==24510) %>%
      group_by(year) %>%
      summarize(Emissions = sum(Emissions))

png("plot5.png")
with(plot5data, plot(year, Emissions,
                     type = "l",
                     xlab = "Year",
                     ylab = "Total Motor Vehicle Emissions in Baltimore City",
                     main = "Total Motor Vehicle Emissions in Baltimore City from 1999-2008")
)
dev.off()

## Total motor vehicle emissions in Baltimore City have decreased from 1999 to 2008.