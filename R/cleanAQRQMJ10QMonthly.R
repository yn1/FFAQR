#' Reads in, cleans, and subdivides daily QMJ10QMonthly data set in data folder.

cleanAQRQMJ10QMonthly <- function() {

  temp <- tempfile()
  QMJ10QMonthly <- "https://www.aqr.com/~/media/files/data-sets/quality-minus-junk-10-qualitysorted-portfolios-monthly.xlsx"
  download.file(QMJ10QMonthly, temp, method = "curl")
  
  # Imports 10 quality sorted US portfolios
  AQRQMJ10QualityLongUS <- read.xlsx(temp, "10 Portfolios Formed on Quality",
                                 ,startRow=19, colIndex=c(1:12))
  row.names(AQRQMJ10QualityLongUS) <- NULL
  names(AQRQMJ10QualityLongUS)[1] <- "Date"
  
  x1 <- findBreak(AQRQMJ10QualityLongUS, 1000, "NA") - 1
  AQRQMJ10QualityLongUS[,1] <- ymd(AQRQMJ10QualityLongUS[,1])
  AQRQMJ10QualityLongUS <- AQRQMJ10QualityLongUS[(1:x1),]

  # Imports 10 quality sorted global portfolios
  AQRQMJ10QualityBroadGlobal <- read.xlsx(temp, "10 Portfolios Formed on Quality",
                                 ,startRow=19, colIndex=c(1,13:23))
  row.names(AQRQMJ10QualityBroadGlobal) <- NULL
  names(AQRQMJ10QualityBroadGlobal)[1] <- "Date"
  
  x1 <- findBreak(AQRQMJ10QualityBroadGlobal, 1000, "NA") - 1
  AQRQMJ10QualityBroadGlobal[,1] <- ymd(AQRQMJ10QualityBroadGlobal[,1])
  AQRQMJ10QualityBroadGlobal <- AQRQMJ10QualityBroadGlobal[(1:x1),]
  
  unlink(temp)

  start <- system.file(package="FFAQR")
  save(AQRQMJ10QualityLongUS, file=paste0(start, "/data/AQRQMJ10QualityLongUS.Rdata"))
  save(AQRQMJ10QualityBroadGlobal, file=paste0(start, "/data/AQRQMJ10QualityBroadGlobal.Rdata"))

}
