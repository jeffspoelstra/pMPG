# Load required packages and data sets.
library(shiny)
library(datasets)
data(mtcars)
library(ggplot2)

# Create the linear model predicting mpg from number of cylinders and vehicle weight.
mcw<-lm(mpg ~ cyl + wt, data=mtcars)

# Shiny app server function.
shinyServer(
    function(input, output) {
        # Format number of cylinders for display.
        output$vcyl <- renderText({
            input$pbutton
            isolate(paste('Cylinders: ', input$vcyl))
        })
        # Format vehicle weight for display.
        output$vwt <- renderText({
            input$pbutton
            isolate(paste('Vehicle Weight:', input$vwt))
        })
        # Create chart showing predicted vehicle MPG.
        output$mpgchart <- renderPlot({
            input$pbutton
            submt <- mtcars[mtcars$cyl==input$vcyl,]
            cylfactor <- summary(mcw)$coefficients[2, 1] * as.numeric(input$vcyl)
            predmpg <- as.data.frame(summary(mcw)$coefficients[1, 1] + cylfactor +
                       summary(mcw)$coefficients[3, 1] * as.numeric(input$vwt)/1000)
            g <- ggplot(data=submt, aes(x=wt, y=mpg)) +
                 scale_x_continuous(limits=c(min(submt$wt-0.5), max(submt$wt+0.5)), 
                                    breaks=c(1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0)) +
                 scale_y_continuous(limits=c(min(submt$mpg-5), max(submt$mpg+5))) +
                 geom_abline(slope=summary(mcw)$coefficients[3, 1], 
                             intercept=summary(mcw)$coefficients[1, 1]+cylfactor, 
                             size=2, color='lightblue') +
                 geom_hline(data=predmpg, aes(yintercept=predmpg), 
                            size=2, color='green') +
                 labs(title="MPG vs Vehicle Weight", 
                      x="Weight (x 1,000 lbs)", y="Miles per Gallon")
            print(g)
        })
    }
)