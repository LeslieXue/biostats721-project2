# BIOS721 Project 2
# Exploratory Data Analysis

# 1. Load packages
library(tidyverse)
library(lubridate)

# 2. Import raw data
aq_2018 <- read_csv("data/raw/AQ_2018.csv")
aq_2019 <- read_csv("data/raw/AQ_2019.csv")
aq_2020 <- read_csv("data/raw/AQ_2020.csv")

# 3. Inspect data structure
glimpse(aq_2018)
glimpse(aq_2019)
glimpse(aq_2020)

head(aq_2018)

# 4. Check exact duplicate rows
sum(duplicated(aq_2018))
sum(duplicated(aq_2019))
sum(duplicated(aq_2020))

# 5. Count unique dates
n_distinct(aq_2018$Date)
n_distinct(aq_2019$Date)
n_distinct(aq_2020$Date)

# 6. Identify dates with multiple records
aq_2018 %>%
  count(Date) %>%
  filter(n > 1) %>%
  arrange(desc(n))

# 7. Check missing values
colSums(is.na(aq_2018))
colSums(is.na(aq_2019))
colSums(is.na(aq_2020))

# 8. Check negative pollutant concentrations

pollutants <- c(
  "Daily Max 8-hour CO Concentration",
  "Daily Mean PM2.5 Concentration",
  "Daily Max 8-hour Ozone Concentration"
)

sapply(aq_2018[pollutants], function(x) sum(x < 0, na.rm = TRUE))
sapply(aq_2019[pollutants], function(x) sum(x < 0, na.rm = TRUE))
sapply(aq_2020[pollutants], function(x) sum(x < 0, na.rm = TRUE))

# 9. Test the data cleaning function

source("R/02_clean_data.R")

# Clean 2018 data using default O3 unit (ppm)
clean_2018 <- clean_air_quality("data/raw/AQ_2018.csv")

# Test O3 conversion to ppb
clean_2018_ppb <- clean_air_quality(
  "data/raw/AQ_2018.csv",
  o3_unit = "ppb"
)

# Check the conversion
head(clean_2018_ppb)

all.equal(
  clean_2018_ppb$o3,
  clean_2018$o3 * 1000
)


# 10. Clean and combine all three years

# Clean each year's data
clean_2018 <- clean_air_quality("data/raw/AQ_2018.csv")
clean_2019 <- clean_air_quality("data/raw/AQ_2019.csv")
clean_2020 <- clean_air_quality("data/raw/AQ_2020.csv")

# Combine all years
aq_clean <- bind_rows(
  clean_2018,
  clean_2019,
  clean_2020
)

# Add year and month variables
aq_clean <- aq_clean %>%
  mutate(
    year = year(date),
    month = month(date)
  )

# Inspect the combined dataset
glimpse(aq_clean)
head(aq_clean)

# 11. Validate the combined dataset

# Count observations by year
aq_clean %>%
  count(year)

# Check for duplicate dates
sum(duplicated(aq_clean$date))

# Check for negative concentrations
aq_clean %>%
  summarise(
    negative_co = sum(co < 0, na.rm = TRUE),
    negative_pm25 = sum(pm25 < 0, na.rm = TRUE),
    negative_o3 = sum(o3 < 0, na.rm = TRUE)
  )

# Check the date range
range(aq_clean$date)

