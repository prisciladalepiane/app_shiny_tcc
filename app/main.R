###########################  Carregar Pacotes ##################################

if(!require("shiny")){install.packages("shiny")}
if(!require("ltm")){install.packages("ltm")}
if(!require("fresh")){install.packages("fresh")}
if(!require("shinyWidgets")){install.packages("shinyWidgets")}
if(!require("htmltools")){install.packages("htmltools")}
if(!require("tidyverse")){install.packages("tidyverse")}
if(!require("DT")){install.packages("DT")}

# Para testes
# setwd("./app")

source("funcoes.R")

###########################  Definir Variáveis ################################# 

teste <- read.csv2("dados/respostas_teste.csv")
gabarito_teste <- read.csv2("dados/gabarito_teste.csv")


###########################  Rodar Aplicacao ################################### 

source("server.R")
source("ui.R")

shinyApp(ui = ui, server = server)

