#' Universitates Podcast Data Package
#'
#' A package to download and process interview transcripts from webpages.
#'
#' @name UniversitatesPodcastData
#' @docType package
#' @import httr rvest ggplot2 stringr dplyr tidyr jsonlite
#' @exportPattern "^[[:alpha:]]+"
#'
NULL

# Load required libraries
library(httr)
library(rvest)
library(ggplot2)
library(stringr)
library(dplyr)
library(tidyr)
library(jsonlite)

#' Download webpages and extract data
#'
#' @param ids Vector of page numbers to download
#' @return List of extracted data
#' @export
download_podcast_pages <- function(ids) {
  base_url <- "https://nevmenandr.github.io/universitates/"
  data <- list()
  
  for (id in ids) {
    url <- sprintf("%s%02d.html", base_url, id)
    page <- read_html(url)
    
    data[[as.character(id)]] <- list(
      interlocutor = extract_interlocutor_name(page),
      specialty = extract_interlocutor_specialty(page),
      universities = extract_interlocutor_universities(page),
      transcript = extract_transcript(page),
      replies = extract_interlocutor_replies(page),
      announcement = extract_announcement(page)
    )
  }
  return(data)
}

#' Extract interlocutor name
#'
#' @param page Parsed HTML page
#' @return Name of the interlocutor
extract_interlocutor_name <- function(page) {
  page %>% html_nodes(xpath = "//dt[text()='Собеседник']/following-sibling::dd[1]") %>% html_text() %>% trimws()
}

#' Extract interlocutor specialty
#'
#' @param page Parsed HTML page
#' @return Specialty of the interlocutor
extract_interlocutor_specialty <- function(page) {
  page %>% html_nodes(xpath = "//dt[text()='Специальность']/following-sibling::dd[1]") %>% html_text() %>% trimws()
}

#' Extract interlocutor universities
#'
#' @param page Parsed HTML page
#' @return List of universities
extract_interlocutor_universities <- function(page) {
  universities <- page %>% html_nodes(xpath = "//dt[text()='Университеты']/following-sibling::dd[1]") %>% html_text() %>% trimws()
  strsplit(universities, ", ")[[1]]
}

#' Extract transcript text
#'
#' @param page Parsed HTML page
#' @return Transcript text
extract_transcript <- function(page) {
  transcript <- page %>% html_nodes(xpath = "//h2[@id='транскрипт']/following-sibling::*[not(self::h2)][preceding-sibling::h2[@id='транскрипт']]") %>% html_text()
  paste(transcript, collapse = " ")
}

#' Extract interlocutor replies
#'
#' @param page Parsed HTML page
#' @return List of replies with timestamps
extract_interlocutor_replies <- function(page) {
  replies <- page %>% html_nodes(xpath = "//p[contains(text(), '[')]") %>% html_text()
  extracted <- lapply(replies, function(reply) {
    match <- str_match(reply, "\\[(\\d{1,2}:\\d{2}:\\d{2}(?:\\.\\d{1,3})?) — (.*?)\\] (.*)")
    if (!is.na(match[1])) {
      list(timestamp = match[2], speaker = match[3], text = match[4])
    } else {
      NULL
    }
  })
  extracted <- extracted[!sapply(extracted, is.null)]
  return(extracted)
}

#' Extract announcement text
#'
#' @param page Parsed HTML page
#' @return Announcement text
extract_announcement <- function(page) {
  announcement <- page %>% html_nodes(xpath = "//h2[@id='анонс']/following-sibling::*[not(self::h2)][preceding-sibling::h2[@id='анонс']]") %>% html_text()
  paste(announcement, collapse = " ")
}

#' Save extracted data to JSON
#'
#' @param data List of structured page data
#' @param file Path to output JSON file
#' @export
save_data_to_json <- function(data, file) {
  structured_data <- lapply(names(data), function(id) {
    list(
      id = id,
      interlocutor = data[[id]]$interlocutor,
      specialty = data[[id]]$specialty,
      universities = data[[id]]$universities,
      transcript = data[[id]]$transcript,
      replies = data[[id]]$replies,
      announcement = data[[id]]$announcement
    )
  })
  write_json(structured_data, file, pretty = TRUE, auto_unbox = TRUE)
}

#' Find pages by interlocutor specialty
#'
#' @param specialty Specialty of the interlocutor
#' @param data List of structured page data
#' @return List of page numbers
#' @export
find_pages_by_specialty <- function(specialty, data) {
  matching_pages <- as.numeric(names(which(sapply(data, function(d) d$specialty == specialty))))
  return(matching_pages)
}

#' Find pages by university name
#'
#' @param university Name of the university
#' @param data List of structured page data
#' @return List of page numbers
#' @export
find_pages_by_university <- function(university, data) {
  matching_pages <- as.numeric(names(which(sapply(data, function(d) university %in% d$universities))))
  return(matching_pages)
}
