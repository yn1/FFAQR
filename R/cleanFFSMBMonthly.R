#' Reads in, cleans, and subdivides monthly FFSMB data set in data folder.

cleanFFSMBMonthly <- function() {
  
  FFSMBMonthly <- "http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/Portfolios_Formed_on_ME.zip"

  td <- tempdir()
  tf <- tempfile(tmpdir=td, fileext=".zip")
  
  download.file(FFSMBMonthly, tf)
  
  # Unzips into temp directory
  fname <- unzip(tf, list=TRUE)$Name[1]
  unzip(tf, files=fname, exdir=td, overwrite=TRUE)
  fpath = file.path(td, fname)
  
  colNames = c("Date", "<=0", "Lo30", "Med40", "Hi30", "Lo20", "Qnt2", "Qnt3", "Qnt4",
               "Hi20", "Lo10", "Dec2", "Dec3", "Dec4", "Dec5", "Dec6",
               "Dec7", "Dec8", "Dec9", "Hi10")
  FFSMBMonthly <- read.table(fpath, fill=TRUE, 
                             skip=13, col.names = colNames, stringsAsFactors=FALSE)
  FFSMBMonthly <- FFSMBMonthly[,c(1,3:length(FFSMBMonthly))]

  unlink(td)
  unlink(tf)

  # Sets breakpoints
  x1 <- findBreak(FFSMBMonthly, 1050, "Equal") - 1
  x2 <- findBreak(FFSMBMonthly, 2100, "Value") - 1
  x3 <- findBreak(FFSMBMonthly, 2200, "Equal") - 1
  x4 <- findBreak(FFSMBMonthly, 2300, "Number") - 1
  x5 <- findBreak(FFSMBMonthly, 3350, "Average") - 1
  
  # Divides sheets
  FFSMBValWgtMthly <- FFSMBMonthly[1:x1,]
  FFSMBEqWgtMthly <- FFSMBMonthly[(x1+4):x2,]
  FFSMBValWgtAnn <- FFSMBMonthly[(x2+4):x3,]
  FFSMBEqWgtAnn <- FFSMBMonthly[(x3+4):x4,]
  FFSMBNumOfFirms <- FFSMBMonthly[(x4+4):x5,]
  FFSMBAvgFirmSize <- FFSMBMonthly[(x5+4):(length(FFSMBMonthly[,1])-1),]

  # Cleans data
  cleanSubFF(FFSMBValWgtMthly)
  cleanSubFF(FFSMBEqWgtMthly)
  cleanSubFF(FFSMBValWgtAnn)
  cleanSubFF(FFSMBEqWgtAnn)
  cleanSubFF(FFSMBNumOfFirms, spr=FALSE)
  cleanSubFF(FFSMBAvgFirmSize, spr=FALSE)

}
