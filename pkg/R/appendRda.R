#' @title Append objects into an existing .rda file
#' @rdname appendRda
#' @name appendRda

#' @param ... Objects to append. (may be used in addition to the "list" argument)
#' @param list A vector of the names of objects to append 
#' @param envir The environment to look for the objects in.  Defaults to environment()
#' @param file The .rda file to append the objects to
#' @author Sam Vennell <Sam.Vennell@mbie.govt.nz> and Eric Wu <eric.wu@mbie.govt.nz>

#' @examples
#' TempFile <- tempfile(fileext = ".rda") 
#' temp1 <- 10; temp2 <- c(20, 30);
#' save(temp1, temp2, file = TempFile)
#' checkRda(TempFile)
#' 
#' ## append object
#' temp3 <- data.frame(x = c("row1", "row2"), y = c(40, 50))
#' appendRda(temp3, file = TempFile)
#' checkRda(TempFile)
#' 
#' ## append objects by names
#' temp4 <- temp5 <- temp3
#' appendRda(list = c("temp4", "temp5"), file = TempFile)
#' checkRda(TempFile)
#' unlink(TempFile); rm(temp1, temp2, temp3, temp4, temp5, TempFile)
#' @export appendRda

##
## appendRda --------------------------------------------------------------
##

appendRda <- function(..., list = character(), envir = environment(), file) {
   ## append the objects into an existing .rda file
   LIST <- unique(c(as.character(sapply(match.call(expand.dots = FALSE)$..., as.character)), list))
   CURRENV <- envir
   if(file.exists(file)) {
      old.objects <- load(file,envir = (TEMPENV <- new.env()))
      save(list = setdiff(old.objects, LIST), envir = TEMPENV, file = file)
      load(file, envir = CURRENV)
      save(list = unique(c(setdiff(old.objects, LIST), LIST)), envir = CURRENV, file = file)
      rm(list = old.objects, envir = TEMPENV)
      rm(list = setdiff(old.objects, LIST), envir = CURRENV)
   } else {
      save(list = LIST, envir = CURRENV, file = file)
   }
}
