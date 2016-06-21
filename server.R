# Load required packages and data sets.
library(shiny)
library(datasets)
data(mtcars)
library(ggplot2)

# Create the linear model for predicting mpg from number of cylinders, 
# vehicle weight, and transmission type.
mcw<-lm(mpg ~ cyl + wt + am, data=mtcars)

# Shiny app server function.
shinyServer(
    function(input, output) {
        # Format number of cylinders for display.
        output$vcyl <- renderText({paste('Cylinders: ', input$vcyl)})
        
        # Format vehicle weight for display.
        output$vwt <- renderText({paste('Weight:', input$vwt)})
        
        # Format vehicle transmission type for display.
        output$vwt <- renderText({
            paste('Transmission Type:', ifelse(input$vtrx == 0, 'Automatic', 'Manual'))
        })
        
        # Create the chart showing predicted vehicle MPG.
        output$mpgchart <- renderPlot({
            # Calculate the various components for a predicted mpg based on
            # the linear model determined when the server was started. Use the
            # specific inputs given to determine a specific mpg prediction.
            intcept <- summary(mcw)$coefficients[1, 1]
            cylfactor <- summary(mcw)$coefficients[2, 1] * as.numeric(input$vcyl)
            wtfactor <- summary(mcw)$coefficients[3, 1] * (as.numeric(input$vwt) / 1000)
            trxfactor <- summary(mcw)$coefficients[4, 1] * as.numeric(input$vtrx)
            predval <- intcept + cylfactor + wtfactor + trxfactor
            predmpg <- as.data.frame(predval)
            
            # Create a chart of the linear mpg prediction model and overlay
            # the predicted mpg on it as a horizontal line.
            g <- ggplot(data=mtcars, aes(x=wt, y=mpg)) +
                 scale_x_continuous(limits=c(min(mtcars$wt) - 0.2, 
                                             max(mtcars$wt) + 0.2), 
                                    breaks=c(1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0)) +
                 scale_y_continuous(limits=c(min(mtcars$mpg) - 5, max(mtcars$mpg) + 5)) +
                 geom_abline(slope=summary(mcw)$coefficients[3, 1], 
                             intercept=intcept+cylfactor+trxfactor, 
                             size=1.5, color='black') +
                 geom_hline(data=predmpg, aes(yintercept=predmpg), 
                            size=2, color='green') +
                 annotate('text', x=min(mtcars$wt) + 0.25, y=predval, 
                          label=paste('Predicted MPG=', format(predval, digits=3, nsmall=1, scientific=FALSE))) +                
                 labs(title="Theoretical Model of MPG vs Vehicle Weight", 
                      x="Weight (x 1,000 lbs)", y="Miles per Gallon")
            print(g)
        })
    }
)