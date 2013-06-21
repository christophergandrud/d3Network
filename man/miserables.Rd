\name{miserables}
\alias{miserables}
\docType{data}
\title{   
  JSON data file of Les Miserables charcters and their co-occurances.
}
\description{
  JSON data file of Les Miserables charcters and their co-occurances. Compiled by Donald Knuth. Because it is a JSON file it cannot be important directly into R like other data sets.
}
\format{
  A JSON file with two arrays.
  \describe{
    \item{\code{links}}{an array with source, target, and value objects}
    \item{\code{nodes}}{an array with name and group objects}
  }
}
\details{
  Note: this data set cannot by loaded using the usual \code{data(miserables)} way. It needs to be loaded directly with \code{\link{fromJSON}} (for the full dataset) or \code{\link{JSONtoDF}} to extract either array and place it in a data frame object.
}
\source{
  Original data compiled by Donald Knuth. See \url{http://www-cs-faculty.stanford.edu/~uno/sgb.html}.
}
\references{
  JSON formatted file from  Michael Bostock. See \url{http://bl.ocks.org/mbostock/4062045}.
}
\keyword{datasets}
