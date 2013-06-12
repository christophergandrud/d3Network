#' An R function for creating simple D3 javascript directed network graphs.
#'
#' \code{d3SimpleNetwork} creates simple D3 javascript network graphs.
#'
#' @param Data a data frame object with three columns. The first two are the names of the linked units. The third records an edge value. (Currently the third column doesn't affect the graph.)
#' @param Source character string naming the network source variable in the data frame. If \code{Source = NULL} then the first column of the data frame is treated as the source.
#' @param Target character string naming the network target variable in the data frame. If \code{Target = NULL} then the second column of the data frame is treated as the target.
#' @param height numeric height for the network graph's frame area.
#' @param width numeric width for the network graph's frame area.
#' @param file a character string of the file name to save the resulting graph. If a file name is given a standalone webpage is created, i.e. with a header and footer. If \code{file = NULL} then just the graph is returned to the console.
#'
#' @examples
#' # Fake data
#' Source <- c("A", "A", "A", "A", "B", "B", "C", "C", "D")
#' Target <- c("B", "C", "D", "J", "E", "F", "G", "H", "I")
#' NetworkData <- data.frame(Source, Target)
#' 
#' # Create graph
#' d3SimpleNetwork(NetworkData, height = 300, width = 700)
#'
#' @source 
#' D3.js was created by Michael Bostock. See http://d3js.org/
#' 
#' @export

d3SimpleNetwork <- function(Data, Source = NULL, Target = NULL, height = 600, width = 900, file = NULL)
{
  if (class(Data) != "data.frame"){
    stop("data must be a data frame class object.")
  }

  if (is.null(Source) & is.null(Target)){
    NetData <- Data[, 1:2]
  }
  else if (!is.null(Source) & !is.null(Target)){
    NetData <- data.frame(Data[, Source], Data[, Target])
  }

  names(NetData) <- c("source", "target")
  
  # Convert data frame to JSON format
  LinkData <- toJSONarray(NetData)
  LinkData <- paste("var links =", LinkData, "; \n")
  
  # Create webpage
  PageHead <- "
<!DOCTYPE html> 
<meta charset=\"utf-8\">
<body> \n"
  
  NetworkCSS <- "
<script src=\"http://d3js.org/d3.v2.js?2.9.1\"></script> 
<style> 

.link {  
stroke: #666;
opacity: 0.6;
stroke-width: 1.5px; 
} 

.node circle { 
stroke: #fff; 
opacity: 0.6;
stroke-width: 1.5px; 
} 

text { 
font: 7px serif; 
pointer-events: none; 
} 

</style> 

<script> \n "

  # width and height variables
  HeightWidth <- paste("var width =", width, "\n", 
"height =", height, "; \n")

  # Main script for creating the graph
  MainScript <- "
var nodes = {}

// Compute the distinct nodes from the links.
links.forEach(function(link) {
link.source = nodes[link.source] || 
(nodes[link.source] = {name: link.source});
link.target = nodes[link.target] || 
(nodes[link.target] = {name: link.target});
link.value = +link.value;
});

var color = d3.scale.category20();

var force = d3.layout.force() 
.nodes(d3.values(nodes)) 
.links(links) 
.size([width, height]) 
.linkDistance(80) 
.charge(-400) 
.on(\"tick\", tick) 
.start(); 

var svg = d3.select(\"body\").append(\"svg\") 
.attr(\"width\", width) 
.attr(\"height\", height); 

var link = svg.selectAll(\".link\") 
.data(force.links()) 
.enter().append(\"line\") 
.attr(\"class\", \"link\"); 

var node = svg.selectAll(\".node\") 
.data(force.nodes()) 
.enter().append(\"g\") 
.attr(\"class\", \"node\") 
.on(\"mouseover\", mouseover) 
.on(\"mouseout\", mouseout) 
.on(\"click\", click)
.on(\"dblclick\", dblclick)
.call(force.drag); 

node.append(\"circle\") 
.attr(\"r\", 8)
.style(\"fill\", function(d) { return color(d.value); });

node.append(\"text\") 
.attr(\"x\", 12) 
.attr(\"dy\", \".35em\") 
.style(\"fill\", \"steelblue\")
.text(function(d) { return d.name; }); 

function tick() { 
link 
.attr(\"x1\", function(d) { return d.source.x; }) 
.attr(\"y1\", function(d) { return d.source.y; }) 
.attr(\"x2\", function(d) { return d.target.x; }) 
.attr(\"y2\", function(d) { return d.target.y; }); 

node 
.attr(\"transform\", function(d) { return \"translate(\" + d.x + \",\" + d.y + \")\"; }); 
} 

function mouseover() { 
d3.select(this).select(\"circle\").transition() 
.duration(750) 
.attr(\"r\", 16); 
} 

function mouseout() { 
d3.select(this).select(\"circle\").transition() 
.duration(750) 
.attr(\"r\", 8); 
} 
// action to take on mouse click
function click() {
d3.select(this).select(\"text\").transition()
.duration(750)
.attr(\"x\", 22)
.style(\"stroke-width\", \".5px\")
.style(\"fill\", \"#E34A33\")
.style(\"font\", \"20px serif\");
d3.select(this).select(\"circle\").transition()
.duration(750)
.style(\"fill\", \"#E34A33\")
.attr(\"r\", 16)
}

// action to take on mouse double click
function dblclick() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 6)
.style(\"fill\", \"#E34A33\");
d3.select(this).select(\"text\").transition()
.duration(750)
.attr(\"x\", 12)
.style(\"stroke\", \"none\")
.style(\"fill\", \"#E34A33\")
.style(\"stroke\", \"none\")
.style(\"font\", \"10px serif\");
}

</script> \n"
  
  if (is.null(file)){
    cat(NetworkCSS, LinkData, HeightWidth, MainScript)
  } 
  else if (!is.null(file)){
    cat(PageHead, NetworkCSS, LinkData, HeightWidth, MainScript, 
        "</body>", file = file)
  }
}