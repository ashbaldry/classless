#' Classless Framework
#'
#' @description
#' XxX
#'
#' @param input_id The \code{input} slot that will be used to access the value.
#' @param label Display label for the control
#' @param value Initial value
#' @param placeholder A character string giving the user a hint as to what can be entered into the control
#' @param min Minimum valid value
#' @param max Maximum valid value
#'
#' @export
Classless <- R6::R6Class(
  classname = "Classless",
  public = list(
    #' @description
    #' Create a new Classless object
    #'
    #' @param framework Name of the framework
    #'
    #' @return A new \code{Classless} object
    initialize = function(framework) private$framework <- framework,

    #' @description
    #' Get the name of the selected classless framework
    #'
    #' @return The name of the framework
    getFramework = function() private$framework,

    #' @description
    #' Method required to create a UI page with the required framework
    #'
    #' By default this method is not available and must be created in the extended R6 class
    #'
    #' @param ... Ignored
    createPage = function(...) {
      stop("Method not initialised")
    },

    #' @description
    #' Run an example application, showing off components available in the classless framework
    #'
    #' @param ... Arguments to passed to \code{\link[shiny]{shinyApp}}
    #'
    #' @return A shiny application with example components
    runExample = \(...) runClasslessExample(framework = self$clone(), ...),

    #' @description
    #' Create an input control for entry of unstructured text values
    #'
    #' @return A text input control that can be added to a UI definition
    textInput = function(input_id, label, value = "", placeholder = "") {
      textCLInput(input_id, label, value, placeholder)
    },

    #' @description
    #' Create an password control for entry of passwords
    #'
    #' @return A password input control that can be added to a UI definition
    passwordInput = function(input_id, label, value = "", placeholder = "") {
      passwordCLInput(input_id, label, value, placeholder)
    },

    #' @description
    #' Create a textarea input control for entry of unstructured text values
    #'
    #' @return A textarea input control that can be added to a UI definition
    textAreaInput = function(input_id, label, value = "", placeholder = "") {
      textAreaCLInput(input_id, label, value, placeholder)
    },

    #' @description
    #' Create a numeric input control for entry of unstructured text values
    #'
    #' @return A numeric input control that can be added to a UI definition
    numericInput = function(input_id, label, value = "", min = NULL, max = NULL, placeholder = "") {
      numericCLInput(input_id, label, value, min, max, placeholder)
    },

    #' @description
    #' Create a date input control for entry of unstructured text values
    #'
    #' @return A date input control that can be added to a UI definition
    dateInput = function(input_id, label, value = "", min = NULL, max = NULL, placeholder = "") {
      dateCLInput(input_id, label, value, min, max, placeholder)
    }
  ),

  private = list(
    framework = NULL
  )
)
