server <- function(input, output, session) {
  
  ###  Cálculos 
  
  tct <- calcularTCT(matriz)
  
  descript <- tct |>  
    mutate(Dificuldade = case_when(DIFI <= 0.1 ~ "Muito Difícil", 
                                   DIFI > 0.1 & DIFI <= 0.3 ~ "Difícil", 
                                   DIFI > 0.3 & DIFI <= 0.7 ~ "Média", 
                                   DIFI > 0.7 & DIFI <= 0.9 ~ "Fácil", 
                                   DIFI  > 0.9 ~ "Muito Fácil"),
           Bisserial = case_when(
             BIS <= 0 ~ "Inapropriado",
             BIS > 0   & BIS <= 0.1 ~ "Inadequado",
             BIS > 0.1 & BIS < 0.2 ~ "Moderado",
             BIS > 0.2 & BIS < 0.3 ~ "Adequado",
             BIS > 0.3 & BIS < 1 ~ "Excelente"
           ))
  
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
