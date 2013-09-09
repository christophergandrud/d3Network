# d3Network

### [Christopher Gandrud](http://christophergandrud.blogspot.com/p/biocontact.html)

Tools for creating D3 JavaScript directed network graphs from R.

---

---

## Minimal Example

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

Many more examples can be found on the package's [main page](http://christophergandrud.github.io/d3Network/).

---

## Installation

You can install *d3Network* using the [devtools](https://github.com/hadley/devtools) package and the following code:

```r
devtools::install_github("d3Network", "christophergandrud")
```


