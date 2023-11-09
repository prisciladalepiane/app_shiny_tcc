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


teste <- read.csv2("C:/tcc2_eng/respostas_teste.csv")
gabarito <- read.csv2("C:/tcc2_eng/gabarito_teste.csv")

questoes <- gabarito$Item

matriz <- respostasParaMatriz(teste) %>% select(-RespondenteId)

matriz_alternativas <- respostasParaMatriz(teste, alternativas = T)

tct_alt <- calculoTctAlternativas(matriz_alternativas, gabarito)

tct_alternativas <- tct_alt  |>
  select(Item, correct, key, n, rspP, pBis) %>%  
  mutate_if(is.double, ~round(.,2)) |>
  mutate(rspP = paste0(rspP * 100, "%")) |> distinct() |> 
  gather(key = "Alternativa", value = "Valores", -c(Item, key)) |> 
  spread(key = key, value = Valores) |>
  arrange(Item, factor(Alternativa, levels = c("correct", "n", "rspP", "pBis")))

###########################  Rodar Aplicacao ################################### 

shinyApp(ui = ui, server = server)
