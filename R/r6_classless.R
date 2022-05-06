#' Classless.CSS
#'
#' @description
#' A ...
#'
#' @export
ClasslessCSS <- R6::R6Class(
  classname = "ClasslessCSS",
  inherit = Classless,

  public = list(
    #' @description
    #' Create a new Classless.CSS object
    #'
    #' @return A new \code{ClasslessCSS} object
    initialize = \() private$framework <- "classless",

    #' @description
    #' Create a page with Classless.CSS
    #'
    #' @param ... The contents of the document body
    #' @param title The browser window title (defaults to the host URL of the page)
    #' @param theme Theme to give to the UI
    #' @param lang ISO 639-1 language code for the HTML page
    #'
    #' @seealso \code{\link{classlessPage}}, \code{\link{listClasslessThemes}}
    createPage = function(..., title = NULL, theme = NULL, lang = NULL) {
      classlessPage(..., title = title, theme = theme, lang = lang)
    }
  )
)
