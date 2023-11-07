server <- function(input, output, session) {
  
  ###  Cálculos 
  
  tct <- calcularTCT(matriz)
  
  descript <- tct |>  
    mutate(Dificuldade = case_when(DIFI <= 0.1 ~ "Muito Difícil", 
                                   DIFI > 0.1 & DIFI <= 0.3 ~ "Difícil", 
                                   DIFI > 0.3 & DIFI <= 0.7 ~ "Média", 
                                   DIFI > 0.7 & DIFI <= 0.9 ~ "Fácil", 
                                   DIFI  > 0.9 ~ "Muito Fácil"))
  
  
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
