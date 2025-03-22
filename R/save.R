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
      date = data[[id]]$date,
      transcript = data[[id]]$transcript,
      replies = data[[id]]$replies,
      announcement = data[[id]]$announcement
    )
  })
  write_json(structured_data, file, pretty = TRUE, auto_unbox = TRUE)
}
