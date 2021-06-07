# Librerias ----
library(highcharter)
library(shiny)
library(shinycssloaders)
library(magrittr)
library(dplyr)
library(reshape2)
library(hablar)
library(tidyr)


setwd("C:\\Users\\jfran\\Desktop\\SBR\\Dashboards\\PREP_Analysis")


source(".\\Functions\\DistReg.R",encoding = "utf-8")
source(".\\Functions\\Diputaciones.R",encoding = "utf-8")

source(".\\ui.R", encoding = "utf-8")
source(".\\server.R", encoding = "utf-8")

# Imagenes ----
addResourcePath("SBRimg"  ,'C:\\Users\\jfran\\Desktop\\SBR\\Dashboards\\PREP_Analysis\\Images\\SBR.png')
addResourcePath("Faceimg" ,'C:\\Users\\jfran\\Desktop\\SBR\\Dashboards\\PREP_Analysis\\Images\\facebook.png')
addResourcePath("Tweetimg",'C:\\Users\\jfran\\Desktop\\SBR\\Dashboards\\PREP_Analysis\\Images\\tweeter.png')

shinyApp(ui,server)
#runApp(host="0.0.0.0",port = 5050)

