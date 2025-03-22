library(testthat)
library(UniversitatesPodcastData)

test_that("download_podcast_pages returns a list", {
  ids <- c(1, 2)
  data <- download_podcast_pages(ids)
  
  expect_type(data, "list")
  expect_length(data, length(ids))
})
