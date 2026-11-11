library(jsonlite)
library(dplyr)

# Load the filtered New Orleans restaurants
new_orleans_restaurants <- readRDS(
  "data/new_orleans/business_new_orleans.rds"
)

restaurant_ids <- new_orleans_restaurants$business_id

review_file <- "data/raw/yelp_academic_dataset_review.json"

# Store only matching review chunks
review_chunks <- list()

review_handler <- function(chunk) {
  matching_reviews <- chunk[
    chunk$business_id %in% restaurant_ids,
    c(
      "business_id",
      "user_id",
      "stars",
      "date",
      "text",
      "useful",
      "funny",
      "cool"
    ),
    drop = FALSE
  ]
  
  if (nrow(matching_reviews) > 0) {
    review_chunks[
      [length(review_chunks) + 1]
    ] <<- matching_reviews
  }
  
  invisible(NULL)
}

# Read the huge review file in chunks
jsonlite::stream_in(
  file(review_file),
  handler = review_handler,
  pagesize = 10000,
  verbose = FALSE
)

# Combine the matching chunks
reviews_new_orleans <- dplyr::bind_rows(review_chunks)

# Check the result
dim(reviews_new_orleans)
head(reviews_new_orleans, 3)

# Save the filtered reviews
saveRDS(
  reviews_new_orleans,
  "data/new_orleans/reviews_new_orleans.rds",
  compress = "xz"
)

file.exists("data/new_orleans/reviews_new_orleans.rds")