###########################  Interface Usuario ################################# 


ui <- navbarPage(
  
  title = "Unicesumar",
  
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
           
           
           sidebarPanel(
             # selectInput("selArea", "Selecione a área:", areas)
             
           ),
           
           mainPanel(
             h3("Teoria Cássica dos Testes"),
             
             tableOutput("tbDescript")
           )         
           
           
  ),
  tabPanel("Análise por questão"
           
  )
  
)
