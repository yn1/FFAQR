#' Reads in, cleans, and subdivides daily FFSMB data set in data folder.

cleanFFSMBDaily <- function() {

  FFSMBDaily <- "http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/Portfolios_Formed_on_ME_Daily.zip"

  td <- tempdir()
  tf <- tempfile(tmpdir=td, fileext=".zip")
  
  download.file(FFSMBDaily, tf)
  
  # Unzips into temp directory
  fname <- unzip(tf, list=TRUE)$Name[1]
  unzip(tf, files=fname, exdir=td, overwrite=TRUE)
  fpath = file.path(td, fname)
  
  colNames = c("Date", "<=0", "Lo30", "Med40", "Hi30", "Lo20", "Qnt2", "Qnt3", "Qnt4",
               "Hi20", "Lo10", "Dec2", "Dec3", "Dec4", "Dec5", "Dec6",
               "Dec7", "Dec8", "Dec9", "Hi10")
  FFSMBDaily <- read.table(fpath, fill=TRUE, 
                           skip=13, col.names = colNames, stringsAsFactors=FALSE)
  FFSMBDaily <- FFSMBDaily[,c(1,3:length(FFSMBDaily))]

  unlink(td)
  unlink(tf)

  # Sets breakpoint
  x1 <- findBreak(FFSMBDaily, 23300, "Equal") - 1
  
  # Cleans sheets
  FFSMBValWgtDly <- FFSMBDaily[1:x1,]
  FFSMBEqWgtDly <- FFSMBDaily[(x1+4):(length(FFSMBDaily[,1])),]

  # Cleans data
  cleanSubFF(FFSMBValWgtDly)
  cleanSubFF(FFSMBEqWgtDly)

}
