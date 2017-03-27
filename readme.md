<img src="readme_files/figure-html/Header-1.png" style="display: block; margin: auto;" />
"mbie" R package
==================

This public repository holds source code and data for the "mbie" R package used by New Zealand's Ministry of Business, Innovation and Employment, primarily but not only the Sector Performance team.  The package is public to allow access to the data under the conditions of the most transparency and to the maximum degree of granularity, as directed by the New Zealand government.  Further improvements are ongoing to make the data more accessible.

This data and code are available under a Creative Commons license - see http://ict.govt.nz/guidance-and-resources/information-and-data/nzgoal/ for details.


## Demo of Regional Tourism Estimates data


```r
if(!file.exists("raw_data/mbie-r-package-public-example-data.rda")) {
   download.file("https://github.com/nz-mbie/mbie-r-package-public/blob/master/raw_data/mbie-r-package-public-example-data.rda?raw=true", "mbie-r-package-public-example-data.rda", mode = "wb")
   load("mbie-r-package-public-example-data.rda")
   unlink("mbie-r-package-public-example-data.rda")
} else {
   load("raw_data/mbie-r-package-public-example-data.rda")
}
   
library(dplyr)
library(treemap)


# Estimate compound annual growth rate
growth <- RTEs %>%
            group_by(Territorial_Authority, Region) %>%
            summarise(Growth = CAGR(sum(Spend[YEMar == 2013]) / sum(Spend[YEMar == 2009]), 4)) %>%
            data.frame()

# Merge with the absolute size of tourism in 2013
RTE2 <- RTEs %>%
            filter(YEMar == 2013) %>%
            group_by(Territorial_Authority, Region) %>%
            summarise(Spend = sum(Spend)) %>%
            inner_join(growth, by = c("Territorial_Authority", "Region")) %>%
            data.frame()
            

# Draw treemap to show size and growth by hierarchical TA and Region
treemap(RTE2,
        index = c("Region", "Territorial_Authority"),
        vSize = "Spend",
        vColor = "Growth",
        palette = "Spectral",
        title = "Regional Tourism 2013, and CAGR 2009 to 2013",
        type = "value",
        inflate.labels = TRUE,
        algorithm = "squarified")
```

<img src="readme_files/figure-html/RTESeg-1.png" style="display: block; margin: auto;" />


## Demo of International Visitor Survey data
This includes use of the backcasting "Adjusted Factor" from the redevelopment in 2013, and also illustrates the CountryGroup() and stat_sa() (for seasonal adjustment on the fly) functions.

```r
library(dplyr)
library(scales)
library(ggplot2)
library(ggthemes)
library(ggseas)
```

```
## Loading required package: seasonal
```

```
## Loading required package: zoo
```

```
## 
## Attaching package: 'zoo'
```

```
## The following objects are masked from 'package:base':
## 
##     as.Date, as.Date.numeric
```

```r
tmp <- IVStrips %>%
            group_by(YearQuarter, CountryGroup(COPRTop5)) %>%
            summarise(Total = sum(SmoothTotalSpend * FinalWeight * Adjusted_Factor)) %>%
            data.frame()
```

```
## Warning in CountryGroup(structure(c(6L, 1L, 3L, 6L, 6L, 2L, 6L, 3L, 6L, : Countries 'Other' wasn't recognised by the country groups and treated as 'other'!
##  If this is not appropriate, please contact maintainer of the package {mbie}!
```

```r
tmp$period <- with(tmp, as.numeric(substring(YearQuarter, 1, 4)) + (as.numeric(substring(YearQuarter, 6, 6))-.5)/4)
names(tmp)[2] <- "Country"

ggplot(tmp, aes(x = period, y = Total / 10^6, color = Country)) +
  stat_seas(frequency = 4, geom = "point", size = 2) +
  stat_seas(frequency = 4, size = 2) +
  geom_line(size = 0.8, alpha = 0.4) +
  theme_economist() +
  labs(x = "", y = "Total spend ($m)\n") +
  scale_color_manual("", values=tourism.cols("Alternating")) +
  ggtitle("Seasonally adjusted NZ tourism spend by country of origin")
```

```
## Calculating starting date of 1997.125 from the data.
```

```
## Calculating starting date of 1997.125 from the data.
## Calculating starting date of 1997.125 from the data.
## Calculating starting date of 1997.125 from the data.
## Calculating starting date of 1997.125 from the data.
## Calculating starting date of 1997.125 from the data.
## Calculating starting date of 1997.125 from the data.
## Calculating starting date of 1997.125 from the data.
## Calculating starting date of 1997.125 from the data.
## Calculating starting date of 1997.125 from the data.
## Calculating starting date of 1997.125 from the data.
## Calculating starting date of 1997.125 from the data.
```

<img src="readme_files/figure-html/IVSeg-1.png" style="display: block; margin: auto;" />


## Demo of Regional Tourism Estimates in combination with maps in the accompanying mbiemaps package


```r
# load in RTO map
library(sp)
library(lattice)
library(latticeExtra)
```

```
## Loading required package: RColorBrewer
```

```
## 
## Attaching package: 'latticeExtra'
```

```
## The following object is masked from 'package:ggplot2':
## 
##     layer
```

```r
library(mbiemaps)
library(dplyr)

data(RTO)

# Aggregate domestic tourism spend and average annual growth rate
dom <- RTEs %>%
            filter(Type == "Domestic") %>%
            group_by(RTO) %>%
            summarise(
               Growth = CAGR(sum(Spend[YEMar==2013]) / sum(Spend[YEMar==2009]), 4),
               Spend2013 = sum(Spend[YEMar == 2013])
               ) %>%
            data.frame()

# merge the RTE with the data from the data slot of the RTO map
data2 <- merge(RTO@data, dom, by="RTO")

# replace the data slot of our RTO map with the new data frame
RTO@data <- data2


#----------------draw map - fancy version - title, palette, border colour, added circle layer---------------

# defining our own palette
# First, how many colours are needed that are in the negative band
lessthanzero <- round((-min(RTO@data$Growth)) / sum(abs(range(RTO@data$Growth))) * 100)

# then create a palette of colours from red to grey and out to MBIE blue
cols <- c(colorRampPalette(c("red", "grey95"))(lessthanzero), colorRampPalette(c("grey95", mbie.cols(1)))(100-lessthanzero))

# coordinates to add circles
coords <- SpatialPoints(coordinates(RTO))

# how big will the circles be?  "sizes" variable for later use
sizes <- sqrt(RTO@data$Spend2013)/8

# set parameters so no axis line ie no box around the plot
trellis.par.set("axis.line", list(col=NA,lty=1,lwd=1))

spplot(RTO, zcol="Growth", col.regions=cols, main="Domestic tourist spend", col="white", 
	sp.layout=list("sp.points", coords, pch=1, col="black", lwd=2, cex=sizes)) # add circles layer
grid.text("Circle size is proportional to\ndomestic tourism spend in 2013", .2,.7)
grid.text("Average growth per year in domestic tourism 2009 - 2013", .93,.5, rot=-90)
```

<img src="readme_files/figure-html/unnamed-chunk-1-1.png" style="display: block; margin: auto;" />
