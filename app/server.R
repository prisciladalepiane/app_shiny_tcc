server <- function(input, output, session) {
  
  ###  Cálculos 
  
  descript <- calcularTCT(matriz)
  
  descript <- 
    descript |>  
    mutate(Dificuldade = case_when(DIFI <= 0.25 ~ "Difícil", 
                                   DIFI > 0.25 & DIFI <= 0.75 ~ "Média", 
                                   DIFI  > 0.75 ~ "Fácil"))
          
  
  
  ### Renderizar outputs
  
  output$tbMatriz <- renderTable(LSAT)
  output$tbDescript <- renderTable(descript)
  
  output$tbRespostas <- renderDataTable({
    
    arq <- input$file1
    
    if(is.null(arq)){
      return(NULL)
    }
    
    return(read.csv2(arq$datapath))
  })
  
}
