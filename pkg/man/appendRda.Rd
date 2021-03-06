% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/appendRda.R
\name{appendRda}
\alias{appendRda}
\title{Append objects into an existing .rda file}
\usage{
appendRda(..., list = character(), envir = environment(), file)
}
\arguments{
\item{...}{Objects to append. (may be used in addition to the "list" argument)}

\item{list}{A vector of the names of objects to append}

\item{envir}{The environment to look for the objects in.  Defaults to environment()}

\item{file}{The .rda file to append the objects to}
}
\examples{
TempFile <- tempfile(fileext = ".rda") 
temp1 <- 10; temp2 <- c(20, 30);
save(temp1, temp2, file = TempFile)
checkRda(TempFile)

## append object
temp3 <- data.frame(x = c("row1", "row2"), y = c(40, 50))
appendRda(temp3, file = TempFile)
checkRda(TempFile)

## append objects by names
temp4 <- temp5 <- temp3
appendRda(list = c("temp4", "temp5"), file = TempFile)
checkRda(TempFile)
unlink(TempFile); rm(temp1, temp2, temp3, temp4, temp5, TempFile)
}
\author{
Sam Vennell <Sam.Vennell@mbie.govt.nz> and Eric Wu <eric.wu@mbie.govt.nz>
}

