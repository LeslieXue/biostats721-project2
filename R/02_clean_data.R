# Clean daily air quality data for a single year.
# Args:
#   file_path: Path to the raw CSV file.
#   o3_unit: Desired O3 unit, "ppm" (default) or "ppb".
# Returns:
#   A clean tibble with one row per date and daily mean
#   concentrations for CO, PM2.5, and O3.

# Load required packages
library(tidyverse)
library(lubridate)

clean_air_quality <- function(file_path, o3_unit = "ppm") {
  
  # Validate the requested O3 unit
  o3_unit <- match.arg(o3_unit, c("ppm", "ppb"))
  
  # Read data and remove exact duplicate rows
  data <- read_csv(file_path, show_col_types = FALSE) %>%
    distinct()
  
  # Rename variables and convert dates
  data <- data %>%
    transmute(
      date = mdy(Date),
      co = `Daily Max 8-hour CO Concentration`,
      pm25 = `Daily Mean PM2.5 Concentration`,
      o3 = `Daily Max 8-hour Ozone Concentration`
    )
  
  # Replace negative concentrations with zero
  data <- data %>%
    mutate(
      across(c(co, pm25, o3), ~ pmax(.x, 0))
    )
  
  # Calculate daily averages
  data <- data %>%
    group_by(date) %>%
    summarise(
      across(
        c(co, pm25, o3),
        ~ if (all(is.na(.x))) NA_real_
        else mean(.x, na.rm = TRUE)
      ),
      .groups = "drop"
    )
  
  # Convert O3 from ppm to ppb if requested
  if (o3_unit == "ppb") {
    data <- data %>%
      mutate(o3 = o3 * 1000)
  }
  
  # Sort by date and return the clean tibble
  data %>%
    arrange(date)
}