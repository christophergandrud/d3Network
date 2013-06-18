\name{d3Network}
\alias{d3Network}
\title{An R function for creating simple D3 javascript directed network graphs.}
\source{
  D3.js was created by Michael Bostock. See
  <http://d3js.org/> and, more specifically for directed
  networks
  <https://github.com/mbostock/d3/wiki/Force-Layout>
}
\usage{
  d3Network(Data, Source = NULL, Target = NULL,
    Group = NULL, height = 600, width = 900, fontsize = 7,
    linkDistance = 50, charge = -200, standAlone = TRUE,
    file = NULL, iframe = FALSE)
}
\arguments{
  \item{Data}{a data frame object with three columns. The
  first two are the names of the linked units. The third
  records an edge value. (Currently the third column
  doesn't affect the graph.)}

  \item{Source}{character string naming the network source
  variable in the data frame. If \code{Source = NULL} then
  the first column of the data frame is treated as the
  source.}

  \item{Target}{character string naming the network target
  variable in the data frame. If \code{Target = NULL} then
  the second column of the data frame is treated as the
  target.}

  \item{height}{numeric height for the network graph's
  frame area in pixels.}

  \item{width}{numeric width for the network graph's frame
  area in pixels.}

  \item{fontsize}{numeric font size in pixels for the node
  text labels.}

  \item{linkDistance}{numeric distance between the links in
  pixels (actually arbitrary relative to the diagram's
  size).}

  \item{charge}{numeric value indicating either the
  strength of the node repulsion (negative value) or
  attraction (positive value).}

  \item{standAlone}{logical, whether or not to return a
  complete HTML document (with head and foot) or just the
  script.}

  \item{file}{a character string of the file name to save
  the resulting graph. If a file name is given a standalone
  webpage is created, i.e. with a header and footer. If
  \code{file = NULL} then result is returned to the
  console.}

  \item{iframe}{logical. If \code{iframe = TRUE} then the
  graph is saved to an external file in the working
  directory and an HTML \code{iframe} linking to the file
  is printed to the console. This is useful if you are
  using Slidify and many other HTML slideshow framworks and
  want to include the graph in the resulting page. If you
  set the knitr code chunk \code{results='asis'} then the
  graph will be rendered in the output. Usually, you can
  use \code{iframe = FALSE} if you are creating simple
  knitr Markdown or HTML pages. Note: you do not need to
  specify the file name if \code{iframe = TRUE}, however if
  you do, do not include the file path.}
}
\description{
  \code{d3Network} creates D3 javascript network graphs. It
  is much more customisable than
  \code{\link{d3SimpleNetwork}}
}
\examples{
# Fake data
Source <- c("A", "A", "A", "A", "B", "B", "C", "C", "D")
Target <- c("B", "C", "D", "J", "E", "F", "G", "H", "I")
NetworkData <- data.frame(Source, Target)

# Create graph
d3Network(NetworkData, height = 300, width = 700, fontsize = 15)
}

