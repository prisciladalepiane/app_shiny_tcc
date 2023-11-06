###########################  Carregar Pacotes ##################################

library(shiny)
library(ltm)

###########################  Definir Variáveis ################################# 


questoes <- 1:20
areas <- c("Linguagem", "Matemática")


###########################  Interface Usuario ################################# 

navbarPage("Unicesumar - TCC",
           tabPanel("Component 1",
                    sidebarLayout(
                      
                      sidebarPanel(
                        
                        wellPanel(
                          selectInput("selArea", "Selecione a área:", areas)
                        )
                        
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          tabPanel("1", plotOutput("distPlot")),
                          tabPanel("2", plotOutput("distPlot")),
                          tabPanel("3", plotOutput("distPlot"))
                        )
                      )
                      
                    )
                    
                    
           ),
           tabPanel("Índices TCT",
                    plotOutput("distPlot")
                    
           ),
           tabPanel("Análise por questão",
                    plotOutput("distPlot")
                    
           ),
           navbarMenu("More",
                      tabPanel("Sub-Component A"),
                      tabPanel("Sub-Component B"))
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
  
}



###########################  Rodar Aplicacao ################################### 

shinyApp(ui = ui, server = server)
