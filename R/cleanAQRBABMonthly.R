#' Reads in, cleans, and subdivides monthly BAB data set in data folder.

cleanAQRBABMonthly <- function() {
  
  temp <- tempfile()
  BABMonthly <- "https://www.aqr.com/~/media/files/data-sets/betting-against-beta-equity-factors-monthly.xlsx"
  download.file(BABMonthly, temp, method = "curl")
  
  # Imports equity QMJ data
  AQRBABFactorsMonthly <- read.xlsx(temp, "BAB Factors", startRow=19, colIndex=c(1:25))
  row.names(AQRBABFactorsMonthly) <- NULL
  names(AQRBABFactorsMonthly)[1] <- "Date"
  
  x1 <- findBreak(AQRBABFactorsMonthly, 1000, "NA") - 1
  AQRBABFactorsMonthly[,1] <- ymd(AQRBABFactorsMonthly[,1])
  AQRBABFactorsMonthly <- AQRBABFactorsMonthly[(1:x1),]
  
  # Imports aggregate equity portfolios
  AQRBABPortfoliosMonthly <- read.xlsx(temp, "BAB Factors", startRow=19, colIndex=c(1,26:30))
  row.names(AQRBABPortfoliosMonthly) <- NULL
  names(AQRBABPortfoliosMonthly)[1] <- "Date"
  
  x1 <- findBreak(AQRBABPortfoliosMonthly, 1000, "NA") - 1
  AQRBABPortfoliosMonthly[,1] <- ymd(AQRBABPortfoliosMonthly[,1])
  AQRBABPortfoliosMonthly <- AQRBABPortfoliosMonthly[(1:x1),]
  
  unlink(temp)
  
  start <- system.file(package="FFAQR")
  save(AQRBABFactorsMonthly, file=paste0(start, "/data/AQRBABFactorsMonthly.Rdata"))
  save(AQRBABPortfoliosMonthly, file=paste0(start, "/data/AQRBABPortfoliosMonthly.Rdata"))
  
}