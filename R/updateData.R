#' Updates all data.
#' 
#' @param which Specifies which data sets to load. Defaults to all, "AQR" and "FF" load only respective data sets.

updateData <- function(which="ALL") {
  
  if (which != "AQR") {
 
    print("Loading CMA")
    cleanFFCMA()
  
    print("Loading HML Daily")
    cleanFFHMLDaily()
  
    print("Loading HML Monthly")
    cleanFFHMLMonthly()
  
    print("Loading RMW")
    cleanFFRMW()
  
    print("Loading SMB Daily")
    cleanFFSMBDaily()
  
    print("Loading SMB Monthly")
    cleanFFSMBMonthly()
  
  }
  
  if (which != "FF") {
    
    print("Loading BAB Monthly")
    cleanAQRBABMonthly()
    
    print("Loading QMJ 10 Portfolios")
    cleanAQRQMJ10QMonthly()
  
    print("Loading QMJ Monthly and other AQR data")
    cleanAQRQMJMonthly()
    
    print("Loading Time Series Momentum")
    cleanAQRTSMMonthly()
    
#     #Disable due to Java heap running out of memory    
#     print("Loading BAB Daily")
#     cleanAQRBABDaily()
#     
#     print("Loading QMJ Daily")
#     cleanQMJDaily()

  }
    
}
