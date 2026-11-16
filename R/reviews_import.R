library(jsonlite)
library(dplyr)
library(stringr)

# Load all filtered New Orleans restaurants
new_orleans_restaurants <- readRDS(
  "data/new_orleans/business_new_orleans.rds"
)

# Define the selected restaurant categories
selected_categories <- c(
  "cajun/creole",
  "seafood",
  "southern"
)

# Keep restaurants belonging to at least one selected category
selected_restaurants <- new_orleans_restaurants |>
  filter(
    !is.na(categories),
    str_detect(
      str_to_lower(categories),
      "(^|,\\s*)(cajun/creole|seafood|southern)(\\s*,|$)"
    )
  ) |>
  distinct(
    business_id,
    .keep_all = TRUE
  )

selected_business_ids <- selected_restaurants$business_id

length(selected_business_ids)
# Expected result: 648

review_file <- "data/raw/yelp_academic_dataset_review.json"

# Store only matching review chunks
review_chunks <- list()

review_handler <- function(page) {
  matching_reviews <- page |>
    filter(
      business_id %in% selected_business_ids
    ) |>
    select(
      business_id,
      user_id,
      stars,
      date,
      text,
      useful,
      funny,
      cool
    )
  
  if (nrow(matching_reviews) > 0) {
    review_chunks[
      [length(review_chunks) + 1]
    ] <<- matching_reviews
  }
  
  invisible(NULL)
}

review_connection <- file(
  review_file,
  open = "r"
)

jsonlite::stream_in(
  review_connection,
  pagesize = 5000,
  handler = review_handler,
  verbose = TRUE
)

close(review_connection)

reviews_selected <- bind_rows(review_chunks)

dim(reviews_selected)
# Expected result: 248426 rows and 9 columns

saveRDS(
  reviews_selected,
  "data/new_orleans/reviews_selected.rds",
  compress = "xz"
)

file.exists(
  "data/new_orleans/reviews_selected.rds"
)