
# Примеры использования

## Загрузка и извлечение данных

```r
library(UniversitatesPodcastData)

# Скачать данные для первых двух страниц
data <- download_podcast_pages(c(1, 2))

# Вывести структуру загруженных данных
str(data)
```

## Сохранение данных в JSON

```r
save_data_to_json(data, "podcast_data.json")
```

## Извлечение информации

```r
# Получить имя собеседника с первой страницы
name <- data[["1"]]$interlocutor
print(name)

# Получить специальность собеседника
specialty <- data[["1"]]$specialty
print(specialty)

# Получить список университетов
universities <- data[["1"]]$universities
print(universities)

```

## Поиск по специальности и университету

```r
# Найти страницы с собеседниками, которые физики
physics_pages <- find_pages_by_specialty("Physicist", data)
print(physics_pages)

# Найти страницы с собеседниками из MIT
mit_pages <- find_pages_by_university("MIT", data)
print(mit_pages)

```

## Работа с транскриптами

```r
# Получить полный транскрипт интервью
transcript <- data[["1"]]$transcript
cat(transcript)

# Найти реплики собеседника
replies <- data[["1"]]$replies
print(replies)

```
