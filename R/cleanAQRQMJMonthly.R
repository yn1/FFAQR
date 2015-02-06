#' Reads in, cleans, and subdivides monthly QMJ data set in data folder.
#' Note that all overlapping AQR data is taken from this dataset.

cleanAQRQMJMonthly <- function() {

  temp <- tempfile()
  QMJMonthly <- "https://www.aqr.com/~/media/files/data-sets/quality-minus-junk-factors-monthly.xlsx"
  download.file(QMJMonthly, temp, method = "curl")
  
  # Imports QMJ data
  AQRQMJFactorsMonthly <- read.xlsx(temp, "QMJ Factors", startRow=19, colIndex=c(1:30))
  row.names(AQRQMJFactorsMonthly) <- NULL
  names(AQRQMJFactorsMonthly)[1] <- "Date"
  
  x1 <- findBreak(AQRQMJFactorsMonthly, 1000, "NA") - 1
  AQRQMJFactorsMonthly[,1] <- ymd(AQRQMJFactorsMonthly[,1])
  AQRQMJFactorsMonthly <- AQRQMJFactorsMonthly[(1:x1),]

  # Imports market return data
  AQRMKTMonthly <- read.xlsx(temp, "MKT", startRow=19, colIndex=c(1:30))
  row.names(AQRMKTMonthly) <- NULL
  names(AQRMKTMonthly)[1] <- "Date"
  
  x1 <- findBreak(AQRMKTMonthly, 1000, "NA") - 1
  AQRMKTMonthly[,1] <- ymd(AQRMKTMonthly[,1])
  AQRMKTMonthly <- AQRMKTMonthly[(1:x1),]

  # Imports monthly SMB data
  AQRSMBMonthly <- read.xlsx(temp, "SMB", startRow=19, colIndex=c(1:30))
  row.names(AQRSMBMonthly) <- NULL
  names(AQRSMBMonthly)[1] <- "Date"
  
  x1 <- findBreak(AQRSMBMonthly, 1000, "NA") - 1
  AQRSMBMonthly[,1] <- ymd(AQRSMBMonthly[,1])
  AQRSMBMonthly <- AQRSMBMonthly[(1:x1),]

  # Imports monthly HML data
  AQRHMLMonthly <- read.xlsx(temp, "HML FF", startRow=19, colIndex=c(1:30))
  row.names(AQRHMLMonthly) <- NULL
  names(AQRHMLMonthly)[1] <- "Date"
  
  x1 <- findBreak(AQRHMLMonthly, 1000, "NA") - 1
  AQRHMLMonthly[,1] <- ymd(AQRHMLMonthly[,1])
  AQRHMLMonthly <- AQRHMLMonthly[(1:x1),]

  # Imports monthly UMD data
  AQRUMDMonthly <- read.xlsx(temp, "UMD", startRow=19, colIndex=c(1:30))
  row.names(AQRUMDMonthly) <- NULL
  names(AQRUMDMonthly)[1] <- "Date"
  
  x1 <- findBreak(AQRUMDMonthly, 1000, "NA") - 1
  AQRUMDMonthly[,1] <- ymd(AQRUMDMonthly[,1])
  AQRUMDMonthly <- AQRUMDMonthly[(1:x1),]

  # Imports monthly risk free rate data
  AQRRF <- read.xlsx(temp, "RF", startRow=19, colIndex=c(1:2))
  row.names(AQRRF) <- NULL
  names(AQRRF)[1] <- "Date"
  
  x1 <- findBreak(AQRRF, 1000, "NA") - 1
  AQRRF[,1] <- ymd(AQRRF[,1])
  AQRRF <- AQRRF[(1:x1),]

  unlink(temp)

  start <- system.file(package="FFAQR")
  save(AQRQMJFactorsMonthly, file=paste0(start, "/data/AQRQMJFactorsMonthly.Rdata"))
  save(AQRMKTMonthly, file=paste0(start, "/data/AQRMKTMonthly.Rdata"))
  save(AQRSMBMonthly, file=paste0(start, "/data/AQRSMBMonthly.Rdata"))
  save(AQRHMLMonthly, file=paste0(start, "/data/AQRHMLMonthly.Rdata"))
  save(AQRUMDMonthly, file=paste0(start, "/data/AQRUMDMonthly.Rdata"))
  save(AQRRF, file=paste0(start, "/data/AQRRF.Rdata"))

}
