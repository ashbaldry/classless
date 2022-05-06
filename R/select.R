#' Create a select list input control
#'
#' @description
#' Create a select list that can be used to choose a single or multiple items from a list of values.
#'
#' @param input_id The input slot that will be used to access the value
#' @inheritParams shiny::selectInput
#'
#' @examples
#' selectCLInput(
#'   "letter",
#'   "Select a letter",
#'   LETTERS
#' )
#'
#' @rdname selectInput
#' @export
selectCLInput <- function(input_id, label, choices, selected = NULL, multiple = FALSE) {
  if (is.null(selected) && !multiple) {
    selected <- getSelectedValue(choices)
  } else if (length(selected) > 1 && !multiple) {
    stop("When using a single select input, multiple options cannot be selected")
  }

  options <- getSelectOptions(choices, selected)
  input_tag <- tags$select(id = input_id, options)
  if (multiple) input_tag$attribs$multiple <- NA

  tagList(
    tags$label("for" = input_id, label),
    input_tag
  )
}

getSelectedValue <- function(choices) {
  if (is.list(choices)) {
    getSelectedValue(choices[[1]])
  } else {
    unname(choices[1])
  }
}

getSelectOptions <- function(choices, selected = NULL) {
  if (is.null(names(choices)) && is.vector(choices)) {
    names(choices) <- choices
  }

  mapply(
    choices, names(choices),
    USE.NAMES = FALSE,
    FUN = function(choice, label) {
      if (is.list(choice)) {
        tagList(tags$optgroup(
          label = label,
          getSelectOptions(choice, selected)
        ))
      } else {
        mapply(
          choice, label,
          USE.NAMES = FALSE,
          FUN = function(choice, label) {
            option_tag <- tags$option(value = choice, label)
            if (choice %in% selected) option_tag$attribs$selected <- NA
            tagList(option_tag)
          }
        )
      }
    }
  )
}
