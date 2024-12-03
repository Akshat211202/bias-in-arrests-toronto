#### Preamble ####
# Purpose: Downloading and storing data from OpenData Toronto on Police Race and Identity-Based Data Collection: Arrests and Strip Searches.
# Author: Akshat Aneja
# Date: 3 December 2024
# Contact: akshat.aneja@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Datasets: https://open.toronto.ca/dataset/police-race-and-identity-based-data-collection-arrests-strip-searches/


#### Workspace setup ####
library(tidyverse)
library(dplyr)

#### Simulate data ####
set.seed(1007901157)

# Define the number of rows to simulate
n <- 300

# Simulate the data
simulated_data <- data.frame(
  arrest_year = sample(c(2020, 2021), n, replace = TRUE),
  age_group = sample(c("Aged 18 to 24 years", "Aged 25 to 34 years", 
                       "Aged 35 to 44 years", "Aged 45 to 54 years", 
                       "Aged 55 years and older"), n, replace = TRUE),
  booked = sample(c(0, 1), n, replace = TRUE),
  search_reason = sample(0:1, n, replace = TRUE),
  perceived_race = sample(c("White", "Black", "South Asian", 
                            "East Asian", "Hispanic", "Unknown or Legacy"), n, replace = TRUE),
  minor = sample(c("Not a youth", "Youth"), n, replace = TRUE)
)


## Write the simulated data
write.csv(simulated_data, here::here("data/00-simulated_data/simulated_data.csv"), row.names = FALSE)




