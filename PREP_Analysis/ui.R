ui <- fluidPage(
  # Header ----
  tags$head(includeCSS('./style.css')),
  HTML("
        <h1 style='font-family:Antonio; font-size: 50px;'>Elecciones 2021</h1>
        <h2><b>PREP</b> <i>Regidurias y Diputados GTO</i></h2>
        <div class = 'topnav'>
              <a href= 'https://sbr-mx.com/' target='_blank'>SBR</a>
              <a href = 'https://politica.sbr-mx.com/' target='_blank'>Eleccion 2021</a>
        </div>"),
  
  # Charts ----
  fluidRow(style="display: flex; justify-content: space-around;", 
    column(2, 
           highchartOutput("a1",width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("a2", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("a3", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("a4", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("a5", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("a6", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("a7", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("a8", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("a9", width = "100%", height = "260px") %>% withSpinner(color = "gray"), 
           ),

    column(2, 
           highchartOutput("b1", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("b2", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("b3", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("b4", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("b5", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("b6", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("b7", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("b8", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("b9", width = "100%", height = "260px") %>% withSpinner(color = "gray")),
    
    column(2, 
           highchartOutput("c1", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("c2", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("c3", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("c4", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("c5", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("c6", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("c7", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("c8", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("c9", width = "100%", height = "260px") %>% withSpinner(color = "gray")),
    
    column(2, 
           highchartOutput("d1", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("d2", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("d3", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("d4", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("d5", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("d6", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("d7", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("d8", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("d9", width = "100%", height = "260px") %>% withSpinner(color = "gray")),
    
    column(2, 
           highchartOutput("e1", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("e2", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("e3", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("e4", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("e5", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("e6", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("e7", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("e8", width = "100%", height = "260px") %>% withSpinner(color = "gray"),
           highchartOutput("e9", width = "100%", height = "260px") %>% withSpinner(color = "gray"))),
  
  fluidRow(column(4,
                  highchartOutput("e10", width = "100%", height = "260px") %>% withSpinner(color = "gray")),
           column(8,
                  highchartOutput("e11",width = "100%", height = "260px") %>% withSpinner(color = "gray")
           )),
  
  # Footer ----
  HTML("<hr style = 'border-top: 2px solid rgb(25, 25, 25);'/>
            <div style='display: flex; justify-content: space-around; align-content: center; margin: 0 0 2rem 0'>
                <div style='display: flex; flex-direction: column; padding: 0 0 0 1rem;'>
                    <a href = 'https://sbr-mx.com/' target = '_blank'> <img src = 'SBRimg' height = '25px' width ='50px' class='contact'></a>
                </div>
                
                <div style='display: flex; padding: 0 1rem 0 1rem;'>
                    <p> 2021 <a href='https://sbr-mx.com/' style='color:black' target='_blank'> Statistical Bureau for Research </a></p> 
                </div>
                
                <div style='display: flex; flex-direction: column; padding: 0 1rem 0 0;'>
                    <a href = 'https://www.facebook.com/SBRmex' target = '_blank'> <img src = 'Faceimg' height = '25px' width ='25px' class='contact'></a>
                    <a href = 'https://twitter.com/sbr_mx' target = '_blank'> <img src = 'Tweetimg' height = '25px' width ='25px' class='contact'></a>
                </div>
            </div>"))
