################################################################################
# functions to set initial values and take information from state_list
# when available
################################################################################
state_singlevar <- function(inputvar, vars) names(vars[vars == state_list[[inputvar]]])
state_multvar <- function(inputvar, vars) names(vars[vars %in% state_list[[inputvar]]])

state_init <- function(inputvar, init = "") {
  ifelse(is.null(state_list[[inputvar]]), return(init), return(state_list[[inputvar]]))
}

state_init_list <- function(inputvar, init = "", values = values) {
  # return the list label/name, not the value because
  # the input list contains the value, not the labels
  ifelse(is.null(state_list[[inputvar]]), return(init), return(state_singlevar(inputvar, values)))
}

state_init_multvar <- function(inputvar, pre_inputvar, values) {
  # for factor and cluster use variable selection from the pre-analysis
  # return the list label/name, not the value because
  # the input list contains the value, not the labels
  ifelse(is.null(state_list[[inputvar]]), return(names(values[values %in% pre_inputvar])),
    return(state_multvar(inputvar, values)))
}

#######################################
# Load, Save, Reset app state
#######################################
output$state <- renderUI({
  sidebarLayout(
    sidebarPanel(
      wellPanel(
        HTML("<label>Load previous app state:</label>"),
        # HTML("<a class='btn action-button shiny-bound-input' id='loadState' type='button' href='/'>Load</a>")
        fileInput('uploadState', ''),
        uiOutput("refreshOnUpload")
      ),
      wellPanel(
        HTML("<label>Save current app state:</label>"),
        downloadButton('downloadState', 'Save')

      ),
      wellPanel(
        HTML("<label>Reset to initial app state:</label>"),
        HTML("<a class='btn action-button shiny-bound-input' id='resetState' type='button' href='/'>Reset</a>")
      ),
      wellPanel(
        HTML("<label>Quit app:</label>"),
        actionButton('quitApp', 'Quit')
      ),
      helpModal('State','stateHelp',inclMD("tools/help/state.md"))
    ),
    mainPanel(
      verbatimTextOutput("showInput")
    )
  )
})

observe({
  inFile <- input$uploadState
  if(has.value(inFile)) {
    isolate({
      load(inFile$datapath)
      if(exists("RadiantValues")) values <<- do.call(reactiveValues, RadiantValues)
      if(exists("RadiantInputs")) state_list <<- RadiantInputs
    })
  }
})

output$refreshOnUpload <- renderUI({
  inFile <- input$uploadState
  if(has.value(inFile)) {
    # Joe Cheng: https://groups.google.com/forum/#!topic/shiny-discuss/Olr8m0JwMTo
    tags$script("window.location.reload();")

    #################################################################################
    # would be nice if this allowed a return to the state page ... or ... the
    # used before going to State. The below doesn't work ... yet
    #################################################################################
    # updateTabsetPanel(session, "nav_radiant", selected = "State") 
  }
})

output$downloadState <- downloadHandler(
  filename = function() { paste0("RadiantState-",Sys.Date(),".rda") },
  content = function(file) {

    isolate({
      RadiantInputs <- isolate(reactiveValuesToList(input))
      RadiantValues <- isolate(reactiveValuesToList(values))
      save(RadiantInputs, RadiantValues , file = file)
    })
  }
)

observe({
  if(is.null(input$resetState) || input$resetState == 0) return()
  setInitValues()
})

observe({
  if(is.null(input$quitApp) || input$quitApp == 0) return()
  unlink(c("www/rmd/cache/","www/rmd/figure"), recursive = TRUE)
  stopApp()   # stop Radiant
  q("no")     # quit R
  
  # from Joe Cheng's post at https://groups.google.com/forum/?fromgroups=#!searchin/shiny-discuss/close$20r/shiny-discuss/JptpzKxLuvU/boGBwwI3SjIJ
  # session$onSessionEnded(function() {
    # if(!dev_comp) q("no")
  # })
})

output$showInput <- renderPrint({
  # if(input$saveState > 0) cat("Current state saved\n\n")
  cat("State list:\n")
  print(state_list[sort(names(state_list))])
})

# Loading previous state from a fixed location
# observe({
#   if(is.null(input$loadState) || input$loadState == 0) return()

#   # Joe Cheng: https://github.com/rstudio/shiny/issues/331
#   if(file.exists("state/RadiantValues.rds")) 
#     values <<- do.call(reactiveValues, readRDS("state/RadiantValues.rds"))

#   if(file.exists("state/RadiantInputs.rds")) 
#     state_list <<- readRDS("state/RadiantInputs.rds")
# })

# Saving current state from a fixed location
# observe({
#   if(is.null(input$saveState) || input$saveState == 0) return()
#   # save app state
#   saveRDS(isolate(reactiveValuesToList(input)), file = "state/RadiantInputs.rds")
#   saveRDS(isolate(reactiveValuesToList(values)), file = "state/RadiantValues.rds")
# })
