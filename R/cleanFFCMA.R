#' Reads in, cleans, and subdivides FFCMA data set located in data folder.

cleanFFCMA <- function() {
  
  FFCMA <- "http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/Portfolios_Formed_on_INV.zip"

  td <- tempdir()
  tf <- tempfile(tmpdir=td, fileext=".zip")
  
  download.file(FFCMA, tf)
  
  # Unzips into temp directory
  fname <- unzip(tf, list=TRUE)$Name[1]
  unzip(tf, files=fname, exdir=td, overwrite=TRUE)
  fpath = file.path(td, fname)
  
  colNames = c("Date", "Lo30", "Med40", "Hi30", "Lo20", "Qnt2", "Qnt3", "Qnt4",
               "Hi20", "Lo10", "Dec2", "Dec3", "Dec4", "Dec5", "Dec6",
               "Dec7", "Dec8", "Dec9", "Hi10")
  FFCMA <- read.table(fpath, fill=TRUE, 
                      skip=18, col.names = colNames, stringsAsFactors=FALSE)
  
  unlink(td)
  unlink(tf)
  
  # Sets breakpoints
  x1 <- findBreak(FFCMA, 600, "Equal") - 1
  x2 <- findBreak(FFCMA, 1200, "Value") - 1
  x3 <- findBreak(FFCMA, 1280, "Equal") - 1
  x4 <- findBreak(FFCMA, 1330, "Number") - 1
  x5 <- findBreak(FFCMA, 1900, "Average") - 1
  x6 <- findBreak(FFCMA, 2500, "Geometric") - 1
  
  # Divides sheets
  FFCMAValWgtMthly <- FFCMA[1:x1,]
  FFCMAEqWgtMthly <- FFCMA[(x1+4):x2,]
  FFCMAValWgtAnn <- FFCMA[(x2+4):x3,]
  FFCMAEqWgtAnn <- FFCMA[(x3+4):x4,]
  FFCMANumOfFirms <- FFCMA[(x4+4):x5,]
  FFCMAAvgFirmSize <- FFCMA[(x5+4):x6,]
  FFCMAValWgtAvgInvAnn <- FFCMA[(x6+4):(length(FFCMA[,1])-1),]
  
  # Cleans data
  cleanSubFF(FFCMAValWgtMthly)
  cleanSubFF(FFCMAEqWgtMthly)
  cleanSubFF(FFCMAValWgtAnn)
  cleanSubFF(FFCMAEqWgtAnn)
  cleanSubFF(FFCMANumOfFirms, spr=FALSE)
  cleanSubFF(FFCMAAvgFirmSize, spr=FALSE)
  cleanSubFF(FFCMAValWgtAvgInvAnn)

}
