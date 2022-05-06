#' Create a page with Sakura
#'
#' @description
#' Create a Shiny UI page that loads the CSS for Sakura,
#' and has no content in the page body (other than what you provide).
#'
#' @param ... The contents of the document body
#' @param title The browser window title (defaults to the host URL of the page)
#' @param theme One of the following:
#' \itemize{
#' \item{\code{NULL} (the default), which implies a "stock" build of Sakura}
#' \item{One of the themes available in \code{\link{listSakuraThemes}()}}
#' \item{A character string pointing to an alternative Sakura stylesheet
#'       (normally a scss file within the www directory, e.g. www/sakura.scss)}
#' }
#' @param lang ISO 639-1 language code for the HTML page, such as "en" or "ko".
#' This will be used as the lang in the \code{<html>} tag, as in \code{<html lang="en">}.
#' The default (\code{NULL}) results in an empty string
#'
#' @examplesIf interactive()
#' library(shiny)
#' library(classless)
#'
#' ui <- sakuraPage(
#'   h1("Welcome to Sakura!"),
#'   p("A classless CSS framework")
#' )
#'
#' server <- function(input, output) {}
#'
#' shinyApp(ui, server)
#'
#' @source <https://github.com/oxalorg/sakura>
#'
#' @export
sakuraPage <- function(..., title = NULL, theme = NULL, lang = NULL) {
  ui <- tagList(
    tags$head(
      tags$title(title),
      tags$meta(name = "viewport", content = "width=device-width, initial-scale=1.0")
    ),
    ...
  )

  ui <- htmltools::attachDependencies(
    ui,
    list(sakuraTheme(theme), classlessDependency())
  )

  attr(ui, "lang") <- lang
  ui
}

SAKURA_THEMES <- c("", "dark-solarized", "dark", "earthly", "ink", "pink", "vader")

#' Add Sakura Theme to UI
#'
#' @description
#' Creates the dependency required for Sakura to be included in the HTML of a page.
#'
#' @param theme One of the following:
#' \itemize{
#' \item{\code{NULL} (the default), which implies a "stock" build of Sakura}
#' \item{One of the themes available in \code{\link{listSakuraThemes}()}}
#' \item{A character string pointing to an alternative Sakura stylesheet
#'       (normally a scss file within the www directory, e.g. www/sakura.scss)}
#' }
#' @param sass_options A \code{\link[sass]{sass_options}()} object.
#' @param cache This can be a directory to use for the cache, a \code{\link[sass]{FileCache}}
#' object created by \code{\link[sass]{sass_file_cache}()}, or \code{FALSE} or \code{NULL} for no caching.
#'
#' @return
#' An \code{\link[htmltools]{htmlDependency}} to the relevant Sakura style file
#'
#' @examples
#' library(htmltools)
#' library(classless)
#'
#' ui <- tags$html()
#' ui <- htmltools::attachDependencies(
#'   ui,
#'   sakuraTheme()
#' )
#'
#' @importFrom tools file_ext
#'
#' @export
sakuraTheme <- function(theme = NULL,
                        sass_options = sass::sass_options_get(output_style = "compressed"),
                        cache = sass::sass_cache_get()) {

  if (is.null(theme)) {
    theme <- ""
  }

  scss_dir <- system.file("sakura", package = "classless")

  if (theme %in% SAKURA_THEMES) {
    theme_name <- if (theme == "") "sakura" else paste0("sakura-", theme)
    theme_scss <- sass::sass_file(file.path(scss_dir, paste0(theme_name, ".scss")))
  } else if (file.exists(theme)) {
    if (tools::file_ext(theme) != "scss") {
      stop("Customised theme file must be an .scss file")
    }
    theme_name <- sub("\\.scss", "", basename(theme))
    theme_scss <- list(theme, sass::sass_file(file.path(scss_dir, "_main.scss")))
  } else {
    stop("Theme is not valid")
  }

  css_file <- sass::sass(
    input = theme_scss,
    options = sass_options,
    output = sass::output_template(basename = theme_name, dirname = "sakura-"),
    cache = cache,
    write_attachments = TRUE,
    cache_key_extra = list(theme_name)
  )

  htmltools::htmlDependency(
    name = "sakura",
    version = "1.3.1",
    src = dirname(css_file),
    stylesheet = basename(css_file)
  )
}

#' List Sakura Themes
#'
#' @description
#' Sakura comes with a several themes that can be applied to the SCSS. This provides a list of all available options.
#'
#' @return
#' A vector of available CSS styles
#'
#' @examples
#' listSakuraThemes()
#'
#' @export
listSakuraThemes <- function() {
  SAKURA_THEMES
}

#' Get Sakura Themesheet
#'
#' @description
#' This will write the required style variables to a specified location to customise the sakura theme.
#'
#' @param file Location to write the file to, or \code{NULL} to print to the console
#' @param append If \code{TRUE} output will be appended to file; otherwise, it will overwrite the contents of file
#'
#' @return
#' A list of unasssigned style variables to be updated by the developer
#'
#' @examples
#' getSakuraThemesheet()
#'
#' @export
getSakuraThemesheet <- function(file = "", append = TRUE) {
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
