#' Finds the row in a data frame at which column 1 is a given string.
#' 
#' @param sheet A data table.
#' @param start Which row to start looking at, going down.
#' @param breakpt Which phrase stops the loop
#' @return The number of the row at which to set a breakpoint.

findBreak <- function(sheet, start=1, breakpt) {
  
  # Loops through sheet[n,1] until break reached
  ans <- start
  while (toString(sheet[ans,1]) != breakpt) {
    ans <- ans+1
  }
  
  return(ans)
  
}