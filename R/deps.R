#' Classless Shiny Dependencies
#'
#' @description
#' Certain inputs need to be treated differently between classless frameworks and the shiny framework
#'
#' @return An HTML depedency
#'
#' @importFrom utils packageVersion
#' @noRd
classlessDependency <- function() {
  src_dir <- system.file("srcjs", package = "classless")

  htmltools::htmlDependency(
    name = "shiny-classless",
    version = packageVersion("classless"),
    src = src_dir,
    script = list.files(src_dir, pattern = "*.js"),
    stylesheet = list.files(src_dir, pattern = "*.css")
  )
}
