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

