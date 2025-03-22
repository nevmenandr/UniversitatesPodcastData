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
      date = extract_podcast_date(page),
      transcript = extract_transcript(page),
      replies = extract_interlocutor_replies(page),
      announcement = extract_announcement(page)
    )
  }
  return(data)
}
