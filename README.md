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

Click the image to see a working example:

<a href="http://dl.dropboxusercontent.com/u/12581470/Presentations/OddsAndEnds/NetworkD3.html" imageanchor="1" ><img border="0" src="http://1.bp.blogspot.com/-gFxgVvzBSr8/UbPgDW-7fnI/AAAAAAAAGiE/an2RbjOC-68/s320/NetworkD3.png"/></a>

This is the code to create the graph:

```r
# Create fake data
Source <- c("A", "A", "A", "A", "B", "B", "C", "C", "D")
Target <- c("B", "C", "D", "J", "E", "F", "G", "H", "I")
NetworkData <- data.frame(Source, Target)

# Make network graph 
d3SimpleNetwork(NetworkDatad3, height = 300, width = 700)
```

---

## Installation

You can install *d3Network* using the [devtools](https://github.com/hadley/devtools) package and the following code:

```r
devtools::install_github("d3Network", "christophergandrud")
```


