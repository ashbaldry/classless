#' Sakura.CSS
#'
#' @description
#' A ...
#'
#' @param input_id The \code{input} slot that will be used to access the value.
#' @param label Display label for the control
#' @param value Initial value
#' @param placeholder A character string giving the user a hint as to what can be entered into the control
#' @param min Minimum valid value
#' @param max Maximum valid value
#'
#' @export
SakuraCSS <- R6::R6Class(
  classname = "SakuraCSS",
  inherit = Classless,

  public = list(
    #' @description
    #' Create a new sakura.css object
    #'
    #' @return A new \code{SakuraCSS} object
    initialize = \() private$framework <- "sakura",

    #' @description
    #' Create a page with sakura.css
    #'
    #' @param ... The contents of the document body
    #' @param title The browser window title (defaults to the host URL of the page)
    #' @param theme Theme to give to the UI
    #' @param lang ISO 639-1 language code for the HTML page
    #'
    #' @seealso \code{\link{sakuraPage}}, \code{\link{listSakuraThemes}}
    createPage = function(..., title = NULL, theme = NULL, lang = NULL) {
      sakuraPage(..., title = title, theme = theme, lang = lang)
    },

    #' @description
    #' Create an input control for entry of unstructured text values
    #'
    #' @return A text input control that can be added to a UI definition
    textInput = function(input_id, label, value = "", placeholder = "") {
      self$sakuraInput(
        super$textInput(input_id, label, value = value, placeholder = placeholder)
      )
    },

    #' @description
    #' Create an password control for entry of passwords
    #'
    #' @return A password input control that can be added to a UI definition
    passwordInput = function(input_id, label, value = "", placeholder = "") {
      self$sakuraInput(
        super$passwordInput(input_id, label, value = value, placeholder = placeholder)
      )
    },

    #' @description
    #' Create a textarea input control for entry of unstructured text values
    #'
    #' @return A textarea input control that can be added to a UI definition
    textAreaInput = function(input_id, label, value = "", placeholder = "") {
      self$sakuraInput(
        super$textAreaInput(input_id, label, value = value, placeholder = placeholder)
      )
    },

    #' @description
    #' Create a numeric input control for entry of unstructured text values
    #'
    #' @return A numeric input control that can be added to a UI definition
    numericInput = function(input_id, label, value = "", min = NULL, max = NULL, placeholder = "") {
      self$sakuraInput(
        super$numericInput(input_id, label, value = value, min = min, max = max, placeholder = placeholder)
      )
    },

    #' @description
    #' Create a date input control for entry of unstructured text values
    #'
    #' @return A date input control that can be added to a UI definition
    dateInput = function(input_id, label, value = "", min = NULL, max = NULL, placeholder = "") {
      self$sakuraInput(
        super$dateInput(input_id, label, value = value, min = min, max = max, placeholder = placeholder)
      )
    },

    #' @description
    #' Create a checkbox that can be used to specify logical values
    #'
    #' @return A checkbox control that can be added to a UI definition
    checkboxInput = function(input_id, label, value = FALSE) {
      ui <- checkboxCLInput(input_id, label, value = value)
      checkbox <- ui[[2]]
      checkbox$children <- append(checkbox$children, ui[1], after = 0)
      checkbox
    },

    #' @description
    #' Create a select list that can be used to choose a single or multiple items from a list of values
    #'
    #' @param choices List of values to select from
    #' @param selected The initially selected value (or multiple values if \code{multiple = TRUE}).
    #' @param multiple Is selection of multiple items allowed?
    #'
    #' @return A select list control that can be added to a UI definition
    #'
    #' @seealso selectCLInput
    selectInput = function(input_id, label, choices, selected = NULL, multiple = FALSE) {
      self$sakuraInput(
        super$selectInput(input_id, label, choices, selected = selected, multiple = multiple)
      )
    },

    #' Convert Classless Input to sakura.css Input
    #'
    #' @description
    #' sakura.css wraps a \code{<p>} tag around classless form inputs to achieve the correct style
    #'
    #' @param input Some UI input
    sakuraInput = function(input) {
      tags$p(input)
    }
  )
)
