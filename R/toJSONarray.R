#' Internal function from Wei Luo to convert a data frame to a JSON array
#' 
#' @param dtf a data frame object.
#' 
#' @source Function from: http://theweiluo.wordpress.com/2011/09/30/r-to-json-for-d3-js-and-protovis/
#' 
#' @export

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