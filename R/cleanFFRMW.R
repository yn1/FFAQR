#' Reads in, cleans, and subdivides FFRMW data set in data folder.

cleanFFRMW <- function() {
  
  FFRMW <- "http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/Portfolios_Formed_on_OP.zip"

  td <- tempdir()
  tf <- tempfile(tmpdir=td, fileext=".zip")
  
  download.file(FFRMW, tf)
  
  # Unzips into temp directory
  fname <- unzip(tf, list=TRUE)$Name[1]
  unzip(tf, files=fname, exdir=td, overwrite=TRUE)
  fpath = file.path(td, fname)
  
  colNames = c("Date", "Lo30", "Med40", "Hi30", "Lo20", "Qnt2", "Qnt3", "Qnt4",
               "Hi20", "Lo10", "Dec2", "Dec3", "Dec4", "Dec5", "Dec6",
               "Dec7", "Dec8", "Dec9", "Hi10")
  FFRMW <- read.table(fpath, fill=TRUE, skip=19, 
                      col.names = colNames, stringsAsFactors=FALSE)

  unlink(td)
  unlink(tf)
  
  # Sets breakpoints
  x1 <- findBreak(FFRMW, 600, "Equal") - 1
  x2 <- findBreak(FFRMW, 1200, "Value") - 1
  x3 <- findBreak(FFRMW, 1280, "Equal") - 1
  x4 <- findBreak(FFRMW, 1330, "Number") - 1
  x5 <- findBreak(FFRMW, 1900, "Average") - 1
  x6 <- findBreak(FFRMW, 2500, "Value-Weighted") - 1
  
  # Divides sheets
  FFRMWValWgtMthly <- FFRMW[1:x1,]
  FFRMWEqWgtMthly <- FFRMW[(x1+4):x2,]
  FFRMWValWgtAnn <- FFRMW[(x2+4):x3,]
  FFRMWEqWgtAnn <- FFRMW[(x3+4):x4,]
  FFRMWNumOfFirms <- FFRMW[(x4+4):x5,]
  FFRMWAvgFirmSize <- FFRMW[(x5+4):x6,]
  FFRMWValWgtAvgOP <- FFRMW[(x6+4):(length(FFRMW[,1])-1),]

  # Cleans data
  cleanSubFF(FFRMWValWgtMthly)
  cleanSubFF(FFRMWEqWgtMthly)
  cleanSubFF(FFRMWValWgtAnn)
  cleanSubFF(FFRMWEqWgtAnn)
  cleanSubFF(FFRMWNumOfFirms, spr=FALSE)
  cleanSubFF(FFRMWAvgFirmSize, spr=FALSE)
  cleanSubFF(FFRMWValWgtAvgOP)

}
