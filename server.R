# server.R
library(shiny);library(randomForest);load("badloan.rf.Rda");
shinyServer(
  function(input, output) {
    process <- eventReactive(input$action, {
      last_fico_range_high <- input$fico_range[2]
      last_fico_range_low  <- input$fico_range[1]
      pub_rec              <- input$pub_rec
      revol_util           <- input$revol_util
      inq_last_6mths       <- input$inq_last_6mths
      is.rent              <- 0
      if(input$homeOwnership=='RENT') {
        is.rent <- 1
      }
      newdata <- data.frame(last_fico_range_high,
                            last_fico_range_low,
                            pub_rec,
                            revol_util,
                            inq_last_6mths,
                            is.rent)
      
      pred <- predict(badloanFit.rf, newdata,type='response')
      if(as.numeric(pred)==1) {
        pred <- c("Loan is likely to be good, and be fully repaid")
      } else if (as.numeric(pred)==2) {
        pred <- c("Loan is likely to be risky, and end in default")
      }
    })
    output$Process <- renderText({
      process()
    })
})