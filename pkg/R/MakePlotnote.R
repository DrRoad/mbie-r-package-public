#' @export MakePlotnote

MakePlotnote <- 
   function(footnoteText =  format(Sys.time(), "%d %b %Y"),
            plot = NULL,
            ...){
      require(grid)
#     require(extrafont)
      if(!is.null(plot)) {print(plot)}
      pushViewport(viewport())
      grid.text(label = footnoteText ,
                ...)
      popViewport()
   }
