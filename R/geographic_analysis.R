library(tidyverse)
library(sf)
library(tigris)
library(viridis)

options(tigris_use_cache = TRUE)

# Load the filtered New Orleans restaurant data
new_orleans_restaurants <- readRDS(
  "data/new_orleans/business_new_orleans.rds"
)

# Separate the comma-separated Yelp categories
restaurant_categories <- new_orleans_restaurants |>
  select(business_id, categories) |>
  separate_rows(categories, sep = ",") |>
  mutate(
    category = str_to_lower(str_squish(categories))
  ) |>
  filter(!is.na(category), category != "")

# View the most common categories
restaurant_categories |>
  count(category, sort = TRUE) |>
  slice_head(n = 30)

