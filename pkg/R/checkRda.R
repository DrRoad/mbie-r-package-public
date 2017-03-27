#' @title Check which objects are stored in a given .rda file
#' @rdname checkRda
#' @name checkRda

#' @param file The .rda file to check
#' @return A vector containing the names of objects in the .rda file.
#' @author Sam Vennell <Sam.Vennell@mbie.govt.nz> and Eric Wu <eric.wu@mbie.govt.nz>

#' @examples
#' TempFile <- tempfile(fileext = ".rda") 
#' temp1 <- 10; temp2 <- c(20, 30);
#' save(temp1, temp2, file = TempFile)
#' checkRda(TempFile)
#' unlink(TempFile); rm(temp1, temp2, TempFile)
#' @export checkRda

checkRda <- function(file) {
   ## check the objects stored in an .rda file
   if(file.exists(file)) {
      old.objects <- load(file,envir = (TEMPENV <- new.env()))
   } else {old.objects <- character()}
   return(old.objects)
}



