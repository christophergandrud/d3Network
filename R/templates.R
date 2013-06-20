#' Basic HTML Header
#'
#' @keywords internals
#' @noRd

BasicHead <- function(){
"<!DOCTYPE html> 
<meta charset=\"utf-8\">
<body> \n"
}

#' Mustache basic CSS template for d3Network
#' 
#' @keywords internals
#' @noRd

BasicStyleSheet <- function(){
"<style> 
.link {  
stroke: {{linkColour}};
opacity: {{opacity}};
stroke-width: 1.5px; 
} 
.node circle { 
stroke: #fff; 
opacity: {{opacity}};
stroke-width: 1.5px; 
} 
text { 
font: {{fontsize}}px serif; 
opacity: {{opacity}};
pointer-events: none; 
} 
</style> 

<script src=\"http://d3js.org/d3.v3.min.js\"></script>

<script> \n"
}

#' Mustache basic Force Directed Network template for d3Network
#' 
#' @keywords internals
#' @noRd

BasicForceJS <- function(){
"var nodes = {}

// Compute the distinct nodes from the links.
links.forEach(function(link) {
link.source = nodes[link.source] || 
(nodes[link.source] = {name: link.source});
link.target = nodes[link.target] || 
(nodes[link.target] = {name: link.target});
link.value = +link.value;
});

var width = {{width}}
height = {{height}};

var force = d3.layout.force() 
.nodes(d3.values(nodes)) 
.links(links) 
.size([width, height]) 
.linkDistance({{linkDistance}}) 
.charge({{charge}}) 
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
.style(\"fill\", \"{{nodeColour}}\");

node.append(\"text\") 
.attr(\"x\", 12) 
.attr(\"dy\", \".35em\") 
.style(\"fill\", \"{{textColour}}\")
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
.style(\"opacity\", 1)
.style(\"fill\", \"{{nodeClickColour}}\")
.style(\"font\", \"{{clickTextSize}}px serif\");
d3.select(this).select(\"circle\").transition()
.duration(750)
.style(\"fill\", \"{{nodeClickColour}}\")
.attr(\"r\", 16)
}

// action to take on mouse double click
function dblclick() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 6)
.style(\"fill\", \"{{nodeClickColour}}\");
d3.select(this).select(\"text\").transition()
.duration(750)
.attr(\"x\", 12)
.style(\"stroke\", \"none\")
.style(\"fill\", \"{{nodeClickColour}}\")
.style(\"stroke\", \"none\")
.style(\"opacity\", {{opacity}})
.style(\"font\", \"{{fontsize}}px serif\");
}

</script>\n"
}