# d3Network

### [Christopher Gandrud](http://christophergandrud.blogspot.com/p/biocontact.html)

Tools for creating D3 JavaScript directed network graphs from R.

This package is in very early beta (but the functions work nicely).

---

This this package contains two key functions that allow you to make interactive directed network graphs in JavaScript with [D3](http://d3js.org/):

- `d3SimpleNetwork`: a limited function that makes it easy to create simple network graphs. To make it very simple, customisability is very limited. See [this post](http://christophergandrud.blogspot.kr/2013/06/quick-and-simple-d3-network-graphs-from.html) for details on how to use it.

- `d3Network`: this is the main function in the package. It gives you greater control in how you customise your graph (**capabilities will be added over time**). It also allows you to include the graph in [Slidify](http://slidify.org/) produced or many other HTML slideshows as an iframe.


---

## Installation

You can install *d3Network* using the [devtools](https://github.com/hadley/devtools) package and the following code:

```
devtools::install_github("d3Network", "christophergandrud")
```


