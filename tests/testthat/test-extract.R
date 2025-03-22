library(testthat)
library(rvest)

# Создаем тестовую HTML-страницу
html_content <- '<html><body>
<dt>Собеседник</dt><dd>Иван Иванов</dd>
<dt>Специальность</dt><dd>Физик</dd>
<dt>Университеты</dt><dd>МГУ, СПбГУ</dd>
<dt>Дата</dt><dd>01 марта 2024</dd>
</body></html>'
test_page <- read_html(html_content)

test_that("extract_podcast_date extracts correct date", {
  expect_equal(extract_podcast_date(test_page), "01 марта 2024")
})

test_that("extract_interlocutor_name extracts correct name", {
  expect_equal(extract_interlocutor_name(test_page), "Иван Иванов")
})

test_that("extract_interlocutor_specialty extracts correct specialty", {
  expect_equal(extract_interlocutor_specialty(test_page), "Физик")
})

test_that("extract_interlocutor_universities extracts correct universities", {
  expect_equal(extract_interlocutor_universities(test_page), c("МГУ", "СПбГУ"))
})
