
<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test coverage](https://codecov.io/gh/ashbaldry/classless/branch/main/graph/badge.svg)](https://app.codecov.io/gh/ashbaldry/classless?branch=main)
[![R-CMD-check](https://github.com/ashbaldry/classless/workflows/R-CMD-check/badge.svg)](https://github.com/ashbaldry/classless/actions)
<!-- badges: end -->

# {classless}

`{classless}` contains a selection of classless CSS frameworks that can be used within shiny applications.

Classless frameworks use the concept [semantic HTML](https://en.wikipedia.org/wiki/Semantic_HTML), which is the use of HTML markup to reinforce the semantics, or meaning, of the information in web pages and web applications rather than merely to define its presentation or look. Rather than using `<div>` and `<span>` tags throughout a webpage, there are many different [HTML elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Element) that can be used to better describe what the contents include. This is particularly useful for accessibility, where screen readers can better understand the structure of the of the document. 

Currently the following frameworks are included in `{classless}`:

- [`Almond.CSS`](https://github.com/alvaromontoro/almond.css)
- [`Classless.css`](https://github.com/emareg/classlesscss)
- [`sakura`](https://github.com/oxalorg/sakura)

## Installation

``` r
# Install the latest version from GitHub:
devtools::install_github("ashbaldry/classless")
```

## Usage

Each framework includes a `<framework>Page` function that can be used to generate all the HTML from scratch. 

There is also an R6 class available for each framework, that includes creating a page. This makes it very simple to switch from one framework to another with little/no change required in the code base.

### Examples

To have a look at an example page, there is an example method available in the R6 class:

``` r
AlmondCSS$new()$runExample()
```

### Additional Frameworks

To use a framework not covered by `{classless}`, use the `Classless` R6 object as the inherit class to build up your own framework. With the exception of the page function, everything is available within `Classless` to enable you to build a semantic webpage.
