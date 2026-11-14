# BIOS721 Project 2: Air Quality Data Analysis

## Project Description

This project analyzes daily air pollutant concentrations measured at RDU Airport in North Carolina from January 2018 through April 2020.

The project includes data cleaning, calculation of daily averages, summary statistics, and visualizations to explore monthly and yearly patterns in carbon monoxide (CO), fine particulate matter (PM2.5), and ozone (O3).

## Data Source

The air quality data were obtained from the Environmental Protection Agency (EPA) air pollution monitor at RDU Airport.

The dataset consists of three CSV files:

- `AQ_2018.csv`: January–December 2018
- `AQ_2019.csv`: January–December 2019
- `AQ_2020.csv`: January–April 2020

## File Structure

- `data/raw/`: Original air quality CSV files.
- `R/01_explore_data.R`: Initial data exploration and validation.
- `R/02_clean_data.R`: Reusable function for cleaning daily air quality data.
- `report/Project2_Report.Rmd`: RMarkdown source for the analysis and report.
- `report/Project2_Report.docx`: Final Word report generated from RMarkdown.
- `README.md`: Project documentation.

## How to Reproduce

1. Clone or download this GitHub repository.
2. Open `biostat721-project2.Rproj` in RStudio.
3. Install the required R packages if necessary:

   `install.packages(c("tidyverse", "lubridate", "knitr", "here", "rmarkdown"))`

4. Open `report/Project2_Report.Rmd`.
5. Click **Knit to Word** to run the analysis and generate the Word report.

The report automatically imports the raw CSV files, applies the cleaning function, and generates summary tables and plots.

## Author

Jiaxiang Xue

November 2026