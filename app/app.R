###########################  Carregar Pacotes ##################################

library(shiny)
library(ltm)

###########################  Definir Variáveis ################################# 


questoes <- 1:20
areas <- c("Linguagem", "Matemática")

data(LSAT)
lsat.desc<-descript(LSAT)


###########################  Interface Usuario ################################# 

ui <- navbarPage("Unicesumar - TCC",
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
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white',
         xlab = 'Waiting time to next eruption (in mins)',
         main = 'Histogram of waiting times')
    
  })
  
  output$tbMatriz <- renderTable(LSAT)
  output$tbDescript <- renderTable(lsat.desc$bisCorr)
  
}



###########################  Rodar Aplicacao ################################### 

shinyApp(ui = ui, server = server)
