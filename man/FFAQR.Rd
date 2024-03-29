% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/FFAQR.R
\docType{package}
\name{FFAQR}
\alias{FFAQR}
\alias{FFAQR-package}
\title{FFAQR: A package for merging and cleaning the enclosed FF and AQR datasets. \cr}
\description{
FFAQR: A package for merging and cleaning the enclosed FF and AQR datasets. \cr
}
\section{Package 101}{


Call updateData() to update all data if up-to-date data is required. Data sets preloaded with package are recent as of 2/6/15. Call updateData("AQR") or updateData("FF") to update only respective data sets. \cr
\cr
Call fetchDf(name) to return updated data (assign to variable with assignment operator). \cr
}

\section{Fetch Options}{


The following is a list of possible arguments for fetchDf(name). \cr
To be safe, input arguments as strings. \cr
See below for glossary of acronyms. \cr
All daily AQR data omitted from suggestions, Java heap runs out of memory when reading file. \cr
\cr
Note that, for the sake of not downloading the same data more than once, overlapping AQR data is taken from QMJMonthly. \cr
AQRRF - Risk free rate. \cr
AQRHMLMonthly - Monthly returns for HML factor. \cr
AQRMKTMonthly - Monthly market returns. \cr
AQRSMBMonthly - Monthly returns of SMB factor. \cr
AQRTSMMonthly - Monthly time series momentum returns. \cr
AQRUMDMonthly - Monthly returns of UMD factor. \cr
\cr
AQRBABFactorsMonthly - Monthly returns for BAB factor. \cr
AQRBABPortfoliosMonthly - Monthly returns for various BAB portfolios. \cr
\cr
AQRQMJ10QualityBroadGlobal - Monthly returns of 10 global portfolios constructed on quality. \cr
AQRQMJ10QualityLongUS - Monthly returns of 10 long US portfolios constructed on quality. \cr
AQRQMJFactorsMonthly - Monthly returns of QMJ factor. \cr
\cr
For the FF data, the name must end with "3", "5", or "10", corresponding to terciles, quintiles, and deciles. That is, if the name is "Equities", you can input "Equities5". \cr
\cr
FFCMAAvgFirmSize - Average firm size used for CMA data. \cr
FFCMAEqWgtAnn - Equal-weighted annual returns to CMA. \cr
FFCMAEqWgtMthly - Equal-weighted monthly returns to CMA. \cr
FFCMANumOfFirms - Number of firms used for CMA data. \cr
FFCMAValWgtAnn - Value-weighted annual returns to CMA. \cr
FFCMAValWgtAvgInvAnn - Value-weighted average investment for CMA data. \cr
FFCMAValWgtMthly - Geometric value-weighted average investment. \cr
\cr
FFHMLAvgFirmSize - Average firm size used for HML data. \cr
FFHMLEqWgtAnn - Equal-weighted annual returns to HML. \cr
FFHMLEqWgtDly - Equal-weighted daily returns to HML. \cr
FFHMLEqWgtMthly - Equal-weighted monthly returns to HML. \cr
FFHMLNumOfFirms - Number of firms used in HML data. \cr
FFHMLValWgtAnn - Value-weighted annual returns to HML. \cr
FFHMLValWgtDly - Value-weighted daily returns to HML. \cr
FFHMLValWgtMthly - Value-weighted monthly returns to HML. \cr
\cr
FFRMWAvgFirmSize - Average firm size used for RMW data. \cr
FFRMWEqWgtAnn - Equal-weighted annual returns to RMW. \cr
FFRMWEqWgtMthly - Equal-weighted monthly returns to RMW. \cr
FFRMWNumOfFirms - Number of firms used for RMW data. \cr
FFRMWValWgtAnn - Value-weighted annual returns to RMW. \cr
FFRMWValWgtAvgOP - Value-weighted average operating profitability. \cr
FFRMWValWgtMthly - Value-weighted monthly returns to RMW. \cr
\cr
FFSMBAvgFirmSize - Average firm size used for SMB data. \cr
FFSMBEqWgtAnn - Equal-weighted annual returns to SMB. \cr
FFSMBEqWgtDly - Equal-weighted daily returns to SMB. \cr
FFSMBEqWgtMthly - Equal-weighted monthly returns to SMB. \cr
FFSMBNumOfFirms - Number of firms used in SMB data. \cr
FFSMBValWgtAnn - Value-weighted annual returns to SMB. \cr
FFSMBValWgtDly - Value-weighted daily returns to SMB. \cr
FFSMBValWgtMthly - Value-weighted monthly returns to SMB. \cr
\cr
}

\section{Glossary}{


FF - Fama French \cr
AQR - AQR \cr
BAB - Betting Against Beta \cr
HML - High (Book to Market) Minus Low \cr
QMJ - Quality Minus Junk \cr
SMB - Small Minus Big \cr
TSM - Time Series Momentum \cr
UMD - Up Minus Down \cr
CMA - Investment \cr
RMW - Operating Profitability \cr
\cr
For further information, please visit the original database websites: \cr
Fama-French:http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html \cr
AQR: https://www.aqr.com/library/data-sets?page=1 \cr
}

\section{FF Update Functions}{


You can call one of the update functions to only update related sheets. \cr

cleanFFCMA() \cr
cleanFFHMLDaily() \cr
cleanFFHMLMonthly() \cr
cleanFFRMW() \cr
cleanFFSMBDaily() \cr
cleanFFSMBMonthly() \cr
}

\section{FF Utility Functions}{


cleanSubFF(data, spr=TRUE) \cr
numValues(data) \cr
fundBreak(sheet, start=1, breakpt) \cr
}

\section{QMJ Update Functions}{


cleanAQRBABMonthly() \cr
cleanAQRQMJ10QMonthly() \cr
cleanAQRQMJMonthly() \cr
cleanAQRTSMMonthly() \cr
}

\section{Package Use}{


The primary functionality of the package comes in retrieving and cleaning updated data sets. The fetch() function will retrieve individual data tables as of 2/6/15. Alternatively, the updateData() function will clean the data sets already included with the package and will subsequently present the results in the global environment. \cr
\cr
Please note that this package will manipulate the data directory within the project directory. \cr
}

\section{Troubleshooting}{


Unable to set working directory? - Some functions make use of moving into subdirectories before moving back out into the working directory, please make sure that the project folder is set as the folder directory before attempting to clean or download data. \cr
\cr
Unable to import AQR data? - If you cannot run read.xlsx() on the AQR data, you need to allocate more memory to your Java heap (see Java's Xmx setting). \cr
}

