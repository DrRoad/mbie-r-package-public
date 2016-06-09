\name{MakePlotnote}
\alias{MakePlotnote}

\title{
Add a footnote to a ggplot 
}
\description{
Function to add a footnote to a ggplot.
}
\usage{
MakePlotnote(footnoteText =  format(Sys.time(), "\%d \%b \%Y"),
            size = .7, 
            color = grey(.5))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{footnoteText}{The Plotnote text.  Defaults to the system time.}
  \item{plot}{The plot to add the note to.  Defaults to NULL, which indicates that the note be added to the current plot}
  \item{...}{extra arguments to pass to grid.text()}

}
\details{ 
}
\value{
Output is not a numerical value.  The function produces a footnote for a ggplot. 
}
\references{
%% ~put references to the literature/web site here ~
\link{http://statmodeling.com/best-way-to-add-a-footnote-to-a-plot-created-with-ggplot2.html}
}
\author{
Sam Vennell <Sam.Vennell@mbie.govt.nz> ;Eric Wu <eric.wu@mbie.govt.nz>
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{Memory}}
}
\examples{
require(ggplot2)
toyota <- mpg[which(mpg$manufacturer == 'toyota'), ]
p <- ggplot(toyota, aes(displ, hwy)) + facet_wrap(~ class, ncol = 2) + geom_point(aes(size=cyl))

# call MakePlotnote function to add footnote
   print(p)
   
   #Create a footnote on the bottom left of the plot
   MakePlotnote("Hello, I am a footnote",                
                x = unit(2, "mm"),
                y = unit(2, "mm"), 
                just = c("left", "bottom"),
                gp = gpar(cex = .7, col = grey(.5)))
   
   
   #Create a blue footnote on the bottom right of the plot with font "HersheySerif"
   MakePlotnote("New font and colour Footnote!", plot = p, 
                x = unit(1,"npc") - unit(2, "mm"),
                y = unit(2, "mm"),
                just = c("right", "bottom"),
                gp = gpar(cex = .7, col = "blue", fontfamily = "HersheySerif"))
   
   #Create a footnote on the top right
   MakePlotnote("Footnote on the top right", plot = p, 
                x = unit(1,"npc") - unit(2, "mm"),
                y = unit(1,"npc") - unit(2, "mm"),
                just = c("right", "top"),
                gp = gpar(cex = .7))

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{}
