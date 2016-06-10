## Define dummy functions for the stat_xxx functions which are now part of ggseas rather than mbiemaps


stat_sa <- function(...){
   stop("stat_sa no longer exists.  Use stat_seas, stat_stl or stat_decomp from the {ggseas} package.")
}

stat_index1 <- function(...){
   stop("stat_index1 and stat_index12 no longer exist.  Use stat_index from the {ggseas} package.")
}

stat_index12 <- function(...){
   stop("stat_index1 and stat_index12 no longer exist.  Use stat_index from the {ggseas} package.")
}

## Define a dummy function to override "base::install.packages()"

install.packages <- function(...){
   stop("To request new packages please contact Sam Vennell (Sam.Vennell@mbie.govt.nz), Eric Wu (Eric.Wu@mbie.govt.nz) or Peter Ellis (Peter.Ellis@mbie.govt.nz).")
}
