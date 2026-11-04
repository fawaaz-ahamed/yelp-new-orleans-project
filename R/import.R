library(jsonlite)

business_file <- "data/raw/yelp_academic_dataset_business.json"

business_raw <- jsonlite::stream_in(
  file(business_file),
  verbose = FALSE
)

dim(business_raw)
head(business_raw, 3)

