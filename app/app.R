###########################  Carregar Pacotes ##################################

library(shiny)
library(ltm)
library(fresh)
library(shinyWidgets)
library(htmltools)
library(tidyverse)


###########################  Definir Variáveis ################################# 


questoes <- 1:20
areas <- c("Linguagem", "Matemática")

teste <- read.csv2("C:\\trieduc\\bd\\TCT\\tct_sesi.csv") |> select(-InstrumentoId)


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
                 ),

                 bs_vars_global(
                   grid_columns = 2,
                   grid_gutter_width = "15px"
                 ),
                 output_file = NULL
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
                       checkboxGroupInput("selArea", "Selecione a área:", areas, inline = T)
                       ),
                   
                     fluidRow(column(10, tableOutput("tbDescript"))
                    )         
                    
                    
           ),
           tabPanel("Análise por questão"
                    
           )
           
)

###########################  Server  ###########################################


server <- function(input, output, session) {
  
  output$distPlot <- renderPlot({
    
    plot(iris)
    
  })
  
  output$tbMatriz <- renderTable(LSAT)
  output$tbDescript <- renderTable(teste)
  
  
  output$tbRespostas <- renderDataTable({
    
        arq <- input$file1
        
        if(is.null(arq)){
          return(NULL)
        }
        
        return(read.csv2(arq$datapath))
   })
  
}



###########################  Rodar Aplicacao ################################### 

shinyApp(ui = ui, server = server)
