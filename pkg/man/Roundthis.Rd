\name{Roundthis}
\alias{Roundthis}

\title{
Random rounding
}
\description{
Random rounding to base 3 or graduated random rounding (the default)
}
\usage{
Roundthis(x, type = "Graduated")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
Object to be rounded
}
  \item{type}{
Must be "Graduated" or "Base3"
}
}
\details{
Performs random rounding on an object.  Statistics New Zealand rules for analysis of business microdata require counts of the number of surveyed businesses to be randomly rounded to base 3, and secondary counts (eg number of employees) to be randomly rounded on a graduated base.

The aim of random rounding is to round to the nearest or second nearest number divisible by a defined base with no remainder. For example, rounding 22 with base 5 could go to either 20 or 25. The randomness is chosen such that on average the result is the same as the original. In our case, 60 per cent of the time we would round to 20, and 40 per cent to 25.
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Peter Ellis <peter.ellis@mbie.govt.nz>
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{

Roundthis(with(airquality, table(cut(Temp, quantile(Temp)), Month)))

Roundthis(with(airquality, table(cut(Temp, quantile(Temp)), Month)), type="Base3")


library(mbiedata)
data(IVStrips)
library(tidyr)
library(dplyr)

# Unrounded:
IVStrips \%>\%
   filter(YearQuarter == "2013 1") \%>\%
   group_by(COPRTop5, POVTop3) \%>\%
   summarise(sampleorig = length(POVTop3)) \%>\%
   spread(POVTop3, sampleorig)

# Graduated random rounding:
IVStrips \%>\%
   filter(YearQuarter == "2013 1") \%>\%
   group_by(COPRTop5, POVTop3) \%>\%
   summarise(sampleGRR = Roundthis(length(POVTop3))) \%>\%
   spread(POVTop3, sampleGRR)
}

\keyword{ misc }

