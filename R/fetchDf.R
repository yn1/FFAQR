#' Returns the specific data frame requested.
#' See ?FFAQR for further information.
#' 
#' @param name Name of data frame requested.

fetchDf <- function(name) {

  start <- system.file(package="FFAQR")
  dname <- paste0(start, "/data/", name, ".Rdata")
  nm <- load(dname)
  data <- get(nm)
  
  return(data)
  
}