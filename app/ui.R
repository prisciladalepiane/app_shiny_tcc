###########################  Interface Usuario ################################# 


ui <- navbarPage(
  
  title = "Teoria Clássica dos Testes",
  selected = "Índices TCT",
  
  tags$script(src = "https://kit.fontawesome.com/<you>.js"),
  
  tags$head(
    tags$style(HTML("
        
                body {
                  background-color: #EEEEEE;
                  color: black;
                }
                .shiny-input-container {
                    text-align: center;
                    font-size: 18px
                }
                
                .btn-default { 
                    background-color: #286090;
                    color: #fff;
                }
                .well {
                     background-color: #EEEEEE;  
                     box-shadow: unset;
                     border: unset;
                }
           
                
                /* Make text visible on inputs */
                                "))
  ),
  header = use_theme(
    create_theme(
      theme = "default",
      bs_vars_navbar(
        padding_horizontal = "180px",
        default_bg = "#112446",
        default_color = "#FFFFFF",
        default_link_color = "#FFFFFF",
        default_link_active_color = "#FFFFFF",
        default_link_hover_color = "#A4A4A4"
      )
    )
  ),
  tabPanel("Início",
           fluidRow(
             column(width = 3,
               wellPanel(
                 fileInput("file1", "Buscar arquivo csv", accept = ".csv"),
                )
              ),
             
               column(width = 6, offset = 1,
                      wellPanel(
                        HTML("<h3><center>Tabela com as Respostas</h3><c/enter>"),
                          dataTableOutput("tbRespostas")
                      )
               )
             
           )       
  ),
  navbarMenu("Índices TCT",
   tabPanel("Por Item",
         fluidRow(
           column(width = 2,
              wellPanel(
                
                  h3(" "),
                  downloadButton("dwDescript", label = "Baixar Dados"))
                
              ),
           column(width = 8,
              wellPanel(
                        HTML("<h3><center>Analise Teoria Clássica dos Testes por Item</h3><c/enter>"),
                        dataTableOutput("tbDescript"),offset = 2))
             
           )
  ),
  tabPanel("Por Alternativas",
           fluidRow(
             column(width = 2,
              wellPanel(
                    h3(" "),
                    downloadButton("dwTctAlt", label = "Baixar Dados"))
                  ),
             column(width = 8,
                    wellPanel(
                      HTML("<center><h3>Analise Teoria Clássica dos Testes por Alternativas</h3></center>"),
                      dataTableOutput("tbAlternativas"),offset = 3))
             
           )
           
  )),
  tabPanel("Análise por questão",
           sidebarLayout(
             
             sidebarPanel(
               
               selectInput("slQuestao", "Questão:", 
                           choices = questoes, selected = 1),
               HTML("<center> Estatísticas do Item"),
               tableOutput("tbFiltroItem"),
               HTML("<center> Estatísticas das Alternativas"),
               tableOutput("tbFiltroAlternativas"),
               
               br(),
               HTML('<p align="justify"> <strong> Bisserial: </strong>Alternativas erradas devem ter coeficiente bisserial negativo enquanto a alternativa correta deve ter o coeficiente positivo e, preferencialmente acima de 0,30.<br> Alternativas erradas com coeficiente bisserial positivo indicam que alunos com bom desempenho no teste estão escolhendo aquela alternativa, o que pode indicar um erro induzido, ou seja, uma pegadinha.</p>')
               
               
             ),
             
             mainPanel(
               column(10,
                   HTML("<H3><center>Proporção de Alternativa por número de acertos</center></h3>"),    
                   plotOutput("gfAlternativas")
                        )
               
             )
               
             )
  )
           )      
           

           