server <- function(input, output, session) {
  
  ###  Cálculos 
  
  tct <- calcularTCT(matriz[,-1])
  
  descript <- tct |>  
    mutate(Nivel = classificacaoDificuldade(DIFI),
           Discriminacao = classificacaoDiscriminacao(DISCR),
           Sugestao = classificacaoDiscriminacaoAcao(DISCR))
  
  descript_show <- descript  |>
   mutate(
     Item = ifelse(BIS > 0.2, Item,
                  paste('<font color="red">',icon("triangle-exclamation"),Item,'</font>'))
     # ,Discriminacao = ifelse(DISCR > 0.2, Discriminacao,
     #                        paste('<font color="red">',Discriminacao,'</font>'))
     ) |> 
   mutate_if(is.double,~round(.,3)) 
    # mutate(BIS = ifelse(BIS < 0.15, paste('<font color="red">', icon("circle-down"),  BIS), BIS))
    
  # distribuicao_dif <- descript |> 
  #   group_by(Dificuldade) %>% 
  #   summarise(n = n(), p = round(n/nrow(.)*100,1))
  # 
  # distribuicao_bis <- descript |> 
  #   group_by(Dificuldade) %>% 
  #   summarise(n = n(), p = round(n/nrow(.)*100,1))
  
  tct_alt_show <- tct_alt |> mutate_if(is.double,~round(.,3))|>
    mutate(rspP = paste(rspP*100,"%")) |>
    arrange(Item, key) %>% 
    mutate_all(~ifelse(!str_detect(correct, "\\*"), ., paste("<b>",.,"</b>"))) 

  
  names(tct_alt_show) <- c("Item","Correta", "Alt", "n", "%","Bisserial","Discr","Q1","Q2","Q3","Q4")
  
  ### Renderizar outputs
  
  output$tbDescript <- renderDT({
    DT::datatable(descript_show, options = list(
      language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Portuguese.json'),
      pageLength = 20), escape = F, rownames = F
    )
  })
  
  output$tbDistDif <- renderTable(distribuicao_dif)
  
  output$tbAlternativas <- renderDT(
                   datatable(tct_alt_show, options = list(
                     language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Portuguese.json'),
                     pageLength = 20), escape = F, rownames = F
                   ))
  
  output$tbRespostas <- renderDataTable({
    
    arq <- input$file1
    
    if(is.null(arq)){
      return(NULL)
    }
    
    return(read.csv2(arq$datapath))
  })
  
  filtrarQuestaoGrafico <- eventReactive(input$slQuestao,{
    grafico_alt2 |> filter(CodigoQuestao == input$slQuestao) 
   
  })
  
  filtrarQuestaoTabela <- eventReactive(input$slQuestao,{
    tct_alternativas |> filter(Item == input$slQuestao) |> select(-Item)
    
  })
  
  output$gfAlternativas <- renderPlot(
    filtrarQuestaoGrafico() |>
      ggplot() +
      aes(x = Acertos, y = p, colour = Alternativa) +
      geom_line(size = 1) +
      scale_color_hue(direction = 1) + ylab("Proporção") +
      theme_classic() + theme(
        plot.background = element_rect(fill = "#EEEEEE"), 
        panel.background = element_rect(fill = "#EEEEEE", colour="#EEEEEE"),
        legend.background=element_rect(fill="#EEEEEE", colour=NA)
      )
      )
  
  output$tbFiltroAlternativas <- renderTable(filtrarQuestaoTabela())
  
  output$dwDescript <- downloadHandler("indices_tct_item.csv",
                                       content = function(file){
                                         write.csv2(descript, file, row.names = FALSE)
                                       })
  
  output$dwTctAlt <- downloadHandler("indices_tct_alternativa.csv",
                                       content = function(file){
                                         write.csv2(tct_alt, file, row.names = FALSE)
                                       })

  
}
