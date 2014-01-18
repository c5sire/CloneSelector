library(shiny)
setwd("~/github/radiant/inst/marketing")

ui <- basicPage(
  verbatimTextOutput("test_regression")
)

server <- function(session, input, output) {

  source("global.R", local = TRUE)
  source('radiant.R', local = TRUE)
  R.utils::sourceDirectory('tools/analysis', recursive = TRUE)
  R.utils::sourceDirectory('tools/data', recursive = TRUE)
  R.utils::sourceDirectory('tools/app', recursive = TRUE)

  output$test_regression <- renderText({
    result <- regression("diamonds", "price", c("carat", "clarity"), NULL, NULL, "none", FALSE, FALSE, FALSE, "")
    sink("../tests/regression.txt")
      summary_regression(result)
    sink()
    stopApp()
  })
}

# works!
runApp(list(ui = ui, server = server))
res1 <- paste0(readLines("../tests/regression.txt"), collapse = "\n")
res2 <- paste0(readLines("../tests/regression_correct.txt"), collapse = "\n")
all.equal(res1,res2)

# calling reactives directly doesn't work
ui <- basicPage(
  uiOutput('ui_regression'),
  verbatimTextOutput("test_regression")
)

server <- function(session, input, output) {

  source("global.R", local = TRUE)
  state_list$datasets <<- "diamonds"
  state_list$reg_var1 <<- "price"
  state_list$reg_var2 <<- c("carat","clarity")
  state_list$reg_standardize <<- FALSE

  source('radiant.R', local = TRUE)
  R.utils::sourceDirectory('tools/analysis', recursive = TRUE)
  R.utils::sourceDirectory('tools/data', recursive = TRUE)
  R.utils::sourceDirectory('tools/app', recursive = TRUE)

  output$test_regression <- renderText({
    print(input$reg_var1)
    print(input$reg_var2)
    print(input$reg_standardize)

    result <- .regression()
    print(result)
    sink("../tests/regression_reactive.txt")
      summary_regression(result)
    sink()
    stopApp()
  })
}

# not working input values are NULL and return == ""
runApp(list(ui = ui, server = server))
res1 <- paste0(readLines("../tests/regression_reactive.txt"), collapse = "\n")
res2 <- paste0(readLines("../tests/regression_correct.txt"), collapse = "\n")
all.equal(res1,res2)

# calling reactives directly doesn't work
source("global.R", local = TRUE)

# copy-and-paste from inst/marketing/ui.R
ui <- navbarPage("Radiant", id = "nav_radiant", inverse = TRUE, collapsable = TRUE,

  uiOutput('ui_regression'),

  tabPanel("Data", uiOutput('data_ui_and_tabs')),

  navbarMenu("Random",
    tabPanel("Sampling and assignment", uiOutput("random")),
    tabPanel("Sample size", uiOutput("sampleSize"))
  ),

  navbarMenu("Base",
    tabPanel("Single mean", uiOutput("singleMean")),
    tabPanel("Compare means", uiOutput("compareMeans")),
    tabPanel("Cross-tabs", uiOutput("crosstab"))
  ),

  navbarMenu("Regression",
    tabPanel("Correlation", uiOutput("correlation")),
    tabPanel("Linear (OLS)", uiOutput("regression"))
  ),

  navbarMenu("Maps",
    tabPanel("(Dis)similarity", uiOutput("mds")),
    tabPanel("Attributes", uiOutput("pmap"))
  ),

  navbarMenu("Factor",
    tabPanel("Pre-factor analysis", uiOutput("preFactor")),
    tabPanel("Factor analysis", uiOutput("fullFactor"))
  ),

  navbarMenu("Cluster",
    tabPanel("Hierarchical", uiOutput("hierCluster")),
    tabPanel("K-means", uiOutput("kmeansCluster"))
  ),

  navbarMenu("Conjoint",
    tabPanel("Create profiles", uiOutput("conjointProfiles")),
    tabPanel("Conjoint analysis", uiOutput("conjoint"))
  ),

  navbarMenu("R",
    tabPanel("Report", uiOutput("report")),
    tabPanel("Code", uiOutput("rcode"))
  ),

  tabPanel("State", uiOutput("state")),

  tabPanel("About", includeRmd("tools/app/about.Rmd"))


)

server <- function(session, input, output) {

  # source("global.R", local = TRUE)
  state_list$datasets <<- "diamonds"
  state_list$reg_var1 <<- "price"
  state_list$reg_var2 <<- c("carat","clarity")
  state_list$reg_standardize <<- FALSE

  source('radiant.R', local = TRUE)
  R.utils::sourceDirectory('tools/analysis', recursive = TRUE)
  R.utils::sourceDirectory('tools/data', recursive = TRUE)
  R.utils::sourceDirectory('tools/app', recursive = TRUE)

  output$test_regression <- renderText({
    print(input$reg_var1)
    print(input$reg_var2)
    print(input$reg_standardize)

    result <- .regression()
    print(result)
    sink("../tests/regression_reactive.txt")
      summary_regression(result)
    sink()
    stopApp()
  })
}

# not working input values are NULL and return == ""
runApp(list(ui = ui, server = server))
res1 <- paste0(readLines("../tests/regression_reactive.txt"), collapse = "\n")
res2 <- paste0(readLines("../tests/regression_correct.txt"), collapse = "\n")
all.equal(res1,res2)

res1


