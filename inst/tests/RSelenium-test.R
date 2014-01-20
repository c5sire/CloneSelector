require(RSelenium)
setwd('~/Desktop/test')

startServer()
remDr <- remoteDriver$new()
remDr$open()
remDr$navigate("http://vnijs.rady.ucsd.edu:3838/marketing")


# close server
remDr$closeServer()

# John Harrison's example from https://groups.google.com/forum/#!msg/shiny-discuss/CSI9k5leehU/sEwroWNMRf0J
# startServer()
# remDr <- remoteDriver$new()
# remDr$open()
# remDr$navigate("http://glimmer.rstudio.com/winston/heightweight/")

# # find the X variable DOM element
# webElem <- remDr$findElement(using = "id", value = "x_var")

# # check what is selected as default
# webElem$getElementAttribute("value") # [1] "ageYear"

# # change to x = Weight option
# webElem <- remDr$findElement(value = "//option[@value = 'weightLb']")
# webElem$clickElement() # app should change to x variable = weight

# # change to x = Height
# webElem <- remDr$findElement(value = "//option[@value = 'heightIn']")
# webElem$clickElement() # app should change to x variable = weight

# # seperate male and female values
# webElem <- remDr$findElement(using = "id", value = "sex")
# webElem$clickElement() # app should change to x variable = weight

# # close server
# remDr$closeServer()

