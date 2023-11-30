server <- function(input, output, session) {
  
  
  ###  Cálculos 
  
  resposta <- teste |> mutate(CodigoQuestao = str_sub(CodigoQuestao,1,3))
  gabarito <- gabarito_teste |> mutate(Item = str_sub(Item,1,3))
  
  respostaReac <- reactive({
    if(is.null(input$file1)){
      resposta
    }else{
      read.csv2(input$file1$datapath)
    }
  })
  
  gabaritoReac <- reactive({
    if(is.null(input$file2)){
     gabarito
    }else{
     read.csv2(input$file2$datapath)
    }
  })
  

  questoes <- gabarito$Item
  
  matriz <- respostasParaMatriz(respostas) 
  
  matriz_alternativas <- respostasParaMatriz(respostas, alternativas = T)
  
  tct_alt <- calculoTctAlternativas(matriz_alternativas, gabarito) 
  
  tct_alt <- tct_alt %>% 
    filter(key > 0) %>% 
    mutate(key = LETTERS[as.numeric(key)]) 
  
  tct_alternativas <- formatarTctAlternativas(tct_alt)
  
  acertos <- matriz |> select(RespondenteId) |> mutate(Acertos = rowSums(matriz[,-1]))
  
  grafico_alt <- respostas |> left_join(acertos) |>
    group_by(Acertos,CodigoQuestao,AlternativaOrdem) |> 
    count() |>
    mutate(Alternativa = LETTERS[AlternativaOrdem]) 
  
  grafico_alt2 <- grafico_alt |> left_join(
    grafico_alt |> group_by(CodigoQuestao,Acertos) |> summarise(Total = sum(n))
  ) |> mutate(p = n/Total) 
  
  
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
    

  tct_alt_show <- tct_alt |> mutate_if(is.double,~round(.,3))|>
    mutate(rspP = paste(rspP*100,"%")) |>
    arrange(Item, key) %>% 
    mutate_all(~ifelse(!str_detect(correct, "\\*"), ., paste("<b>",.,"</b>"))) 

  
  names(tct_alt_show) <- c("Item","Correta", "Alt", "n", "%","Bisserial","Discr","Q1","Q2","Q3","Q4")
  
  ### Renderizar outputs
  
  output$tbDescript <- renderDT({
    DT::datatable(descript_show, options = list(
      language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Portuguese.json'),
      pageLength = 25), escape = F, rownames = F
    )
  })
  
  output$tbAlternativas <- renderDT(
                   datatable(tct_alt_show, options = list(
                     language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Portuguese.json'),
                     pageLength = 25), escape = F, rownames = F
                   ))
  
  output$tbRespostas <- renderDataTable(respostaReac(), options = list(
    language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Portuguese.json')),
    rownames = F
  )
  
  output$tbGabarito<- renderDataTable({ 
      gabaritoReac()
    }, options = list(
      language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Portuguese.json')),
    rownames = F
  )
  
  filtrarQuestaoGrafico <- eventReactive(input$slQuestao,{
    grafico_alt2 |> filter(CodigoQuestao == input$slQuestao) 
   
  })
  
  filtrarQuestaoTabela <- eventReactive(input$slQuestao,{
    tct_alternativas |> filter(Item == input$slQuestao) |> select(-Item)
    
  })
  
  filtrarTabelaTCTItem <- eventReactive(input$slQuestao,{
    tct|> filter(Item == input$slQuestao) |> select(-Item)
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
  
  output$tbFiltroItem <- renderTable(filtrarTabelaTCTItem())
  
  output$dwDescript <- downloadHandler("indices_tct_item.csv",
                                       content = function(file){
                                         write.csv2(descript, file, row.names = FALSE)
                                       })
  
  output$dwTctAlt <- downloadHandler("indices_tct_alternativa.csv",
                                       content = function(file){
                                         write.csv2(tct_alt, file, row.names = FALSE)
                                       })

  
}
