# Server ----

server <- function(input,output){
  
  output$a1 <- renderHighchart({RegPlot("ABASOLO")})
  output$b1 <- renderHighchart({RegPlot("ACAMBARO")})
  output$c1 <- renderHighchart({RegPlot("SAN MIGUEL DE ALLENDE")})
  output$d1 <- renderHighchart({RegPlot("APASEO EL ALTO")})
  output$e1 <- renderHighchart({RegPlot("APASEO EL GRANDE")})
  output$a2 <- renderHighchart({RegPlot("ATARJEA")})
  output$b2 <- renderHighchart({RegPlot("CELAYA")})
  output$c2 <- renderHighchart({RegPlot("MANUEL DOBLADO")})
  output$d2 <- renderHighchart({RegPlot("COMONFORT")})
  
  output$e2 <- renderHighchart({RegPlot("CORONEO")})
  output$a3 <- renderHighchart({RegPlot("CORTAZAR")})
  output$b3 <- renderHighchart({RegPlot("CUERAMARO")})
  output$c3 <- renderHighchart({RegPlot("DOCTOR MORA")})
  output$d3 <- renderHighchart({RegPlot("DOLORES HIDALGO CUNA DE LA INDEPENDENCIA NACIONAL")})
  output$e3 <- renderHighchart({RegPlot("GUANAJUATO")})
  output$a4 <- renderHighchart({RegPlot("HUANIMARO")})
  output$b4 <- renderHighchart({RegPlot("IRAPUATO")})
  output$c4 <- renderHighchart({RegPlot("JARAL DEL PROGRESO")})
  
  output$d4 <- renderHighchart({RegPlot("JERECUARO")})
  output$e4 <- renderHighchart({RegPlot("LEON")})
  output$a5 <- renderHighchart({RegPlot("MOROLEON")})
  output$b5 <- renderHighchart({RegPlot("OCAMPO")})
  output$c5 <- renderHighchart({RegPlot("PENJAMO")})
  output$d5 <- renderHighchart({RegPlot("PUEBLO NUEVO")})
  output$e5 <- renderHighchart({RegPlot("PURISIMA DEL RINCON")})
  output$a6 <- renderHighchart({RegPlot("ROMITA")})
  output$b6 <- renderHighchart({RegPlot("SALAMANCA")})
  
  output$c6 <- renderHighchart({RegPlot("SALVATIERRA")})
  output$d6 <- renderHighchart({RegPlot("SAN DIEGO DE LA UNION")})
  output$e6 <- renderHighchart({RegPlot("SAN FELIPE")})
  output$a7 <- renderHighchart({RegPlot("SAN FRANCISCO DEL RINCON")})
  output$b7 <- renderHighchart({RegPlot("SAN JOSE ITURBIDE")})
  output$c7 <- renderHighchart({RegPlot("SAN LUIS DE LA PAZ")})
  output$d7 <- renderHighchart({RegPlot("SANTA CATARINA")})
  output$e7 <- renderHighchart({RegPlot("SANTA CRUZ DE JUVENTINO ROSAS")})
  output$a8 <- renderHighchart({RegPlot("SANTIAGO MARAVATIO")})
  
  output$b8 <- renderHighchart({RegPlot("SILAO DE LA VICTORIA")})
  output$c8 <- renderHighchart({RegPlot("TARANDACUAO")})
  output$d8 <- renderHighchart({RegPlot("TARIMORO")})
  output$e8 <- renderHighchart({RegPlot("TIERRA BLANCA")})
  output$a9 <- renderHighchart({RegPlot("URIANGATO")})
  output$b9 <- renderHighchart({RegPlot("VALLE DE SANTIAGO")})
  output$c9 <- renderHighchart({RegPlot("VICTORIA")})
  output$d9 <- renderHighchart({RegPlot("VILLAGRAN")})
  output$e9 <- renderHighchart({RegPlot("XICHU")})
  
  output$e10 <- renderHighchart({RegPlot("YURIRIA")})
  output$e11 <- renderHighchart({DipPlot()})
  
}