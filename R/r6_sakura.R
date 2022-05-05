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
      self$sakuraInput(textCLInput(input_id, label, value, placeholder))
    },

    #' @description
    #' Create an password control for entry of passwords
    #'
    #' @return A password input control that can be added to a UI definition
    passwordInput = function(input_id, label, value = "", placeholder = "") {
      self$sakuraInput(passwordCLInput(input_id, label, value, placeholder))
    },

    #' @description
    #' Create a textarea input control for entry of unstructured text values
    #'
    #' @return A textarea input control that can be added to a UI definition
    textAreaInput = function(input_id, label, value = "", placeholder = "") {
      self$sakuraInput(textAreaCLInput(input_id, label, value, placeholder))
    },

    #' @description
    #' Create a numeric input control for entry of unstructured text values
    #'
    #' @return A numeric input control that can be added to a UI definition
    numericInput = function(input_id, label, value = "", min = NULL, max = NULL, placeholder = "") {
      self$sakuraInput(numericCLInput(input_id, label, value, min, max, placeholder))
    },

    #' @description
    #' Create a date input control for entry of unstructured text values
    #'
    #' @return A date input control that can be added to a UI definition
    dateInput = function(input_id, label, value = "", min = NULL, max = NULL, placeholder = "") {
      self$sakuraInput(dateCLInput(input_id, label, value, min, max, placeholder))
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
