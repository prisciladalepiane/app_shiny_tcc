###########################  Interface Usuario ################################# 


ui <- navbarPage(
  
  title = "Unicesumar",
  selected = "Índices TCT",
  
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
           sidebarLayout(
             
             sidebarPanel(
               
               wellPanel(
                 fileInput("file1", "Buscar arquivo csv", accept = ".csv")
               )
               
             ),
             
             mainPanel(
               dataTableOutput("tbRespostas")
               
             )
             
           )       
  ),
  tabPanel("Índices TCT",
           
         fluidRow(
           column(width = 2,
                  h3(" "),
                  downloadButton("dwDescript", label = "Baixar Dados")),
           column(width = 5,
              wellPanel(
                        HTML("<h4><center>Analise Teoria Clássica dos Testes por Item</h4><c/enter>"),
                        dataTableOutput("tbDescript"),offset = 3))
             
           )
           
           
           
  ),
  tabPanel("Análise Alternativas",
           fluidRow(
             column(width = 2,
                    h3(" "),
                    downloadButton("dwTctAlt", label = "Baixar Dados")),
             column(width = 5,
                    wellPanel(
                      HTML("<h4><center>Analise Teoria Clássica dos Testes por Alternativas</h4><c/enter>"),
                      dataTableOutput("tbAlternativas"),offset = 3))
             
           )
           
  ),
  tabPanel("Análise por questão",
           sidebarLayout(
             
             sidebarPanel(
               
               selectInput("slQuestao", "Questão:", 
                           choices = questoes, selected = 1)
               
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
           

           