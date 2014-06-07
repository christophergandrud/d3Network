d3Network
===

Tools for creating D3 JavaScript network, tree, dendrogram, and Sankey graphs from R.

[Christopher Gandrud](http://christophergandrud.blogspot.com/p/biocontact.html)

Version: 0.5.1

[![Build Status](https://travis-ci.org/christophergandrud/d3Network.png)](https://travis-ci.org/christophergandrud/d3Network)

## Minimal Example

Click the image to see a working example:

<a href="http://dl.dropboxusercontent.com/u/12581470/Presentations/OddsAndEnds/NetworkD3.html" imageanchor="1" ><img border="0" src="http://1.bp.blogspot.com/-gFxgVvzBSr8/UbPgDW-7fnI/AAAAAAAAGiE/an2RbjOC-68/s320/NetworkD3.png"/></a>

This is the code to create the graph:

```{S}
# Create fake data
Source <- c("A", "A", "A", "A", "B", "B", "C", "C", "D")
Target <- c("B", "C", "D", "J", "E", "F", "G", "H", "I")
NetworkData <- data.frame(Source, Target)

# Make network graph
d3SimpleNetwork(NetworkData, height = 300, width = 700)
```

Many more examples can be found on the package's [main page](http://christophergandrud.github.io/d3Network/).

## Installation

You can install *d3Network* using the [devtools](https://github.com/hadley/devtools) package and the following code:

```{S}
devtools::install_github('christophergandrud/d3Network')
```
