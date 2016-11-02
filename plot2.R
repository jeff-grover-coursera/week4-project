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


# Plot
## Have total emissions from PM2.5 decreased in Baltimore City, MD from 1999 to 2008?
## Use the base plotting system to make a plot answering this question.
## Baltimore City, MD FIPS = 24510

## Isolate Baltimore data and sum emissions by year
plot2data <- 
      NEI %>% 
      filter(fips==24510) %>%
      group_by(year) %>%
      summarize(Emissions = sum(Emissions))

## Make plot
png("plot2.png")
plot(plot2data$year, plot2data$Emissions, 
     type = "l",
     xlab = "Year",
     ylab = "Tons of PM2.5 emissions",
     main = "Total PM 2.5 Emissions by Year in Baltimore")
dev.off()

# Total PM2.5 emissions in Baltimore mostly decreased from 1999 to 2008.