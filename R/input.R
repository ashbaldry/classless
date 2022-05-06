#' Inputs for Classless CSS Frameworks
#'
#' @description
#' As most classless frameworks focus on HTML tags rather than CSS classes, the format of inputs is generally
#' consistent amongst different frameworks.
#'
#' Classless frameworks a lot less feature rich compared to
#'
#' @param input_id The \code{input} slot that will be used to access the value.
#' @param label Display label for the control
#' @param value Initial value
#' @param placeholder A character string giving the user a hint as to what can be entered into the control
#'
#' @return An input control that can be added to a UI definition
#'
#' @examples
#' # Text Input
#' textCLInput(input_id = "text", "Text Input")
#'
#' # Numeric Input
#' numericCLInput(input_id = "numeric", "Numeric Input")
#'
#' # Date Input
#' dateCLInput(input_id = "date", "Date Input")
#'
#' @rdname input
#' @export
textCLInput <- function(input_id, label, value = "", placeholder = "") {
  tagList(
    tags$label("for" = input_id, label),
    tags$input(id = input_id, type = "text", value = value, placeholder = placeholder)
  )
}

#' @rdname input
#' @export
passwordCLInput <- function(input_id, label, value = "", placeholder = "") {
  tagList(
    tags$label("for" = input_id, label),
    tags$input(id = input_id, type = "password", value = value, placeholder = placeholder)
  )
}

#' @rdname input
#' @export
textAreaCLInput <- function(input_id, label, value = "", placeholder = "") {
  tagList(
    tags$label("for" = input_id, label),
    tags$textarea(id = input_id, type = "textarea", placeholder = placeholder, value)
  )
}

#' @param min Minimum valid value
#' @param max Maximum valid value
#'
#' @rdname input
#' @export
numericCLInput <- function(input_id, label, value = "", min = NULL, max = NULL, placeholder = "") {
  input_tag <- tags$input(id = input_id, type = "number", value = value, placeholder = placeholder)
  if (!is.null(min)) input_tag$attribs$min <- as.character(min)
  if (!is.null(max)) input_tag$attribs$max <- as.character(max)

  tagList(
    tags$label("for" = input_id, label),
    input_tag
  )
}

#' @rdname input
#' @export
dateCLInput <- function(input_id, label, value = "", min = NULL, max = NULL, placeholder = "") {
  input_tag <- tags$input(id = input_id, type = "date", value = value, placeholder = placeholder)
  if (!is.null(min)) input_tag$attribs$min <- as.character(as.Date(min))
  if (!is.null(max)) input_tag$attribs$max <- as.character(as.Date(max))

  tagList(
    tags$label("for" = input_id, label),
    input_tag
  )
}
