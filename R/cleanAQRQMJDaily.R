#' Reads in, cleans, and subdivides daily QMJ data set in data folder.
#' Currently disabled, Java heap runs out of memory when reading xlsx.

cleanAQRQMJDaily <- function() {
  
  temp <- tempfile()
  QMJDaily <- "https://www.aqr.com/~/media/files/data-sets/quality-minus-junk-factors-daily.xlsx"
  download.file(QMJDaily, temp, method = "curl")
  
  # Imports QMJ data
  AQRQMJFactorsDaily <- read.xlsx(temp, "QMJ Factors", startRow=19, colIndex=c(1:30))
  row.names(AQRQMJFactorsDaily) <- NULL
  names(AQRQMJFactorsDaily)[1] <- "Date"
  AQRQMJFactorsDaily[,1] <- ymd(AQRQMJFactorsDaily[,1])
  
  unlink(temp)
  
  start <- system.file(package="FFAQR")
  save(AQRQMJFactorsDaily, file=paste0(start, "/data/AQRQMJFactorsDaily.Rdata"))
  
}