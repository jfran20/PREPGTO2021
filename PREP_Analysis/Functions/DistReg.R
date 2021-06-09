PREP <- read.csv(".\\Datos\\GTO_AYUN_2021.csv", na.strings = c("Ilegible","Sin dato","","-","Sin datos"))

DistribuirReg <- function(PREP,MUN){
  
  PREP %<>% transmute(
    "MUNICIPIO"      = MUNICIPIO,
    "SECCION"        = SECCION,
    "PAN"            = PAN,
    "PRI"            = PRI + ifelse(is.na(PRI_PRD/2),0,PRI_PRD/2),
    "PRD"            = PRD + ifelse(is.na(PRI_PRD/2),0,PRI_PRD/2),
    "PVEM"           = PVEM,
    "PT"             = PT,
    "MC"             = MC,
    "MORENA"         = MORENA,
    "NA"             = NA_Gto,
    "PES"            = PES,
    "RSP"            = RSP,
    "FXM"            = FXM,
    "CAND_IND_1"     = CAND_IND_1,
    "CAND_IND_2"     = CAND_IND_2,
    "NO_REGISTRADOS" = NO_REGISTRADOS,
    "NULOS"          = NULOS)
  
  # Voltear ----
  
  PREP %<>% 
    melt(id.vars = c("MUNICIPIO","SECCION"), variable.name = "Partido",value.name = "Votos") %>% 
    group_by(MUNICIPIO,Partido) %>% summarise(Votos = sum(Votos, na.rm = T)) %>% ungroup()
  

  # Obtener el porcentaje ya con los Votos Validos Emitidos ----
  
   ValidoEmitido <-
    PREP %>% filter(MUNICIPIO == MUN) %>% 
    group_by(MUNICIPIO,Partido) %>% 
    summarise(Votos = sum(Votos,na.rm = T)) %>% 
    mutate(Votos = ifelse(Partido %in% c("NULOS","NO_REGISTRADOS"),0,Votos),
           PorcentajeValido = Votos/sum(Votos,na.rm = T)) %>% ungroup()
    
   # Obtener el número de regidores y Coeficiente Electoral ----
   
   NumRegidores <- read.csv(".\\Datos\\11REG.csv", encoding = "UTF-8") %>%
     filter(MUNICIPIO == MUN) %>% pull(REG)
   
   CocienteElectoral <- sum(ValidoEmitido$Votos,na.rm = T)/NumRegidores
   
   # Tabla de regidores ----
   
   Reporte <- ValidoEmitido %>% 
     select(Partido,Votos,PorcentajeValido) %>% 
     mutate(RepresentacionProporcional = ifelse(PorcentajeValido >= 0.03,floor(Votos/CocienteElectoral),0))
  
   RegidoresFaltantes <- NumRegidores - sum(Reporte$RepresentacionProporcional,na.rm = T)

   # Distribuye por el metodo del resto mayor
   
   if(RegidoresFaltantes > 0){
     
     Restos <- Reporte %>% 
       mutate(Restos = Votos-(RepresentacionProporcional*CocienteElectoral)) %>% 
       filter(PorcentajeValido >= 0.03) %>% 
       arrange(-Restos) %>% mutate(PorResto = 0) %>% 
       select(-c(Votos,PorcentajeValido,RepresentacionProporcional))
     
     iter <- 1
     while(RegidoresFaltantes > 0){
       
       Restos$PorResto[iter] <- Restos$PorResto[iter] + 1
       RegidoresFaltantes <- RegidoresFaltantes - 1
       
       if(iter == count(Restos)){iter <- 1}
       else{iter <- iter + 1}
     }
     
     Reporte %<>% left_join(Restos, by = "Partido") %>% arrange(-PorcentajeValido) %>% 
       mutate(Regidores = RepresentacionProporcional + PorResto)
   }
   
  return(list("Tabla" = Reporte, 
              "CocienteElectoral" = CocienteElectoral,
              "Regidores" = NumRegidores)) 
}

RegPlot <- function(mun){
tryCatch({
  
  Regidores <- DistribuirReg(PREP,mun)$Tabla
  colores   <- c("PAN" = "#0B7BBD","PRI" = "#009A44","PRD" = "#FFDE00","PT" = "#EE3D44", "MORENA" = "#B85756",
                 "PVEM" = "#87C344","MC" = "#FD8204","NA" = "#00A7B5","PES" = "#5A257D",
                 "RSP" = "#C82039","FXM" = "#EC62A0","CAND_IND_1"="#000000","CAND_IND_2"="#000000",
                 "CAND_IND_3"="#000000")
  orden     <- c("MORENA","PT","PVEM","RSP","FXM","CAND_IND_1","CAND_IND_2","CAND_IND_3","NA","MC","PRD","PRI","PES","PAN")

  Regidores %<>% filter(!is.na(Regidores)|Regidores!=0)
  
  new_orden <- unique(Regidores$Partido)[order(match(unique(Regidores$Partido),orden))]
  Regidores <- Regidores[match(new_orden,Regidores$Partido),]
  pcolor    <- c()
  
  for (partido in Regidores$Partido){pcolor <- append(pcolor,colores[[partido]])}
    
  Regidores %<>% mutate(color = pcolor)
  
    highchart() %>%
      hc_legend(FALSE) %>% 
      hc_title(text = paste("Regidores de",mun)) %>% 
      hc_subtitle(text = "Datos del PREP") %>% 
      hc_add_series(data = Regidores,type = "item",
                    tooltip = list(pointFormat = 
                                     '<b>Regidores:</b> {point.Regidores}<br>'),
                    hcaes(color = color, y = Regidores, name = Partido),
                    startAngle = -100,endAngle = 100, rows = 1,
                    dataLabels = list(enabled = F),
                    size = '100%') 
  },warning = function(w){highchart() %>% hc_title(text = "No disponible")},
   error = function(e){highchart() %>% hc_title(text = "No disponible")})

}

# DistribuirReg(PREP,"SALAMANCA")
# RegPlot("LEON")
# RegPlot("IRAPUATO")
# RegPlot("SALAMANCA")
# RegPlot("GUANAJUATO")
# RegPlot("CELAYA")
# RegPlot("SILAO DE LA VICTORIA")

r_o <- DistribuirReg(PREP,"SILAO DE LA VICTORIA")
