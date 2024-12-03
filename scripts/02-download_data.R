#### Preamble ####
# Purpose: Downloading the data from OpenData Toronto on Police Race and Identity-Based Data Collection: Arrests and Strip Searches.
# Author: Akshat Aneja
# Date: 3 December 2024
# Contact: akshat.aneja@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Datasets: https://open.toronto.ca/dataset/police-race-and-identity-based-data-collection-arrests-strip-searches/



#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
# Get package data

# get package
package <- show_package("police-race-and-identity-based-data-collection-arrests-strip-searches")
package

# get all resources for this package
resources <- list_package_resources("police-race-and-identity-based-data-collection-arrests-strip-searches")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()

# Save the data in CSV
write.csv(data, here::here("data/01-raw_data/raw_data.csv"), row.names = FALSE)


         
