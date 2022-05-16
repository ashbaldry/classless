#' Action Button/Link
#'
#' @description
#' Creates an action button or link whose value is initially zero, and increments by one each time it is pressed.
#'
#' @param input_id The \code{input} slot that will be used to access the value.
#' @param label The contents of the button or link–usually a text label, but you could also use any other HTML, like an image.
#' @param ... Named attributes to be applied to the button or link.
#'
#' @examples
#' actionCLButton("button", "Click Me")
#'
#' @rdname button
#' @export
actionCLButton <- function(input_id, label, ...) {
  attribs <- list(...)

  if ("type" %in% names(attribs)) {
    type <- attribs$type
  } else {
    attribs$type <- "button"
  }

  if ("class" %in% names(attribs)) {
    attribs$class <- paste(attribs$class, "action-button")
  } else {
    attribs$class <- "action-button"
  }

  button_tag <- tags$button(id = input_id, label)
  button_tag$attribs <- append(button_tag$attribs, attribs)
  button_tag
}

#' @rdname button
#' @export
actionCLLink <- function(input_id, label, ...) {
  attribs <- list(...)

  if ("class" %in% names(attribs)) {
    attribs$class <- paste(attribs$class, "action-link")
  } else {
    attribs$class <- "action-link"
  }

  button_tag <- tags$a(id = input_id, label)
  button_tag$attribs <- append(button_tag$attribs, attribs)
  button_tag
}
