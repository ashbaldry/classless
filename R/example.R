FRAMEWORKS <- c("almond", "classless", "sakura")

#' Run classless Example App
#'
#' @description
#' Test out the classless CSS frameworks. It is a kitchen sink of all of the HTML tags available.
#'
#' All applications use the same R code, with the exception of the outer "page" function call.
#'
#' @param framework The name of the framework to
#' @param ... Arguments to pass to the relevant page
#'
#' @importFrom tools toTitleCase
#'
#' @name runClasslessExample
#' @rdname runClasslessExample
#'
#' @export
runClasslessExample <- function(framework, ...) {
  UseMethod("runClasslessExample")
}

#' @rdname runClasslessExample
#' @export
runClasslessExample.default <- function(framework = FRAMEWORKS, ...) {
  framework <- match.arg(framework)
  r6_class <- get(paste0(tools::toTitleCase(framework), "CSS"))

  framework_obj <- r6_class$new()

  shiny::shinyApp(
    ui = framework_obj$createPage(
      title = paste("Example", framework, "Application"),
      exampleUI(framework_obj),
      ...
    ),
    server = function(input, output) {}
  )
}

#' @rdname runClasslessExample
runClasslessExample.Classless <- function(framework, ...) {
  shiny::shinyApp(
    ui = framework$createPage(
      title = paste("Example", framework$getFramework(), "Application"),
      exampleUI(framework),
      ...
    ),
    server = exampleServer
  )
}

#' @param framework \code{classless} object
#' @noRd
exampleUI <- function(framework) {
  tags$body(
    tags$header(
      tags$h1(paste0(tools::toTitleCase(framework$getFramework()), ".CSS Kitchen Sink"))
    ),
    tags$main(
      tags$section(
        tags$h2("Typeography"),

      ),

      tags$section(
        tags$h2("Inputs"),
        tags$form(
          framework$textInput("text", "Text Input"),
          framework$numericInput("number", "Numeric Input"),
          framework$passwordInput("password", "Password Input"),
          framework$dateInput("date", "Date Input"),
          framework$textAreaInput("textarea", "Text Area Input")
        ),

        tags$aside(
          tags$h3("Input values:"),
          tags$ul(
            tags$li("Text:", textOutput("text", inline = TRUE)),
            tags$li("Number:", textOutput("number", inline = TRUE)),
            tags$li("Password:", textOutput("password", inline = TRUE)),
            tags$li("Date:", textOutput("date", inline = TRUE)),
            tags$li("Text Area:", textOutput("textarea", inline = TRUE))
          )
        )
      ),

      tags$section(
        tags$h2("Images")
      )
    ),
    tags$footer(
      tags$hr(),
      tags$p(
        "Source code available on",
        tags$a(href = "https://github.com/ashbaldry/classless", target = "_blank", "GitHub")
      )
    )
  )
}

#' @noRd
exampleServer <- function(input, output) {
  output$text <- renderText(input$text)
  output$number <- renderText(input$number)
  output$password <- renderText(input$password)
  output$date <- renderText(as.character(input$date))
  output$textarea <- renderText(input$textarea)
}
