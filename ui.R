library(shiny)

# Shiny app user interface control function.
shinyUI(pageWithSidebar(
    # Set main title of the application in the header panel.
    headerPanel('pMPG - Vehicle MPG Predictor Applet'),
    
    # Create a sidebar panel for entering vehicle characteristic info.
    sidebarPanel(
        h4('Vehicle Characteristics'),
        radioButtons('vcyl', 'Cylinders', c('4' = 4, '6' = 6, '8' = 8)),
        radioButtons('vtrx', 'Transmission', c('Automatic' = 0, 'Manual' = 1)),
        numericInput('vwt', 'Weight (lbs)', 3000, min=1500, max=5500, step=500)
    ),
    
    # Format the main panel to echo the vehicle characteristics entered and
    # to contain a chart showing the predicted mpg.
    mainPanel(
        h3('Predicted MPG'),
        p('Select the characteristics of the vehicle in question in the sidebar to the left. A chart showing theorectical MPG performance (black line) and predicted MPG based on the chosen vehicle characteristics will appear below.'),
        textOutput('vcyl'),
        textOutput('vwt'),
        textOutput('vtrx'),
        plotOutput('mpgchart')
    )
))