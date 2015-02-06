#' Reads in, cleans, and subdivides monthly TSM data set in data folder.

cleanAQRTSMMonthly <- function() {
  
  temp <- tempfile()
  TSMMonthly <- "https://www.aqr.com/~/media/files/data-sets/time-series-momentum-factors-monthly.xlsx"
  download.file(TSMMonthly, temp, method = "curl")
  
  # Imports time series momentum factors
  TSMMonthly <- read.xlsx(temp, "TSMOM Factors",
                                     ,startRow=18, colIndex=c(1:6))
  row.names(TSMMonthly) <- NULL
  names(TSMMonthly)[1] <- "Date"
  
  x1 <- findBreak(TSMMonthly, 300, "NA") - 1
  TSMMonthly[,1] <- ymd(TSMMonthly[,1])
  TSMMonthly <- TSMMonthly[(1:x1),]
  
  unlink(temp)

  start <- system.file(package="FFAQR")
  save(TSMMonthly, file=paste0(start, "/data/AQRTSMMonthly.Rdata"))
  
}

