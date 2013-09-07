#' Create a D3 JavaScript Sankey diagram
#'
#' 
#'
#' @param standAlone logical, whether or not to return a complete HTML document (with head and foot) or just the script.
#' @param file a character string of the file name to save the resulting graph. If a file name is given a standalone webpage is created, i.e. with a header and footer. If \code{file = NULL} then result is returned to the console. 
#' @param iframe logical. If \code{iframe = TRUE} then the graph is saved to an external file in the working directory and an HTML \code{iframe} linking to the file is printed to the console. This is useful if you are using Slidify and many other HTML slideshow framworks and want to include the graph in the resulting page. If you set the knitr code chunk \code{results='asis'} then the graph will be rendered in the output. Usually, you can use \code{iframe = FALSE} if you are creating simple knitr Markdown or HTML pages. Note: you do not need to specify the file name if \code{iframe = TRUE}, however if you do, do not include the file path.
#' @param d3Script a character string that allows you to specify the location of the d3.js script you would like to use. The default is \url{http://d3js.org/d3.v3.min.js}.
#'
#'
#' @source 
#' D3.js was created by Michael Bostock. See \url{http://d3js.org/} and, more specifically for Sankey diagrams \url{http://bost.ocks.org/mike/sankey/}.
#' 
#' @importFrom whisker whisker.render
#'
#'
#' @export

d3Sankey <- function(standAlone = TRUE, file = NULL, iframe = FALSE, d3Script = "http://d3js.org/d3.v3.min.js")
{
	if (!isTRUE(standAlone) & isTRUE(iframe)){
    	stop("If iframe = TRUE then standAlone must be TRUE.")
  	}
	# If no file name is specified create random name to avoid conflicts
	if (is.null(file) & isTRUE(iframe)){
		Random <- paste0(sample(c(0:9, letters, LETTERS), 5, replace=TRUE), collapse = "")
		file <- paste0("NetworkGraph", Random, ".html")
	}

	# Create iframe dimensions larger than graph dimensions
	FrameHeight <- height + height * 0.07
	FrameWidth <- width + width * 0.03
}