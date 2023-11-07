###########################  Carregar Pacotes ##################################

library(shiny)
library(ltm)
library(fresh)
library(shinyWidgets)
library(htmltools)
library(tidyverse)

source("../model/funcoes.R")
source("ui.R")
source("server.R")

###########################  Definir Variáveis ################################# 


questoes <- 1:20
areas <- c("Linguagem", "Matemática")

teste <- read.csv2("C:\\trieduc\\bd\\TCT\\tct_sesi.csv") |> select(-InstrumentoId)

data(LSAT)

matriz <- LSAT



###########################  Rodar Aplicacao ################################### 

shinyApp(ui = ui, server = server)
