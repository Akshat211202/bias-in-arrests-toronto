#### Preamble ####
# Purpose: Downloading and saving the data from OpenData Toronto for Police Race and Identity Based Data Collection: Arrests & Strip Searches
# Author: Akshat Aneja
# Date: 23 September 2024
# Contact: akshat.aneja@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Datasets: https://open.toronto.ca/dataset/police-race-and-identity-based-data-collection-arrests-strip-searches/

#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Clean data ####
data <- read.csv(here::here("data/01-raw_data/raw_data.csv"))

cleaned_data <- data |>
  select(
    Arrest_Year, Perceived_Race, Age_group__at_arrest_, Youth_at_arrest__under_18_years, Booked, SearchReason_CauseInjury, SearchReason_AssistEscape, SearchReason_PossessWeapons, SearchReason_PossessEvidence)

cleaned_data <- cleaned_data %>%
  mutate(search_reason = case_when(
    SearchReason_CauseInjury == 1 ~ "1",
    SearchReason_AssistEscape == 1 ~ "1",
    SearchReason_PossessWeapons == 1 ~ "1",
    SearchReason_PossessEvidence == 1 ~ "1",
    TRUE ~ "0"
  ))

cleaned_data <- cleaned_data %>%
  rename(
    age_group = Age_group__at_arrest_,
    youth_at_arrest_under_18_years = Youth_at_arrest__under_18_years
  )

cleaned_data <- cleaned_data %>%
  mutate(age_group = case_when(
    age_group == "Aged 17 years and younger" ~ "Under 17",
    age_group == "Aged 17 years and under" ~ "Under 17",
    TRUE ~ age_group
  ))

cleaned_data <- cleaned_data %>%
  mutate(booked = case_when(
    is.na(Booked) ~ "0",
    Booked == 1 ~ "1",
    TRUE ~ "Not Booked"
  ))

#### Cleaned Data Conversion to Numeric ####

# Convert arrest_year, search_reason, and booked to numeric
cleaned_data <- cleaned_data |>
  select(
    Arrest_Year, age_group, booked, search_reason, Perceived_Race, youth_at_arrest_under_18_years) |>
  rename(
    arrest_year = Arrest_Year,
    perceived_race = Perceived_Race,
    minor = youth_at_arrest_under_18_years
  ) |>
  mutate(
    arrest_year = as.numeric(arrest_year),
    search_reason = as.numeric(search_reason),
    booked = as.numeric(booked)
  )


write.csv(cleaned_data, here::here("data/02-analysis_data/analysis_data.csv"), row.names = FALSE)
write_parquet(cleaned_data, here::here("data/02-analysis_data/analysis_data.parquet"))
