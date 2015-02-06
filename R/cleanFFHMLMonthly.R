#' Reads in, cleans, and subdivides monthly FFHML data set in data folder.

cleanFFHMLMonthly <- function() { 
  
  FFHMLMonthly <- "http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/Portfolios_Formed_on_BE-ME.zip"
  
  td <- tempdir()
  tf <- tempfile(tmpdir=td, fileext=".zip")
  
  download.file(FFHMLMonthly, tf)
  
  # Unzips into temp directory
  fname <- unzip(tf, list=TRUE)$Name[1]
  unzip(tf, files=fname, exdir=td, overwrite=TRUE)
  fpath = file.path(td, fname)
  
  colNames = c("Date", "<=0", "Lo30", "Med40", "Hi30", "Lo20", "Qnt2", "Qnt3", "Qnt4",
               "Hi20", "Lo10", "Dec2", "Dec3", "Dec4", "Dec5", "Dec6",
               "Dec7", "Dec8", "Dec9", "Hi10")
  FFHMLMonthly <- read.table(fpath, fill=TRUE, 
                             skip=24, col.names = colNames, stringsAsFactors=FALSE)
  FFHMLMonthly <- FFHMLMonthly[,c(1,3:length(FFHMLMonthly))]

  unlink(td)
  unlink(tf)

  # Sets breakpoints
  x1 <- findBreak(FFHMLMonthly, 1050, "Equal") - 1
  x2 <- findBreak(FFHMLMonthly, 2100, "Value") - 1
  x3 <- findBreak(FFHMLMonthly, 2200, "Equal") - 1
  x4 <- findBreak(FFHMLMonthly, 2300, "Number") - 1
  x5 <- findBreak(FFHMLMonthly, 3350, "Average") - 1
  x6 <- findBreak(FFHMLMonthly, 4430, "Sum") - 1

  # Divides sheets
  FFHMLValWgtMthly <- FFHMLMonthly[1:x1,]
  FFHMLEqWgtMthly <- FFHMLMonthly[(x1+4):x2,]
  FFHMLValWgtAnn <- FFHMLMonthly[(x2+4):x3,]
  FFHMLEqWgtAnn <- FFHMLMonthly[(x3+4):x4,]
  FFHMLNumOfFirms <- FFHMLMonthly[(x4+4):x5,]
  FFHMLAvgFirmSize <- FFHMLMonthly[(x5+4):x6,]

  # Cleans data
  cleanSubFF(FFHMLValWgtMthly)
  cleanSubFF(FFHMLEqWgtMthly)
  cleanSubFF(FFHMLValWgtAnn)
  cleanSubFF(FFHMLEqWgtAnn)
  cleanSubFF(FFHMLNumOfFirms, spr=FALSE)
  cleanSubFF(FFHMLAvgFirmSize, spr=FALSE)

}
