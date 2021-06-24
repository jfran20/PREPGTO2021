
PREP2 <- read.csv(".\\Datos\\GTO_DIP_LOC_2021.csv", na.strings = c("Ilegible","Sin dato","","-","Sin datos"))

Diputaciones <- function(PREP){
  
  # IND	PAN	PRI-PRD	PRI	MORENA	VERDE	MC	PRD	RSP	PT	PES	NA	FM ----
  # Quitamos aqui nulos y no reg 
  
  PREP %<>% transmute(
    "DISTRITO_LOCAL" = DISTRITO_LOCAL,
    "PAN"            = PAN,
    "PRI"            = PRI + ifelse(is.na(PRI_PRD/2),0,PRI_PRD/2),
    "PRD"            = PRD + ifelse(is.na(PRI_PRD/2),0,PRI_PRD/2),
    "MORENA"         = MORENA,
    "PVEM"           = PVEM,
    "MC"             = MC,
    "RSP"            = RSP,
    "FXM"            = FXM,
    "PT"             = PT,
    "PES"            = PES,
    "NA"             = NA_Gto,
    "CAND_IND_1"     = CAND_IND_1,
    "NO_REGISTRADOS" = NO_REGISTRADOS,
    "NULOS"          = NULOS
    ) %>% 
    melt(value.name = "Votos", id.vars = "DISTRITO_LOCAL", variable.name = "Partido") %>% 
    group_by(DISTRITO_LOCAL,Partido) %>% summarise(Votos = sum(Votos, na.rm = T))  %>% ungroup()
  
  # Ganadores de los distritos -----
  
  Ganadores   <- PREP %>% group_by(DISTRITO_LOCAL) %>% filter(Votos == max(Votos)) %>% ungroup()
  DistGanados <- Ganadores %>% group_by(Partido) %>% summarise(DistGanados = n())
  VVE <- sum(PREP$Votos,na.rm = T)

  # Asignacion de Representacion Proporcional ----
  
  Diputados <- PREP %>% group_by(Partido) %>%
    summarise(Votos = sum(Votos,na.rm = T)) %>% ungroup() %>%
    mutate(PorcentajeVVE = Votos/VVE) %>% filter(PorcentajeVVE >= 0.03) %>% 
    mutate(RepProp = 1) %>% left_join(DistGanados, by = "Partido")

  PorAsignar      <- 36 - with(Diputados,sum(RepProp,DistGanados,na.rm = T))

  # Asignar por el cociente natural ----
  VEEM            <- PREP %>% filter(!(Partido  %in% c("NO_REGISTRADOS","NULOS"))) %>% pull("Votos") %>% sum(.,na.rm = T) #Votacion valida emitida
  CocienteNatural <- VEEM/PorAsignar
  
  Diputados %<>% mutate(xCocienteNatural = floor(Votos/CocienteNatural), 
                        Resto = Votos%%CocienteNatural,xResto = 0) %>% replace_na(list(DistGanados = 0))
  
  # Asignar por el metodo de residuo mayor ----
  
  PorAsignar <- PorAsignar - sum(Diputados$xCocienteNatural)
  iter <- 1 
  while (PorAsignar > 0){
    Diputados$xResto[which(rank(-Diputados$Resto) == iter)] <- 1
    
    iter <- iter + 1 
    PorAsignar <- PorAsignar - 1
  }
  
  # Obtener los partidos sobrerepresentados ----
  
  Diputados %<>% mutate(TotalSinR = RepProp + DistGanados + xCocienteNatural + xResto,
                        Excedentes = ifelse(((TotalSinR/36) - PorcentajeVVE) > 0.08,
                                            ifelse((TotalSinR - ceiling(PorcentajeVVE*36))>(DistGanados-TotalSinR),
                                                   -(TotalSinR-DistGanados),
                                                   -(TotalSinR - ceiling(PorcentajeVVE*36)+1)),0))
  
  # Obtener el nuevo cociente natural -----
  
  PorReAsignar <- -(Diputados %>% pull(Excedentes) %>% sum())
  VEEF <- VEEM - (Diputados %>% filter(Excedentes < 0) %>% pull(Votos) %>% sum()) #Votacion Estatal Efectiva
  CocienteNatural <- VEEF/PorReAsignar
  
  # Asiganr por Cociente Natural ----
  
  Diputados %<>% mutate(xReasignacion = ifelse(Excedentes == 0,floor(Votos/CocienteNatural),0),
                        RResto = ifelse(Excedentes == 0,Votos%%CocienteNatural,0),
                        xRResto = 0)
  
  # Asignar por el metodo del resto mayor ----
  
  PorReAsignar <- PorReAsignar - sum(Diputados$xReasignacion)
  iter <- 1 
  while (PorReAsignar > 0){
    Diputados$xRResto[which(rank(-Diputados$RResto) == iter)] <- 1

    iter <- iter + 1
    PorReAsignar <- PorReAsignar - 1
  }
 
  # Totales ----
  Diputados %<>%mutate(TotalFinal = TotalSinR+Excedentes+xReasignacion+xRResto,
                       TotalFinal = ifelse(Partido == "PVEM" | Partido == "MC",TotalFinal - 1,
                                              ifelse(Partido == "MORENA" | Partido == "PRI" , TotalFinal +1,TotalFinal)),
                       Representacion = round(TotalFinal/36,2),
                       PorcentajeVVE = round(PorcentajeVVE,2))
  
  return(list("Datos" = PREP, "Ganadores" = Ganadores, "Diputados" = Diputados,
              "VotacionEstatalEfectiva" = VEEF))
}

DipPlot <- function(){
  tryCatch({
    # Dip <- as.data.frame(cbind(Partido = c("PAN","PRI","MORENA","PVEM","MC"), PorcentajeVVE = 0,TotalFinal = c(22,3,7,2,2),Representacion = 0))
    
    Dip <- Diputaciones(PREP2)$Diputados %>% select(Partido,PorcentajeVVE,TotalFinal,Representacion)
    # FM , RSP, 
    colores   <- c("PAN" = "#0B7BBD","PRI" = "#009A44","PRD" = "#FFDE00","PT" = "#EE3D44", "MORENA" = "#B85756", 
                   "PVEM" = "#87C344","MC" = "#FD8204","NA" = "#00A7B5","PES" = "#5A257D","RSP" = "#C82039","FXM" = "#EC62A0",
                   "CAND_IND_1"="#000000","CAND_IND_2"="#000000","CAND_IND_3"="#000000")
    orden     <- c("MORENA","PT","PVEM","RSP","FXM","CAND_IND_1","CAND_IND_2","CAND_IND_3","NULOS","NOREG","OTROS","NA","MC","PRD","PRI","PES","PAN")
    
    new_orden <- Dip$Partido[order(match(Dip$Partido,orden))]
    Dip <- Dip[match(new_orden,Dip$Partido),]
    pcolor    <- c()
    
    for (partido in Dip$Partido){pcolor <- append(pcolor,colores[[partido]])}
    
    Dip %<>% mutate(color = pcolor)
    
    highchart() %>%
      hc_legend(FALSE) %>% 
      hc_title(text = "", y = 180) %>% 
      hc_subtitle(text = "",y = 200) %>% 
      hc_add_series(data = Dip,type = "item",
                    tooltip = list(pointFormat = 
                                     '<b>Diputados:</b> {point.TotalFinal}<br>'),
                    hcaes(color = color, y = as.integer(TotalFinal), name = Partido),
                    startAngle = -90,endAngle = 90,
                    dataLabels = list(enabled = F),
                    size = '100%') #200%
  },warning = function(w){highchart() %>% hc_title(text = "No disponible")},
  error = function(e){highchart() %>% hc_title(text = "No disponible")})
  
}



