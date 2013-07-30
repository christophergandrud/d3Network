\name{d3ClusterDendro}
\alias{d3ClusterDendro}
\title{Create a D3 JavaScript Cluster Dendrogram graphs.}
\source{
  Mike Bostock \url{http://bl.ocks.org/mbostock/4063570}.
}
\usage{
  d3ClusterDendro(List, height = 2200, width = 900,
    heightCollapse = 0, widthCollapse = 0.5, fontsize = 10,
    linkColour = "#ccc", nodeColour = "#3182bd",
    textColour = "#3182bd", opacity = 0.8, diameter = 980,
    zoom = FALSE, standAlone = TRUE, file = NULL,
    iframe = FALSE,
    d3Script = "http://d3js.org/d3.v3.min.js")
}
\arguments{
  \item{List}{a hierarchical list object with a root node
  and children.}

  \item{height}{numeric height for the network graph's
  frame area in pixels.}

  \item{width}{numeric width for the network graph's frame
  area in pixels.}

  \item{heightCollapse}{numeric proportion of the overall
  graph \code{height} to make the cluster dendrogram
  shorter by.}

  \item{widthCollapse}{numeric proportion of the overall
  graph \code{width} to make the cluster dendrogram
  narrower by.}

  \item{fontsize}{numeric font size in pixels for the node
  text labels.}

  \item{linkColour}{character string specifying the colour
  you want the link lines to be. Multiple formats supported
  (e.g. hexadecimal).}

  \item{nodeColour}{character string specifying the colour
  you want the node circles to be. Multiple formats
  supported (e.g. hexadecimal).}

  \item{textColour}{character string specifying the colour
  you want the text to be before they are clicked. Multiple
  formats supported (e.g. hexadecimal).}

  \item{opacity}{numeric value of the proportion opaque you
  would like the graph elements to be.}

  \item{diameter}{numeric diameter for the network in
  pixels.}

  \item{zoom}{logical, whether or not to enable the ability
  to use the mouse scroll-wheel to zoom in and out of the
  graph.}

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

  \item{d3Script}{a character string that allows you to
  specify the location of the d3.js script you would like
  to use. The default is
  \url{http://d3js.org/d3.v3.min.js}.}
}
\description{
  Create a D3 JavaScript Cluster Dendrogram graphs.
}
\examples{
# Download JSON data
library(RCurl)
URL <- "https://raw.github.com/christophergandrud/d3Network/master/JSONdata/flare.json"
Flare <- getURL(URL)

# Convert to list format
Flare <- rjson::fromJSON(Flare)

# Recreate Bostock example from http://bl.ocks.org/mbostock/4063570
d3ClusterDendro(List = Flare,
		file = "FlareCluster.html", zoom = TRUE,
       fontsize = 10, opacity = 0.9,
       widthCollapse = 0.8)
}

