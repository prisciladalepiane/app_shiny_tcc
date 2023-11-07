server <- function(input, output, session) {
  
  ###  Cálculos 
  
  descript <- calcularTCT(matriz)
  
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
