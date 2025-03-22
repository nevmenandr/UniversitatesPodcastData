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
