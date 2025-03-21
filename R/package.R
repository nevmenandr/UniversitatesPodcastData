#' Universitates Podcast Data Package
#'
#' A package to download and process interview transcripts from webpages.
#'
#' @name UniversitatesPodcastData
#' @docType package
#' @import httr rvest ggplot2 stringr
#' @exportPattern "^[[:alpha:]]+"
#'
NULL

# Load required libraries
library(httr)
library(rvest)
library(ggplot2)
library(stringr)

#' Extract interlocutor name from page content
#'
#' @param page_text HTML content of the page
#' @return Interlocutor's name
#' @export
extract_interlocutor <- function(page_text) {
  page_html <- read_html(page_text)
  interlocutor <- page_html %>% 
    html_node(xpath = "//dt[text()='Собеседник']/following-sibling::dd[1]") %>%
    html_text(trim = TRUE)
  return(interlocutor)
}

#' Extract interlocutor specialty from page content
#'
#' @param page_text HTML content of the page
#' @return Specialty of the interlocutor
#' @export
extract_specialty <- function(page_text) {
  page_html <- read_html(page_text)
  specialty <- page_html %>% 
    html_node(xpath = "//dt[text()='Специальность']/following-sibling::dd[1]") %>%
    html_text(trim = TRUE)
  return(specialty)
}

#' Extract universities from page content
#'
#' @param page_text HTML content of the page
#' @return List of universities
#' @export
extract_universities <- function(page_text) {
  page_html <- read_html(page_text)
  universities_text <- page_html %>% 
    html_node(xpath = "//dt[text()='Университеты']/following-sibling::dd[1]") %>%
    html_text(trim = TRUE)
  universities <- unlist(strsplit(universities_text, ",\s*"))  # Split by comma and trim spaces
  return(universities)
}

#' Extract transcript from page content
#'
#' @param page_text HTML content of the page
#' @return Transcript of the interview
#' @export
extract_transcript <- function(page_text) {
  page_html <- read_html(page_text)
  transcript <- page_html %>% 
    html_node(xpath = "//h2[@id='транскрипт']/following-sibling::*[not(self::hr)][1]") %>%
    html_text(trim = TRUE)
  return(transcript)
}

#' Extract interlocutor's replies from transcript
#'
#' @param transcript Text of the transcript
#' @param interlocutor Name of the interlocutor
#' @return Data frame with timestamps and replies
#' @export
extract_interlocutor_replies <- function(transcript, interlocutor) {
  pattern <- sprintf("(\\d{1,2}:\\d{2}:\\d{2}(?:\\.\\d{3})?) \[%s\] (.+)", interlocutor)
  matches <- regmatches(transcript, gregexpr(pattern, transcript, perl = TRUE))[[1]]
  timestamps <- gsub(pattern, "\\1", matches)
  replies <- gsub(pattern, "\\2", matches)
  return(data.frame(Timestamp = timestamps, Reply = replies, stringsAsFactors = FALSE))
}

#' Find pages by university name
#'
#' @param university University name
#' @param data List of structured page data
#' @return List of page numbers
#' @export
find_pages_by_university <- function(university, data) {
  matching_pages <- as.numeric(names(which(sapply(data, function(d) university %in% d$universities))))
  return(matching_pages)
}

#' Calculate word count for each transcript
#'
#' @param data List of structured page data
#' @return Named vector of word counts
#' @export
calculate_word_counts <- function(data) {
  word_counts <- sapply(data, function(d) str_count(d$transcript, "\\S+"))
  return(word_counts)
}

#' Plot word count histogram
#'
#' @param word_counts Named vector of word counts
#' @return ggplot object
#' @export
plot_word_count_histogram <- function(word_counts) {
  data <- data.frame(Page = names(word_counts), WordCount = word_counts)
  ggplot(data, aes(x = Page, y = WordCount)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    theme_minimal() +
    labs(title = "Transcript Word Count", x = "Page", y = "Word Count") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
}

#' Download webpages and store structured data
#'
#' @param base_url URL template with %s as a placeholder
#' @param start Start index
#' @param end End index
#' @return List of structured data per page
#' @export
download_pages <- function(base_url, start, end) {
  data <- list()
  
  for (i in start:end) {
    url <- sprintf(base_url, sprintf("%02d", i))  # Forming URL with leading zeros
    response <- GET(url)
    
    if (status_code(response) == 200) {
      page_text <- content(response, as = "text")
      data[[sprintf("%02d", i)]] <- list(
        id = sprintf("%02d", i),
        page_text = page_text,
        interlocutor = extract_interlocutor(page_text),
        specialty = extract_specialty(page_text),
        universities = extract_universities(page_text),
        transcript = extract_transcript(page_text)
      )
      message("Downloaded: ", url)
    } else {
      message("Error downloading: ", url)
    }
  }
  
  return(data)
}
