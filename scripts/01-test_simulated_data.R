#### Preamble ####
# Purpose: Testing the simulated data from OpenData Toronto on Police Race and Identity-Based Data Collection: Arrests and Strip Searches.
# Author: Akshat Aneja
# Date: 3 December 2024
# Contact: akshat.aneja@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Datasets: https://open.toronto.ca/dataset/police-race-and-identity-based-data-collection-arrests-strip-searches/



#### Workspace setup ####
library(tidyverse)
library(testthat)

analysis_data <- read_csv("data/00-simulated_data/simulated_data.csv", show_col_types = FALSE)


# Test 1: Dataset is a data frame
test_that("Dataset is a data frame", {
  expect_true(is.data.frame(simulated_data))
})

# Test 2: Number of columns is correct
test_that("Number of columns is correct", {
  expect_equal(ncol(simulated_data), 6)
})

# Test 3: Column names are correct
test_that("Column names are correct", {
  expect_equal(colnames(simulated_data), 
               c("arrest_year", "age_group", "booked", 
                 "search_reason", "perceived_race", "minor"))
})

# Test 4: `arrest_year` contains only 2020 or 2021
test_that("`arrest_year` contains only 2020 or 2021", {
  expect_true(all(simulated_data$arrest_year %in% c(2020, 2021)))
})

# Test 5: `age_group` contains only valid categories
test_that("`age_group` contains only valid categories", {
  valid_age_groups <- c("Aged 18 to 24 years", "Aged 25 to 34 years", 
                        "Aged 35 to 44 years", "Aged 45 to 54 years", 
                        "Aged 55 years and older")
  expect_true(all(simulated_data$age_group %in% valid_age_groups))
})

# Test 6: `booked` contains only 0 or 1
test_that("`booked` contains only 0 or 1", {
  expect_true(all(simulated_data$booked %in% c(0, 1)))
})

# Test 7: `search_reason` contains only 0 or 1
test_that("`search_reason` contains only 0 or 1", {
  expect_true(all(simulated_data$search_reason %in% c(0, 1)))
})

# Test 8: `perceived_race` contains only valid categories
test_that("`perceived_race` contains only valid categories", {
  valid_races <- c("White", "Black", "South Asian", 
                   "East Asian", "Hispanic", "Unknown or Legacy")
  expect_true(all(simulated_data$perceived_race %in% valid_races))
})

# Test 9: `minor` contains only valid categories
test_that("`minor` contains only valid categories", {
  expect_true(all(simulated_data$minor %in% c("Not a youth", "Youth")))
})

# Test 10: No missing values in the dataset
test_that("No missing values in the dataset", {
  expect_true(all(!is.na(simulated_data)))
})

# Test 11: `arrest_year` is numeric
test_that("`arrest_year` is numeric", {
  expect_true(is.numeric(simulated_data$arrest_year))
})

# Test 12: `age_group` is a factor or character
test_that("`age_group` is a factor or character", {
  expect_true(is.character(simulated_data$age_group) || is.factor(simulated_data$age_group))
})

# Test 13: `booked` is numeric
test_that("`booked` is numeric", {
  expect_true(is.numeric(simulated_data$booked))
})

# Test 14: `search_reason` is numeric
test_that("`search_reason` is numeric", {
  expect_true(is.numeric(simulated_data$search_reason))
})

# Test 15: `perceived_race` is a factor or character
test_that("`perceived_race` is a factor or character", {
  expect_true(is.character(simulated_data$perceived_race) || is.factor(simulated_data$perceived_race))
})

# Test 16: `minor` is a factor or character
test_that("`minor` is a factor or character", {
  expect_true(is.character(simulated_data$minor) || is.factor(simulated_data$minor))
})

# Test 17: `booked` contains at least one 0 and one 1
test_that("`booked` contains at least one 0 and one 1", {
  expect_true(all(c(0, 1) %in% simulated_data$booked))
})

# Test 18: `search_reason` contains at least one 0 and one 1
test_that("`search_reason` contains at least one 0 and one 1", {
  expect_true(all(c(0, 1) %in% simulated_data$search_reason))
})

# Test 19: Proportions of `minor` categories are valid
test_that("Proportions of `minor` categories are valid", {
  minor_proportions <- table(simulated_data$minor) / nrow(simulated_data)
  expect_true(sum(minor_proportions) == 1)
})
