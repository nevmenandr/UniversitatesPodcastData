library(testthat)
library(jsonlite)

test_that("save_data_to_json correctly writes JSON", {
  data <- list("1" = list(
    interlocutor = "Иван Иванов",
    specialty = "Физик",
    universities = c("МГУ", "СПбГУ"),
    date = "01 марта 2024",
    transcript = "Текст беседы",
    replies = list(),
    announcement = "Анонс"
  ))
  
  temp_file <- tempfile(fileext = ".json")
  save_data_to_json(data, temp_file)
  
  json_data <- fromJSON(temp_file)
  
  expect_equal(json_data[[1]]$interlocutor, "Иван Иванов")
  expect_equal(json_data[[1]]$specialty, "Физик")
  expect_equal(json_data[[1]]$universities, c("МГУ", "СПбГУ"))
})
