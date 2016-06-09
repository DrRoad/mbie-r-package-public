############################################################################
## prepare package building environment ------------------------------------


require(devtools)

# Note - set the library path so the Test folder is listed first and the installation will be to there,
# rather than to the folder used for libraries by everyone.  This should be done in the .Rprofile
# but in case not you can always run the line below:
.libPaths(c("P:/r/libraries/AAA TEST LIBRARIES", .libPaths()))


# Build the package:
if("package:mbie" %in% search()) try(detach("package:mbie", unload=TRUE))
devtools::build(pkg="pkg", path= "P:/OTSP/data-infrastructure/archive/", binary=TRUE)
devtools::build(pkg="pkg", path= "P:/OTSP/data-infrastructure/archive/", binary=FALSE)

############################################################################
## Test the package --------------------------------------------------------
## install the package to test folder
install.packages("P:/OTSP/data-infrastructure/archive/mbie_0.9.5.zip",repos = NULL,lib = "P:/R/libraries/AAA TEST LIBRARIES")

## load the package from test folder
library(package = "mbie", lib.loc = "P:/R/libraries/AAA TEST LIBRARIES")
## after load the working version, go though the examples of newly added functions and check if they work properly.
devtools::test(pkg = "pkg/")
############################################################################

############################################################################
## deploy to production ----------------------------------------------------
## After review, we are ready to deploy the package to production

# ## install the package to production libraries.
# try(detach("package:mbie", unload=TRUE))
# install.packages("P:/OTSP/data-infrastructure/archive/mbie_0.9.5.zip",repos = NULL,lib = "P:/R/libraries/3.1.2-20160209")
############################################################################


# at home
# install_github("nz-mbie/mbie-r-package/pkg")
