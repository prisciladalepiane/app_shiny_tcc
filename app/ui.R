

navbarPage("Análises ",
           tabPanel("Component 1",
                       sidebarLayout(

                         sidebarPanel(

                            wellPanel(
                              selectInput("selQuestao", "Selecione uma questão:", 1:20)
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
           tabPanel("Component 2",
                    plotOutput("distPlot")
                    
                    ),
           navbarMenu("More",
                      tabPanel("Sub-Component A"),
                      tabPanel("Sub-Component B"))
)
