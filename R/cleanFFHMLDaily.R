#' Reads in, cleans, and subdivides daily FFHML data set in data folder.

cleanFFHMLDaily <- function() {
  
  FFHMLDaily <- "http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/Portfolios_Formed_on_BE-ME_Daily.zip"
  
  td <- tempdir()
  tf <- tempfile(tmpdir=td, fileext=".zip")
  
  download.file(FFHMLDaily, tf)
  
  # Unzips into temp directory
  fname <- unzip(tf, list=TRUE)$Name[1]
  unzip(tf, files=fname, exdir=td, overwrite=TRUE)
  fpath = file.path(td, fname)
  
  colNames = c("Date", "<=0", "Lo30", "Med40", "Hi30", "Lo20", "Qnt2", "Qnt3", "Qnt4",
               "Hi20", "Lo10", "Dec2", "Dec3", "Dec4", "Dec5", "Dec6",
               "Dec7", "Dec8", "Dec9", "Hi10")
  FFHMLDaily <- read.table(fpath, fill=TRUE, 
                           skip=24, col.names = colNames, stringsAsFactors=FALSE)
  FFHMLDaily <- FFHMLDaily[,c(1,3:length(FFHMLDaily))]
  
  unlink(td)
  unlink(tf)

  # Sets breakpoint
  x1 <- findBreak(FFHMLDaily, 23300, "Equal") - 1
  
  # Divides sheets
  FFHMLValWgtDly <- FFHMLDaily[1:x1,]
  FFHMLEqWgtDly <- FFHMLDaily[(x1+4):(length(FFHMLDaily[,1])),]

  # Cleans data
  cleanSubFF(FFHMLValWgtDly)
  cleanSubFF(FFHMLEqWgtDly)

}
