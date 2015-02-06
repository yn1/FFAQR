#' Cleans separate Fama-French data frames and adds them to global environment after
#' splitting the set into thirds, quintiles and deciles.
#'
#' @param data A data set.
#' @param spr Calculates spreads for relevant data by default.

cleanSubFF <- function(data, spr=TRUE) {

  # Cleans divisions
  prefix <- deparse(substitute(data))
  row.names(data) <- NULL
  data <- numValues(data)

  # Fixes dates (to end of period)
  if (grepl("Dly", prefix) == TRUE) {
    data[,1] <- ymd(data[,1])
  } else if (grepl("Ann", prefix) == TRUE) {
    for (i in 1:nrow(data)) {
      data[i,1] <- paste0(data[i,1], "-12-31")
    }
    data[,1] <- ymd(data[,1])
  } else {
    for (i in 1:nrow(data)) {
      data[i,1] <- paste0(data[i,1], "05")
    }
    data[,1] <- ymd(data[,1])
    for (i in 1:nrow(data)) {
      day(data[i,1]) <- 1
      month(data[i,1]) <- month(data[i,1]) + 1
      day(data[i,1]) <- day(data[i,1]) - 1
    }
  }

  # Names final sheets
  sheet1S <- paste0(prefix, "3")
  sheet2S <- paste0(prefix, "5")
  sheet3S <- paste0(prefix, "10")

  # Splits up by columns
  sheet1 <- data[,1:4]
  sheet2 <- data[,c(1,5:9)]
  sheet3 <- data[,c(1,10:19)]

  # Adds in spreads
  if (spr == TRUE){
    sheet1$Spread <- sheet1$Hi30 - sheet1$Lo30
    sheet2$Spread <- sheet2$Hi20 - sheet2$Lo20
    sheet3$Spread <- sheet3$Hi10 - sheet3$Lo10
  }

  start <- system.file(package="FFAQR")
  save(sheet1, file=paste0(start, "/data/", sheet1S, ".Rdata"))
  save(sheet2, file=paste0(start, "/data/", sheet2S, ".Rdata"))
  save(sheet3, file=paste0(start, "/data/", sheet3S, ".Rdata"))

}
