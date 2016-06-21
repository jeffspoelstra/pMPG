pMPG: An Applet for Predicting Vehicle MPG
========================================================
author: Jeff Spoelstra
date: 06/21/2016
width: 1280
height: 1024



Introduction
========================================================

- pMPG is an applet for predicting vehicle miles-per-gallon (MPG) performance
- Written using R (R version 3.3.0 (2016-05-03)), RStudio (version 0.99.902), and the shiny applet development package (version 0.13.2)
- Calculates a theoretical prediction model based on a sample of vehicles
- Predicts MPG for a specific vehicle based on number of engine cylinders, transmission type, and gross vehicle weight
- Live applet available at http://jeffspoelstra.shinyapps.io/pMPG-applet/
- Source available at https://github.com/jeffspoelstra/pMPG.git

Data Source
========================================================

- The source of the data used to create the theoretical model for MPG predictions is the mtcars data set available in the R datasets package (partially shown below).


```
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

Using pMPG
========================================================

![pMPG sidebar image](sidebar.png)

***

- Enter specific vehicle characteristics using the input mechanisms in the left-hand sidebar.


Using pMPG
========================================================

- Predicted MPG will appear as a green horizontal line on the theoretical MPG chart in the main applet window.
- Prediction will change real-time as the vehicle characteristics are changed.

***
![pMPG main image](main.png)

