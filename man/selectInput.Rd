% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/select.R
\name{selectCLInput}
\alias{selectCLInput}
\title{Create a select list input control}
\usage{
selectCLInput(input_id, label, choices, selected = NULL, multiple = FALSE)
}
\arguments{
\item{input_id}{The input slot that will be used to access the value}

\item{label}{Display label for the control, or \code{NULL} for no label.}

\item{choices}{List of values to select from. If elements of the list are
named, then that name --- rather than the value --- is displayed to the
user. It's also possible to group related inputs by providing a named list
whose elements are (either named or unnamed) lists, vectors, or factors. In
this case, the outermost names will be used as the group labels (leveraging
the \verb{<optgroup>} HTML tag) for the elements in the respective sublist. See
the example section for a small demo of this feature.}

\item{selected}{The initially selected value (or multiple values if \code{multiple = TRUE}). If not specified then defaults to the first value for
single-select lists and no values for multiple select lists.}

\item{multiple}{Is selection of multiple items allowed?}
}
\description{
Create a select list that can be used to choose a single or multiple items from a list of values.
}
\examples{
selectCLInput(
  "letter",
  "Select a letter",
  LETTERS
)

}
