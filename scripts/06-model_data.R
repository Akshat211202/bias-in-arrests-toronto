#### Preamble ####
# Purpose: Modelling the data from OpenData Toronto on Police Race and Identity-Based Data Collection: Arrests and Strip Searches.
# Author: Akshat Aneja
# Date: 3 December 2024
# Contact: akshat.aneja@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Datasets: https://open.toronto.ca/dataset/police-race-and-identity-based-data-collection-arrests-strip-searches/



#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####

cleaned_data = read.csv(here::here("data/02-analysis_data/analysis_data.csv"))

arrest_data <-
  cleaned_data |>
  filter(!perceived_race == "None") |>
  group_by(arrest_year, perceived_race) |> 
  summarise(n = n(), .groups = "drop") |> 
  arrange(desc(n)) |> 
  pivot_wider(names_from = arrest_year, values_from = n, values_fill = 0) |>
  rename(arrests_2020 = '2020', arrests_2021 = '2021')

booked_data <-
  cleaned_data |>
  filter(booked == 1) |>
  filter(!perceived_race == "None") |>
  group_by(arrest_year, perceived_race) |>
  summarise(n = n(), .groups = "drop") |>
  arrange(desc(n)) |>
  pivot_wider(names_from = arrest_year, values_from = n, values_fill = 0) |>
  rename(booked_2020 = '2020', booked_2021 = '2021')

combined_data <- merge(arrest_data, booked_data, by = "perceived_race")

# Calculate booking probability for each year
combined_data$prob_2020 <- combined_data$booked_2020 / combined_data$arrests_2020
combined_data$prob_2021 <- combined_data$booked_2021 / combined_data$arrests_2021

# Reshape the data into a long format
long_data <- combined_data %>%
  pivot_longer(cols = c(prob_2020, prob_2021),
               names_to = "year",
               values_to = "booking_prob")

# Convert 'year' and 'perceived_race' to factors for the model
long_data$year <- as.factor(long_data$year)  # Ensure 'year' is a factor
long_data$perceived_race <- as.factor(long_data$perceived_race)  # Ensure 'perceived_race' is a factor

### Model data ####
# Fit the Bayesian logistic regression model for both years
model <- stan_glm(
  booking_prob ~ perceived_race + year,
  data = long_data,                 
  family = binomial(link = "logit"),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 157,
  chains = 4,                             
  iter = 2000,                            
)

# #### Save model ####
saveRDS(
  model,
  file = here::here("models/racial_model.rds")
)


