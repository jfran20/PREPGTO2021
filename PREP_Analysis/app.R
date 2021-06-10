# Librerias ----
library(highcharter)
library(shiny)
library(shinycssloaders)
library(magrittr)
library(dplyr)
library(reshape2)
library(hablar)
library(tidyr)



source("./Functions/DistReg.R",encoding = "utf-8")
source("./Functions/Diputaciones.R",encoding = "utf-8")

source("./ui.R", encoding = "utf-8")
source("./server.R", encoding = "utf-8")

# Imagenes ----
addResourcePath("SBRimg"  ,'./Images/SBR.png')
addResourcePath("Faceimg" ,'./Images/facebook.png')
addResourcePath("Tweetimg",'./Images/tweeter.png')

shinyApp(ui,server)
#runApp(host="0.0.0.0",port = 5050)

