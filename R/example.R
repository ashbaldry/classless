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
        tags$section(
          tags$section("Block and Inline Eleemtns")
        ),
        tags$section(
          tags$h3("Headings"),
          tags$h1("Heading Level 1"),
          tags$h2("Heading Level 2"),
          tags$h3("Heading Level 3"),
          tags$h4("Heading Level 4"),
          tags$h5("Heading Level 5"),
          tags$h6("Heading Level 6")
        )
      ),

      tags$section(
        tags$h2("Inputs"),
        tags$form(
          tags$aside(
            tags$h3("Input values:"),
            tags$ul(
              tags$li("Text:", textOutput("text_value", container = tags$output)),
              tags$li("Number:", textOutput("number_value", container = tags$output)),
              tags$li("Password:", textOutput("password_value", container = tags$output)),
              tags$li("Date:", textOutput("date_value", container = tags$output)),
              tags$li("Text Area:", textOutput("textarea_value", container = tags$output))
            )
          ),
          tags$fieldset(
            tags$legend("Input Fields"),
            framework$textInput("text", "Text Input"),
            framework$numericInput("number", "Numeric Input"),
            framework$passwordInput("password", "Password Input"),
            framework$dateInput("date", "Date Input"),
            framework$textAreaInput("textarea", "Text Area Input")
          ),
          tags$aside(
            tags$ul(
              tags$li("Single Checkbox:", textOutput("checkbox_value", container = tags$output))
            )
          ),
          tags$fieldset(
            tags$legend("Checkboxes and Radio Buttons"),
            framework$checkboxInput("checkbox", "Checkbox Input")
          ),
          tags$aside(
            tags$ul(
              tags$li("Button:", textOutput("button_value", container = tags$output))
            )
          ),
          tags$fieldset(
            tags$legend("Buttons"),
            framework$actionButton("button", "Action Button")
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
  output$text_value <- renderText(input$text)
  output$number_value <- renderText(input$number)
  output$password_value <- renderText(input$password)
  output$date_value <- renderText(as.character(input$date))
  output$textarea_value <- renderText(input$textarea)
  output$checkbox_value <- renderText(as.character(input$checkbox))
  output$button_value <- renderText(input$button)
}
