\name{d3SimpleNetwork}
\alias{d3SimpleNetwork}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
d3SimpleNetwork(Data, Source = NULL, Target = NULL, height = 600, width = 900, file = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Data}{
%%     ~~Describe \code{Data} here~~
}
  \item{Source}{
%%     ~~Describe \code{Source} here~~
}
  \item{Target}{
%%     ~~Describe \code{Target} here~~
}
  \item{height}{
%%     ~~Describe \code{height} here~~
}
  \item{width}{
%%     ~~Describe \code{width} here~~
}
  \item{file}{
%%     ~~Describe \code{file} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (Data, Source = NULL, Target = NULL, height = 600, width = 900, 
    file = NULL) 
{
    if (class(Data) != "data.frame") {
        stop("data must be a data frame class object.")
    }
    if (is.null(Source) & is.null(Target)) {
        NetData <- Data[, 1:2]
    }
    else if (!is.null(Source) & !is.null(Target)) {
        NetData <- data.frame(Data[, Source], Data[, Target])
    }
    names(NetData) <- c("source", "target")
    toJSONarray <- function(dtf) {
        clnms <- colnames(dtf)
        name.value <- function(i) {
            quote <- ""
            if (class(dtf[, i]) != "numeric") {
                quote <- "\""
            }
            paste("\"", i, "\" : ", quote, dtf[, i], quote, sep = "")
        }
        objs <- apply(sapply(clnms, name.value), 1, function(x) {
            paste(x, collapse = ", ")
        })
        objs <- paste("{", objs, "}")
        res <- paste("[", paste(objs, collapse = ", "), "]")
        return(res)
    }
    LinkData <- toJSONarray(NetData)
    LinkData <- paste("var links =", LinkData, "; \n")
    PageHead <- "\n<!DOCTYPE html> \n<meta charset=\"utf-8\">\n<body> \n"
    NetworkCSS <- "\n<script src=\"http://d3js.org/d3.v2.js?2.9.1\"></script> \n<style> \n\n.link {  \nstroke: #666;\nopacity: 0.6;\nstroke-width: 1.5px; \n} \n\n.node circle { \nstroke: #fff; \nopacity: 0.6;\nstroke-width: 1.5px; \n} \n\ntext { \nfont: 7px serif; \npointer-events: none; \n} \n\n</style> \n\n<script> \n "
    HeightWidth <- paste("var width =", width, "\n", "height =", 
        height, "; \n")
    MainScript <- "\nvar nodes = {}\n\n// Compute the distinct nodes from the links.\nlinks.forEach(function(link) {\nlink.source = nodes[link.source] || \n(nodes[link.source] = {name: link.source});\nlink.target = nodes[link.target] || \n(nodes[link.target] = {name: link.target});\nlink.value = +link.value;\n});\n\nvar color = d3.scale.category20();\n\nvar force = d3.layout.force() \n.nodes(d3.values(nodes)) \n.links(links) \n.size([width, height]) \n.linkDistance(80) \n.charge(-400) \n.on(\"tick\", tick) \n.start(); \n\nvar svg = d3.select(\"body\").append(\"svg\") \n.attr(\"width\", width) \n.attr(\"height\", height); \n\nvar link = svg.selectAll(\".link\") \n.data(force.links()) \n.enter().append(\"line\") \n.attr(\"class\", \"link\"); \n\nvar node = svg.selectAll(\".node\") \n.data(force.nodes()) \n.enter().append(\"g\") \n.attr(\"class\", \"node\") \n.on(\"mouseover\", mouseover) \n.on(\"mouseout\", mouseout) \n.on(\"click\", click)\n.on(\"dblclick\", dblclick)\n.call(force.drag); \n\nnode.append(\"circle\") \n.attr(\"r\", 8)\n.style(\"fill\", function(d) { return color(d.value); });\n\nnode.append(\"text\") \n.attr(\"x\", 12) \n.attr(\"dy\", \".35em\") \n.style(\"fill\", \"steelblue\")\n.text(function(d) { return d.name; }); \n\nfunction tick() { \nlink \n.attr(\"x1\", function(d) { return d.source.x; }) \n.attr(\"y1\", function(d) { return d.source.y; }) \n.attr(\"x2\", function(d) { return d.target.x; }) \n.attr(\"y2\", function(d) { return d.target.y; }); \n\nnode \n.attr(\"transform\", function(d) { return \"translate(\" + d.x + \",\" + d.y + \")\"; }); \n} \n\nfunction mouseover() { \nd3.select(this).select(\"circle\").transition() \n.duration(750) \n.attr(\"r\", 16); \n} \n\nfunction mouseout() { \nd3.select(this).select(\"circle\").transition() \n.duration(750) \n.attr(\"r\", 8); \n} \n// action to take on mouse click\nfunction click() {\nd3.select(this).select(\"text\").transition()\n.duration(750)\n.attr(\"x\", 22)\n.style(\"stroke-width\", \".5px\")\n.style(\"fill\", \"#E34A33\")\n.style(\"font\", \"20px serif\");\nd3.select(this).select(\"circle\").transition()\n.duration(750)\n.style(\"fill\", \"#E34A33\")\n.attr(\"r\", 16)\n}\n\n// action to take on mouse double click\nfunction dblclick() {\nd3.select(this).select(\"circle\").transition()\n.duration(750)\n.attr(\"r\", 6)\n.style(\"fill\", \"#E34A33\");\nd3.select(this).select(\"text\").transition()\n.duration(750)\n.attr(\"x\", 12)\n.style(\"stroke\", \"none\")\n.style(\"fill\", \"#E34A33\")\n.style(\"stroke\", \"none\")\n.style(\"font\", \"10px serif\");\n}\n\n</script> \n"
    if (is.null(file)) {
        cat(NetworkCSS, LinkData, HeightWidth, MainScript)
    }
    else if (!is.null(file)) {
        cat(PageHead, NetworkCSS, LinkData, HeightWidth, MainScript, 
            "</body>", file = file)
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
