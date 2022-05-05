#' Almond.CSS
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
#' @source <https://github.com/alvaromontoro/almond.css>
#'
#' @examples
#' library(shiny)
#' library(classless)
#'
#' almond <- AlmondCSS$new()
#'
#' ui <- almond$createPage(
#'   tags$header(
#'     "Almond Application"
#'   ),
#'   tags$body(
#'     tags$section(
#'       tags$h2("Contents"),
#'       tags$p("Paragraph")
#'     ),
#'     tags$section(
#'       tags$h2("Inputs"),
#'       tags$form(
#'         almond$textInput("text", "Text Input"),
#'         almond$numericInput("number", "Numeric Input")
#'       )
#'     )
#'   )
#' )
#'
#' if (interactive()) {
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
#'
#' @export
AlmondCSS <- R6::R6Class(
  classname = "AlmondCSS",
  inherit = Classless,

  public = list(
    #' @description
    #' Create a new Almond.CSS object
    #'
    #' @return A new \code{AlmondCSS} object
    initialize = \() private$framework <- "almond",

    #' @description
    #' Create a page with Almond.CSS
    #'
    #' @param ... The contents of the document body
    #' @param title The browser window title (defaults to the host URL of the page)
    #' @param lang ISO 639-1 language code for the HTML page
    #'
    #' @seealso \code{\link{almondPage}}
    createPage = function(..., title = NULL, lang = NULL) {
      almondPage(..., title = title, lang = lang)
    },

    #' @description
    #' Create an input control for entry of unstructured text values
    #'
    #' @return A text input control that can be added to a UI definition
    textInput = function(input_id, label, value = "", placeholder = "") {
      self$almondInput(textCLInput(input_id, label, value, placeholder))
    },

    #' @description
    #' Create an password control for entry of passwords
    #'
    #' @return A password input control that can be added to a UI definition
    passwordInput = function(input_id, label, value = "", placeholder = "") {
      self$almondInput(passwordCLInput(input_id, label, value, placeholder))
    },

    #' @description
    #' Create a textarea input control for entry of unstructured text values
    #'
    #' @return A textarea input control that can be added to a UI definition
    textAreaInput = function(input_id, label, value = "", placeholder = "") {
      self$almondInput(textAreaCLInput(input_id, label, value, placeholder))
    },

    #' @description
    #' Create a numeric input control for entry of unstructured text values
    #'
    #' @return A numeric input control that can be added to a UI definition
    numericInput = function(input_id, label, value = "", min = NULL, max = NULL, placeholder = "") {
      self$almondInput(numericCLInput(input_id, label, value, min, max, placeholder))
    },

    #' @description
    #' Create a date input control for entry of unstructured text values
    #'
    #' @return A date input control that can be added to a UI definition
    dateInput = function(input_id, label, value = "", min = NULL, max = NULL, placeholder = "") {
      self$almondInput(dateCLInput(input_id, label, value, min, max, placeholder))
    },

    #' Convert Classless Input to Almond.css Input
    #'
    #' @description
    #' Almond.css adds a couple of tags to inputs that some classless inputs don't have
    #'
    #' @param input Some UI input
    almondInput = function(input) {
      ui <- tagList(append(input, list(tags$br()), 1))
      tags$p(ui)
    }
  )
)
