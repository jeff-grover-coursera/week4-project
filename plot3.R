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
## Of the four types of sources indicated by the type variable (point, nonpoint, onroad, nonroad),
## which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
## Which have seen increases in emissions from 1999-2008?
## Use the ggplot2 plotting system to make a plot to answer this question.

## Isolate Baltimore data
plot3data <- NEI %>% 
      filter(fips==24510) %>% 
      group_by(year, type) %>% 
      summarize(Emissions = sum(Emissions))

png("plot3.png")
ggplot(plot3data, aes(x=year, y=Emissions)) +
      geom_line(aes(color = type))
dev.off()