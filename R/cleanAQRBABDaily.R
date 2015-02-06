#' Reads in, cleans, and subdivides Daily BAB data set in data folder.
#' Currently disabled, Java heap runs out of memory when reading xlsx.

cleanAQRBABDaily <- function() {
  
  temp <- tempfile()
  BABDaily <- "https://www.aqr.com/~/media/files/data-sets/betting-against-beta-equity-factors-daily.xlsx"
  download.file(BABDaily, temp, method = "curl")
  
  # Imports equity QMJ data
  AQRBABFactorsDaily <- read.xlsx(temp, "BAB Factors", startRow=19, colIndex=c(1:25))
  row.names(AQRBABFactorsDaily) <- NULL
  names(AQRBABFactorsDaily)[1] <- "Date"
  AQRBABFactorsDaily[,1] <- ymd(AQRBABFactorsDaily[,1])
  
  # Imports aggregate equity portfolios
  AQRBABPortfoliosDaily <- read.xlsx(temp, "BAB Factors", startRow=19, colIndex=c(1,26:30))
  row.names(AQRBABPortfoliosDaily) <- NULL
  names(AQRBABPortfoliosDaily)[1] <- "Date"
  AQRBABPortfoliosDaily[,1] <- ymd(AQRBABPortfoliosDaily[,1])
  
  unlink(temp)
  
  start <- system.file(package="FFAQR")
  save(AQRBABFactorsDaily, file=paste0(start, "/data/AQRBABFactorsDaily.Rdata"))
  save(AQRBABPortfoliosDaily, file=paste0(start, "/data/AQRBABPortfoliosDaily.Rdata"))
  
}