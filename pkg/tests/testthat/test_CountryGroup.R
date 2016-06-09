context("CountryGroup()")

require(mbiedata)
data(IVStrips)
test_that("Test if the countryGroup works for IVS trips dataset:", {
   expect_equal(table(CountryGroup(IVStrips$COPRDetail)), 
                structure(c(2925L, 20172L, 2997L, 4287L, 2840L, 7607L, 3065L, 
                            1110L, 10741L, 7285L, 3617L, 11762L, 9384L), .Dim = 13L, .Dimnames = structure(list(
                               c("Africa and Middle East", "Australia", "Canada", "China", 
                                 "Germany", "Japan", "Korea, Republic of", "Rest of Americas", 
                                 "Rest of Asia", "Rest of Europe", "Rest of Oceania", "UK", 
                                 "USA")), .Names = ""), class = "table")
   )
})