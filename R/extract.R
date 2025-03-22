#' Extract podcast publication date
#'
#' @param page Parsed HTML page
#' @return Date of the podcast publication
#' @export
extract_podcast_date <- function(page) {
  page %>% html_nodes(xpath = "//dt[text()='Дата']/following-sibling::dd[1]") %>% html_text() %>% trimws()
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
