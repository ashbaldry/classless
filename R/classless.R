#' Create a page with Classless.css
#'
#' @description
#' Create a Shiny UI page that loads the CSS for Classless.css,
#' and has no content in the page body (other than what you provide).
#'
#' @param ... The contents of the document body
#' @param title The browser window title (defaults to the host URL of the page)
#' @param theme One of the following:
#' \itemize{
#' \item{\code{NULL} (the default), which implies a "stock" build of Classless.css}
#' \item{One of the themes available in \code{\link{listClasslessThemes}()}}
#' \item{A **named** character string pointing to an alternative Classless.css stylesheet
#'       (normally a css file within the www directory, e.g. \code{c(theme = "www/classless-theme.css")})}
#' }
#' @param lang ISO 639-1 language code for the HTML page, such as "en" or "ko".
#' This will be used as the lang in the \code{<html>} tag, as in \code{<html lang="en">}.
#' The default (\code{NULL}) results in an empty string
#'
#' @examplesIf interactive()
#' library(shiny)
#' library(classless)
#'
#' ui <- classlessPage(
#'   h1("Welcome to Classless!"),
#'   p("An (almost) classless CSS framework")
#' )
#'
#' server <- function(input, output) {}
#'
#' shinyApp(ui, server)
#'
#' @source <https://github.com/emareg/classlesscss>
#'
#' @export
classlessPage <- function(..., title = NULL, theme = NULL, lang = NULL) {
  ui <- tagList(
    tags$head(
      tags$title(title),
      tags$meta(name = "viewport", content = "width=device-width, initial-scale=1.0")
    ),
    ...
  )

  ui <- htmltools::attachDependencies(
    ui,
    list(classlessTheme(theme), classlessDependency())
  )

  attr(ui, "lang") <- lang
  ui
}

CLASSLESS_THEMES <- c(
  "light", "dark", "sepia", "milligram", "pure", "sakura", "skeleton", "bootstrap", "medium", "tufte"
)

#' Add Classless.css Theme to UI
#'
#' @description
#' Creates the dependency required for Classless.css to be included in the HTML of a page.
#'
#' @param theme One of the following:
#' \itemize{
#' \item{\code{NULL} (the default), which implies a "stock" build of Classless.css}
#' \item{One of the themes available in \code{\link{listClasslessThemes}()}}
#' \item{A **named** character string pointing to an alternative Classless.css stylesheet
#'       (normally a css file within the www directory, e.g. \code{c(theme = "www/classless-theme.css")})}
#' }
#' @param tiny Logical, should only minimal CSS be included? If \code{TRUE} this will only include styles for text,
#' tables, figures and code.
#' @param include_tabbox Logical, should the styling for tab boxes be included?
#'
#' @return
#' An \code{\link[htmltools]{htmlDependency}} to the relevant Classless.css style file
#'
#' @examples
#' library(htmltools)
#' library(classless)
#'
#' ui <- tags$html()
#' ui <- htmltools::attachDependencies(
#'   ui,
#'   classlessTheme()
#' )
#'
#' @importFrom tools file_ext
#'
#' @export
classlessTheme <- function(theme = NULL, tiny = FALSE, include_tabbox = TRUE) {
  if (is.null(theme)) {
    theme_file <- NULL
  } else if (theme %in% CLASSLESS_THEMES) {
    theme_file <- "themes.css"
  } else if (file.exists(theme)) {
    if (is.null(names(theme))) stop("If supplying a custom theme, it must be named")
  } else {
    stop("Theme is invalid. Choose one of: ", paste(CLASSLESS_THEMES, collapse = ", "))
  }

  if (is.null(theme)) {
    js <- NULL
  } else {
    theme_name <- if (file.exists(theme)) names(theme) else theme
    js <- paste0('<script>$("html").attr("data-theme", "', theme_name, '");</script>')
  }

  css_dir <- system.file("classless", package = "classless")
  css_file <- if (tiny) "classless-tiny.css" else "classless.css"
  tabbox_file <- if (include_tabbox) "tabbox.css" else NULL

  htmltools::htmlDependency(
    name = "classless",
    version = "1.0",
    src = css_dir,
    head = js,
    stylesheet = c(
      css_file,
      theme_file,
      tabbox_file
    )
  )
}

#' List Classless Themes
#'
#' @description
#' Classless comes with a several themes that can be applied to the SCSS. This provides a list of all available options.
#'
#' @return
#' A vector of available CSS styles
#'
#' @examples
#' listClasslessThemes()
#'
#' @export
listClasslessThemes <- function() {
  CLASSLESS_THEMES
}

#' Get Classless Themesheet
#'
#' @description
#' This will write the required style variables to a specified location to customise the classless theme.
#'
#' @param file Location to write the file to, or \code{NULL} to print to the console
#' @param append If \code{TRUE} output will be appended to file; otherwise, it will overwrite the contents of file
#'
#' @return
#' A list of unasssigned style variables to be updated by the developer
#'
#' @examples
#' getClasslessThemesheet()
#'
#' @export
getClasslessThemesheet <- function(file = "", append = TRUE) {
  cat(
    "/* Duotone color scheming:",
    "Uses blossom as the revealing/stark color",
    "Uses fade as the more prominent color",
    "*/",
    "$color-blossom: ;",
    "$color-fade: ;",
    "",
    "/*",
    "bg color is used for the background of the page",
    "bg-alt is used for code-blocks etc",
    "*/",
    "$color-bg: ;",
    "$color-bg-alt: ;",
    "",
    "/* color of all the text on the page */",
    "$color-text: ;",
    "$font-size-base: ;",
    "",
    "$font-family-base: ;",
    "$font-family-heading: ;",
    file = file,
    append = append,
    sep = "\n"
  )
}
