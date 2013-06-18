#' Internal function from Wei Luo to convert a data frame to a JSON array
#' 
#' @param dtf a data frame object.
#' @source Function from: <http://theweiluo.wordpress.com/2011/09/30/r-to-json-for-d3-js-and-protovis/>
#' @keywords internal
#' @noRD

toJSONarray <- function(dtf){
  clnms <- colnames(dtf)
  
  name.value <- function(i){
    quote <- '';
    if(class(dtf[, i])!='numeric'){
      quote <- '"';
    }
    paste('"', i, '" : ', quote, dtf[,i], quote, sep='')
  }
  objs <- apply(sapply(clnms, name.value), 1, function(x){paste(x, collapse=', ')})
  objs <- paste('{', objs, '}')
  
  res <- paste('[', paste(objs, collapse=', '), ']')
  
  return(res)
}


#' Read a text file into a single string
#' 
#' @source Code taken directly from Ramnath Vaidyanathan's Slidify <https://github.com/ramnathv/slidify>.
#' @param doc path to text document
#' @return string with document contents
#' @keywords internal
#' @noRd
read_file <- function(doc, ...){
  paste(readLines(doc, ...), collapse = '\n')
}