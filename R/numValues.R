#' Iterates through columns to transform all data table values into numbers.
#'
#' @param data A data table.
#' @return The same data set, with all values coerced to numeric.

numValues <- function(data) {

  # Makes all values numeric
  cols <- ncol(data)
  for (i in 1:cols){
    data[,i] <- as.numeric(data[,i])
  }

  return(data)

}
