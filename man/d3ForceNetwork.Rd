\name{d3ForceNetwork}
\alias{d3ForceNetwork}
\title{Create a D3 JavaScript force directed network graph.}
\source{
  D3.js was created by Michael Bostock. See
  \url{http://d3js.org/} and, more specifically for
  directed networks
  \url{https://github.com/mbostock/d3/wiki/Force-Layout}
}
\usage{
  d3ForceNetwork(Links, Nodes)
}
\arguments{
  \item{Links}{a data frame object with the links between
  the nodes. It should have include the \code{Source} and
  \code{Target} for each link.}

  \item{Nodes}{a data frame}
}
\description{
  Create a D3 JavaScript force directed network graph.
}

