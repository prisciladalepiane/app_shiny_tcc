
###########################  Server  ###########################################

server <- function(input, output, session) {
  
  
  descript <- calcularTCT(matriz)
  
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
