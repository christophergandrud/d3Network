<title>D3network by christophergandrud</title>

<link rel="stylesheet" href="assets/css/styles.css">

<a href="https://github.com/christophergandrud/d3Network"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_right_gray_6d6d6d.png" alt="Fork me on GitHub"></a>

[Christopher Gandrud](http://christophergandrud.blogspot.com/p/biocontact.html)

<section>

<h1 id="top">d3Network</h1>

### Tools for creating D3 JavaScript directed network graphs from R.

### v0.2


---

[Mike Bostock](http://bost.ocks.org/mike/)'s [D3.js](http://d3js.org/) is great for creating [interactive network graphs](http://bl.ocks.org/mbostock/4062045) with JavaScript.  The [d3Network](https://github.com/christophergandrud/d3Network) package makes it easy to create these network graphs from [R](http://www.r-project.org/). The main idea is that you should able to take an R data frame of information about the relationships between members of a network and create full network graphs with one command.

Currently **d3Network** only supports [force directed](http://en.wikipedia.org/wiki/Force-directed_graph_drawing) network graphs. Basically, D3 assigns forces to the nodes and edges (links between the nodes) to arrange their placement and simulate movement. We'll see of examples below that make this concept intuitive sense. 


## Commands

**d3Network** currently has two basic commands for creating network graphs: <a href="#simple"><code>d3SimpleNetwork</code></a> and <a href="#forceDirect"><code>d3ForceDirected</code></a>. 

<h3 id="simple"><code>d3SimpleNetwork</code></h3>

`d3SimpleNetwork` is designed to take a simple data frame that has two columns specifying the *sources* and *targets* of the nodes in a network and turn it into a graph. You can easily customise the look and feel of the graph. Let's do create an example. 

First let's make up some fake data. 


```r
Source <- c("A", "A", "A", "A", "B", "B", "C", "C", "D")
Target <- c("B", "C", "D", "J", "E", "F", "G", "H", "I")
NetworkData <- data.frame(Source, Target)
```


It's important to note that the *Source* variable is the first variable and the *Target* is the second. We can use the `Source` and `Target` arguments to specify which variables are which, if the data is in another order.  

Now we can simply stick the `NetworkData` data frame into `d3SimpleNetwork`:


```r
d3SimpleNetwork(NetworkData, width = 400, height = 250)
```


You'll notice that I added the `width` and `height` arguments. These change the size of the graph area. They are in pixels.

And here is the result:

<iframe src='img/FirstNetwork.html' height=267.5 width=412></iframe>


There are many options for to customising the look and feel of the graph. For example we can change the colour of the links, nodes, and text. We can also change the opacity of the graph elements:


```r
d3SimpleNetwork(NetworkData, width = 400, height = 250, 
                textColour = "orange", linkColour = "red", 
                nodeColor = "orange", opacity = 0.9)
```


<iframe src='img/SecondNetwork.html' height=267.5 width=412></iframe>


There are many different ways you can use to specify the colours other than just their names (as in this example). One way to select more specific colour is with [hexadecimal colour values](http://en.wikipedia.org/wiki/Web_colors#Shorthand_hexadecimal_form). A nice resource for choosing colour pallets is the [Color Brewer](http://colorbrewer2.org/) website. The next example uses hexadecimal colour values.

Other important ways to customise a force directed graph are to change the *link distance* and *charge*. Link distance is simply the distance between the nodes. Charge specifies how strong the force either repelling or pulling together the nodes is. Here is an example with a charge of -50: 


```r
d3SimpleNetwork(NetworkData, width = 400, height = 250, 
                textColour = "#D95F0E", linkColour = "#FEC44F", 
                nodeColour = "#D95F0E", opacity = 0.9,
                charge = -50, fontsize = 12)
```


<iframe src='img/ThirdNetwork.html' height=267.5 width=412></iframe>


This is a weaker charge than we have seen so far (the default is -200). A weak negative charge means that the nodes do not repel each other as strongly. So, they are closer together than if there was a larger negative charge. Using a positive number would make the nodes actually attracted to one another. Basically, you will get a clump of nodes. The text was a little small so I increased the *fontsize* to 12.

Have a look at the `d3SimpleNetwork` documentation for more customisation options.

<h3 id="forceDirect"><code>d3ForceDirected</code></h3>

If you want to make more complex force directed graph structures use `d3ForceNetwork`. It allows you to use individual link and node properties to change the distance between individual nodes and the colour of the nodes depending on their membership in specific groups.

Maybe it's better to understand this with an example. We'll use `d3ForceDirected`  to recreate [this example](http://bl.ocks.org/mbostock/4062045) by Mike Bostock's. The network graph shows *Les Misérables*' charcters co-occurance (the original data was gathered by [Donald Knuth](http://www-cs-faculty.stanford.edu/~uno/sgb.html). The link distances are based on how close the characters are and the colours symbolise how different character groups.

To start out with let's gather the basic data and create two data frames. One of the data frames will have information in the links, similar to what we have worked with so far. The other will have information on individaul nodes (in this case *Les Misérables* characters).


```r
# Load RCurl package for downloading the data
library(RCurl)

# Gather raw JSON formatted data
URL <- "https://raw.github.com/christophergandrud/d3Network/master/JSONdata/miserables.json"
MisJson <- getURL(URL)

# Convert JSON arrays into data frames
MisLinks <- JSONtoDF(jsonStr = MisJson, array = "links")
MisNodes <- JSONtoDF(jsonStr = MisJson, array = "nodes")
```


In this example we converted a [JSON](http://en.wikipedia.org/wiki/JSON)-formatted file into two data frames. You can of course just work with R data frames. Now let's look inside these data frames:


```r
# Show data frame structures
head(MisLinks)
```

```
##   source target value
## 1      1      0     1
## 2      2      0     8
## 3      3      0    10
## 4      3      2     6
## 5      4      0     1
## 6      5      0     1
```

```r

head(MisNodes)
```

```
##              name group
## 1          Myriel     1
## 2        Napoleon     1
## 3 Mlle.Baptistine     1
## 4    Mme.Magloire     1
## 5    CountessdeLo     1
## 6        Geborand     1
```


You can see in the `MisLinks` data frame that we again have `source` and `target` columns as before. Notice that the data frame is sorted by `source`. We have a new column: `value`. This will be used to determine the link distances.

In the `MisNodes` data frame we have two columns: `name` and `group`. There is one record for each character (node) in the network. They are in the same order as the `source` column in `MisLinks`. The `group` column simply specifies what group each character is in. This will be used to set the nodes' colours.

To make the network graph we just need to tell `d3ForceNetork` where the data frames and these nodes are:


```r
d3ForceNetwork(Links = MisLinks, Nodes = MisNodes, 
               Source = "source", Target = "target", 
               Value = "value", NodeID = "name", 
               Group = "group", width = 550, height = 425, 
               opacity = 0.9,)
```


<iframe src='img/Forced.html' height=454.8 width=566.5></iframe>


Mouse over the nodes to see the characters' names.

<h2 id="standAlone">d3Network in stand alone documents</h2>

So far we have only seen the basic syntax for how to create the network graphs. If you've been following along you'll notice that running a `d3Network` command spits out the HTML and JavaScript code to create the graph into your R console. If you want to save it to a file creating an stand alone HTML file (i.e. you can just double click on it an the graph will open in your browser) use the `file` option. For example:


```r
d3SimpleNetwork(NetworkData, file = "ExampleGraph.html")
```


This will create a new file called `ExampleGraph.html` in your working directory.

## d3Network in dynamic reproducible documents

If you would like to include network graphs in a [knitr](http://yihui.name/knitr/) [Markdown](http://daringfireball.net/projects/markdown/) dynamically reproducible document just place your *d3Network* code in a code chunk with the option `results='asis'`. Also set the argument `iframe = TRUE` and specify a file name with `file` as before. 

## Installation

You can install **d3Network** using the [devtools](https://github.com/hadley/devtools) package and the following code:


```r
devtools::install_github("d3Network", "christophergandrud")
```


</section>

<footer>

<div style="float:right"><a href="#top">Back to Top</a></div>

[Christopher Gandrud](http://christophergandrud.blogspot.com/p/biocontact.html)

<a href="https://twitter.com/ChrisGandrud"><img src="https://raw.github.com/christophergandrud/RepResR-RStudio/gh-pages/img/twitter-bird-Logo.png" alt="@ChrisGandrud" height="45" width="45"></a> <a href="https://github.com/christophergandrud"><img src="https://raw.github.com/christophergandrud/RepResR-RStudio/gh-pages/img/Octocat.png" alt="Gandrud GitHub page" height="35" width="37"></a>

</footer>


