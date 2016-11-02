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
## Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

## Add EI.Sector variable from SCC dataset to NEI dataset
SCC.code.EI.Sector <- select(SCC, SCC, EI.Sector)
NEI.EI.Sector <- merge(NEI, SCC.code.EI.Sector, by="SCC", all.x=TRUE)

## Isolate coal combustion observations
NEI.EI.Sector$coal.observations <- grepl("- Coal", toString(NEI.EI.Sector$EI.Sector))
plot4data <- NEI.EI.Sector %>%
      filter(NEI.EI.Sector$EI.Sector)))