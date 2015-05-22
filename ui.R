# ui.R
library(shiny);require(markdown);load("badloan.rf.Rda")
shinyUI(pageWithSidebar(
  headerPanel("LendingClub Loan Quality Predictor"),
  ## ----------
  ## Side Panel
  ## ----------
  sidebarPanel(
    wellPanel(helpText(HTML("<b>Input Parameters</b>")),
              sliderInput("fico_range","FICO Score Range",
                          min=540,max=850,value=c(650,750)),
              selectInput("homeOwnership","Home Ownership",
                          choices = c("NONE","ANY","MORTGAGE","OWN","RENT","OTHER")),
              numericInput("pub_rec","Public Records on File (Bankruptcies)",
                          value = 0),
              sliderInput("revol_util","Revolving Credit Utilization (in %)",
                           min=0,max=100,value=15),
              numericInput("inq_last_6mths","Account Inquiries (trailing 6 months)",
                           value = 0),
              hr(),
              actionButton("action","Calculate Loan Success")
    )
  ),
  ## ----------
  ## Main Panel
  ## ----------
  mainPanel(
    tabsetPanel(
      tabPanel("Introduction",includeMarkdown("readme.md")),
      tabPanel("Prediction",verbatimTextOutput("Process"))
    )
  )
))