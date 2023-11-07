###########################  Carregar Pacotes ##################################

library(shiny)
library(ltm)
library(fresh)
library(shinyWidgets)
library(htmltools)


###########################  Definir Variáveis ################################# 


questoes <- 1:20
areas <- c("Linguagem", "Matemática")

data(LSAT)
lsat.desc<-descript(LSAT)


###########################  Interface Usuario ################################# 


ui <- navbarPage("Unicesumar",
             header = use_theme(
               create_theme(
                 theme = "default",
                 bs_vars_navbar(
                   padding_horizontal = "15px",
                   default_bg = "#1122BB",
                   default_color = "#FFFFFF",
                   default_link_color = "#FFFFFF",
                   default_link_active_color = "#91FFFF",
                   default_link_hover_color = "#A4A4A4"
                 ),
                 output_file = NULL
               )
             ),

           tabPanel("Início",
                    sidebarLayout(
                      
                      sidebarPanel(
                        
                        wellPanel(
                          selectInput("selArea", "Selecione a área:", areas)
                        )
                        
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          plotOutput("distPlot")

                      )
                      
                    )
                    
                    )       
           ),
           tabPanel("Índices TCT",
                    tableOutput("tbDescript")
                    
           ),
           tabPanel("Análise por questão",
                    plotOutput("distPlot")
                    
           )
           
)

###########################  Server  ###########################################


server <- function(input, output, session) {
  
  output$distPlot <- renderPlot({
    
    plot(iris)
    
  })
  
  output$tbMatriz <- renderTable(LSAT)
  output$tbDescript <- renderTable(lsat.desc$bisCorr)
  
}



###########################  Rodar Aplicacao ################################### 

shinyApp(ui = ui, server = server)
