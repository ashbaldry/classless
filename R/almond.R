#' Create a page with Almond.CSS
#'
#' @description
#' Create a Shiny UI page that loads the CSS for Almond.CSS,
#' and has no content in the page body (other than what you provide).
#'
#' @param ... The contents of the document body
#' @param title The browser window title (defaults to the host URL of the page)
#' @param lang ISO 639-1 language code for the HTML page, such as "en" or "ko".
#' This will be used as the lang in the \code{<html>} tag, as in \code{<html lang="en">}.
#' The default (\code{NULL}) results in an empty string
#'
#' @examplesIf interactive()
#' library(shiny)
#' library(classless)
#'
#' ui <- almondPage(
#'   h1("Welcome to Almond.CSS!"),
#'   p("A classless CSS framework")
#' )
#'
#' server <- function(input, output) {}
#'
#' shinyApp(ui, server)
#'
#' @source <https://github.com/alvaromontoro/almond.css>
#'
#' @seealso AlmondCSS
#'
#' @export
almondPage <- function(..., title = NULL, lang = NULL) {
  ui <- tagList(
    tags$head(
      tags$title(title),
      tags$meta(name = "viewport", content = "width=device-width, initial-scale=1.0")
    ),
    ...
  )

  ui <- htmltools::attachDependencies(
    ui,
    list(almondTheme(), classlessDependency())
  )

  attr(ui, "lang") <- lang
  ui
}

#' Add Almond.CSS Theme to UI
#'
#' @description
#' Creates the dependency required for Almond.CSS to be included in the HTML of a page.
#'
#' @param lite Logical, should the lite version of almond.css be used? Default is \code{FALSE}
#'
#' @return
#' An \code{\link[htmltools]{htmlDependency}} to the relevant Almond.CSS style file
#'
#' @examples
#' library(htmltools)
#' library(classless)
#'
#' ui <- tags$html()
#' ui <- htmltools::attachDependencies(
#'   ui,
#'   almondTheme()
#' )
#'
#' @export
almondTheme <- function(lite = FALSE) {
  css_dir <- system.file("almond", package = "classless")
  css_file <- if (lite) "almond.lite.min.css" else "almond.min.css"

  htmltools::htmlDependency(
    name = "almond",
    version = "1.1.0",
    src = css_dir,
    stylesheet = css_file
  )
}
