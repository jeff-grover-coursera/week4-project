# Preamble
library(tidyverse)

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

## Replace levels of SCC with names?
#levels(NEI$SCC)


# Plot
## Have total emissions from PM2.5 decreased in the US from 1999 to 2008?
## Use the base plotting system, plot the total PM2.5 emission from all sources
## for each of the years 1999, 2002, 2005, and 2008.

## Sum emissions by year
plot1data <- 
      NEI %>% 
      group_by(year) %>%
      summarize(Emissions = sum(Emissions))

## Make plot
png(plot1.png)
plot(plot1data$year, plot1data$Emissions, 
     type = "l",
     xlab = "Year",
     ylab = "Tons of PM2.5 emissions",
     main = "Total PM 2.5 Emissions by Year")

# Total PM2.5 emissions decreased from 1999 to 2008.
