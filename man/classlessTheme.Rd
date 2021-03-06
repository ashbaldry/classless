% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/classless.R
\name{classlessTheme}
\alias{classlessTheme}
\title{Add Classless.css Theme to UI}
\usage{
classlessTheme(theme = NULL, tiny = FALSE, include_tabbox = TRUE)
}
\arguments{
\item{theme}{One of the following:
\itemize{
\item{\code{NULL} (the default), which implies a "stock" build of Classless.css}
\item{One of the themes available in \code{\link{listClasslessThemes}()}}
\item{A **named** character string pointing to an alternative Classless.css stylesheet
      (normally a css file within the www directory, e.g. \code{c(theme = "www/classless-theme.css")})}
}}

\item{tiny}{Logical, should only minimal CSS be included? If \code{TRUE} this will only include styles for text,
tables, figures and code.}

\item{include_tabbox}{Logical, should the styling for tab boxes be included?}
}
\value{
An \code{\link[htmltools]{htmlDependency}} to the relevant Classless.css style file
}
\description{
Creates the dependency required for Classless.css to be included in the HTML of a page.
}
\examples{
library(htmltools)
library(classless)

ui <- tags$html()
ui <- htmltools::attachDependencies(
  ui,
  classlessTheme()
)

}
