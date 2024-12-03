#### Preamble ####
# Purpose: Testing the analysis data from OpenData Toronto on Police Race and Identity-Based Data Collection: Arrests and Strip Searches.
# Author: Akshat Aneja
# Date: 3 December 2024
# Contact: akshat.aneja@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Datasets: https://open.toronto.ca/dataset/police-race-and-identity-based-data-collection-arrests-strip-searches/


#### Workspace setup ####
library(tidyverse)

arrest_data <- read.csv(here::here("data/02-analysis_data/analysis_data.csv"))

# 1. Check if 'arrest_year' is numeric
is_arrest_year_numeric <- all(as.numeric(arrest_data$arrest_year) == arrest_data$arrest_year)

# 2. Validate that 'booked' is numeric
is_booked_numeric <- all(as.numeric(arrest_data$booked) == arrest_data$booked)

# 3. Validate that 'search_reason' is numeric
is_search_reason_numeric <- all(as.numeric(arrest_data$search_reason) == arrest_data$search_reason)

# 4. Check if 'age_group' is of class character
is_age_group_character <- class(arrest_data$age_group) == "character"

# 5. Check if 'perceived_race' is of class character
is_perceived_race_character <- class(arrest_data$perceived_race) == "character"

# 6. Check if 'minor' is of class character
is_minor_character <- class(arrest_data$minor) == "character"

# 7. Validate that 'booked' values are between 0 and 1
valid_booked_values <- all(arrest_data$booked >= 0 & arrest_data$booked <= 1)

# 8. Validate that 'arrest_year' values are in a reasonable range
valid_arrest_year_values <- all(arrest_data$arrest_year >= 2020 & arrest_data$arrest_year <= 2021)

# 9. Validate that 'search_reason' values are binary (0 or 1)
valid_search_reason_values <- all(arrest_data$search_reason >= 0 & arrest_data$search_reason <= 1)

# 10. Check for missing values in the dataset
no_missing_values <- all(complete.cases(arrest_data))

# 11. Validate 'booked' column as logical or numeric
booked_logical <- is.logical(arrest_data$booked) || is.numeric(arrest_data$booked)

# 12. Validate 'search_reason' column as logical or numeric
search_reason_logical <- is.logical(arrest_data$search_reason) || is.numeric(arrest_data$search_reason)

# 13. Validate that 'arrest_year' does not exceed the current year
valid_years <- all(arrest_data$arrest_year <= as.numeric(format(Sys.Date(), "%Y")))

# 14. Validate the dataset is not empty
non_empty_dataset <- nrow(arrest_data) > 0

# 15. Validate that 'arrest_year' values are above 1900
valid_arrest_year <- all(arrest_data$arrest_year > 1900)

# Check all conditions
all_conditions <- all(
  is_arrest_year_numeric,
  is_booked_numeric,
  is_search_reason_numeric,
  is_age_group_character,
  is_perceived_race_character,
  is_minor_character,
  valid_booked_values,
  valid_arrest_year_values,
  valid_search_reason_values,
  no_missing_values,
  booked_logical,
  search_reason_logical,
  valid_years,
  non_empty_dataset,
  valid_arrest_year
)

# Assert the result
if (all_conditions) {
  print("All conditions are satisfied.")
} else {
  print("One or more conditions failed.")
}




