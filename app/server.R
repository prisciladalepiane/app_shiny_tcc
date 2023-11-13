server <- function(input, output, session) {
  
  ###  Cálculos 
  
  tct <- calcularTCT(matriz[,-1])
  
  descript <- tct |>  
    mutate(Dificuldade = classificacaoDificuldade(DIFI),
           Bisserial = classificacaoBisserial(BIS))
  
  ### Renderizar outputs
  
  output$tbDescript <- renderTable(descript)
  
  output$tbAlternativas <- renderTable(tct_alternativas)
  
  output$tbRespostas <- renderDataTable({
    
    arq <- input$file1
    
    if(is.null(arq)){
      return(NULL)
    }
    
    return(read.csv2(arq$datapath))
  })
  
  filtrarQuestao <- eventReactive(input$slQuestao,{
    grafico_alt |> filter(CodigoQuestao == input$slQuestao) 
   
  })
  
  output$gfAlternativas <- renderPlot(
    filtrarQuestao() |>
      ggplot() +
      aes(x = Acertos, y = n, colour = Alternativa) +
      geom_line(size = 1) +
      scale_color_hue(direction = 1) +
      theme_classic() + theme(
        plot.background = element_rect(fill = "#EEEEEE"), 
        panel.background = element_rect(fill = "#EEEEEE", colour="#EEEEEE"),
        legend.background=element_rect(fill="#EEEEEE", colour=NA)
      )
      )
  
  output$dwDescript <- downloadHandler("indices_tct_item.csv",
                                       content = function(file){
                                         write.csv2(descript, file, row.names = FALSE)
                                       })
  
  output$dwTctAlt <- downloadHandler("indices_tct_alternativa.csv",
                                       content = function(file){
                                         write.csv2(descript, file, row.names = FALSE)
                                       })

  
}
