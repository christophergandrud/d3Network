# d3Network

### [Christopher Gandrud](http://christophergandrud.blogspot.com/p/biocontact.html)

Tools for creating D3 JavaScript directed network graphs from R.

This package is in very early beta (but the functions work nicely).

---

This this package contains two key functions that allow you to make interactive directed network graphs in JavaScript with [D3](http://d3js.org/) from R with data stored in data frames:

- `d3SimpleNetwork`: a limited function that makes it easy to create simple network graphs. To make it very simple, customisability is very limited. See [this post](http://christophergandrud.blogspot.kr/2013/06/quick-and-simple-d3-network-graphs-from.html) for details on how to use it.

- `d3Network`: this is the main function in the package. It gives you greater control in how you customise your graph (capabilities will be added over time). It also allows you to include the graph in [Slidify](http://slidify.org/) produced or many other HTML slideshows as an iframe.


---

## Example

<script src="http://d3js.org/d3.v2.js?2.9.1"></script> 
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

<script> 
var links = [ { "source" : "A", "target" : "B" }, { "source" : "A", "target" : "C" }, { "source" : "A", "target" : "D" }, { "source" : "A", "target" : "J" }, { "source" : "B", "target" : "E" }, { "source" : "B", "target" : "F" }, { "source" : "C", "target" : "G" }, { "source" : "C", "target" : "H" }, { "source" : "D", "target" : "I" } ] ; 
var width = 700 
height = 400 ; 

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
.on("tick", tick) 
.start(); 

var svg = d3.select("body").append("svg") 
.attr("width", width) 
.attr("height", height); 

var link = svg.selectAll(".link") 
.data(force.links()) 
.enter().append("line") 
.attr("class", "link"); 

var node = svg.selectAll(".node") 
.data(force.nodes()) 
.enter().append("g") 
.attr("class", "node") 
.on("mouseover", mouseover) 
.on("mouseout", mouseout) 
.on("click", click)
.on("dblclick", dblclick)
.call(force.drag); 

node.append("circle") 
.attr("r", 8)
.style("fill", function(d) { return color(d.value); });

node.append("text") 
.attr("x", 12) 
.attr("dy", ".35em") 
.style("fill", "steelblue")
.text(function(d) { return d.name; }); 

function tick() { 
link 
.attr("x1", function(d) { return d.source.x; }) 
.attr("y1", function(d) { return d.source.y; }) 
.attr("x2", function(d) { return d.target.x; }) 
.attr("y2", function(d) { return d.target.y; }); 

node 
.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; }); 
} 

function mouseover() { 
d3.select(this).select("circle").transition() 
.duration(750) 
.attr("r", 16); 
} 

function mouseout() { 
d3.select(this).select("circle").transition() 
.duration(750) 
.attr("r", 8); 
} 
// action to take on mouse click
function click() {
d3.select(this).select("text").transition()
.duration(750)
.attr("x", 22)
.style("stroke-width", ".5px")
.style("fill", "#E34A33")
.style("font", "20px serif");
d3.select(this).select("circle").transition()
.duration(750)
.style("fill", "#E34A33")
.attr("r", 16)
}

// action to take on mouse double click
function dblclick() {
d3.select(this).select("circle").transition()
.duration(750)
.attr("r", 6)
.style("fill", "#E34A33");
d3.select(this).select("text").transition()
.duration(750)
.attr("x", 12)
.style("stroke", "none")
.style("fill", "#E34A33")
.style("stroke", "none")
.style("font", "10px serif");
}

</script> 

---

## Installation

You can install *d3Network* using the [devtools](https://github.com/hadley/devtools) package and the following code:

```
devtools::install_github("d3Network", "christophergandrud")
```


