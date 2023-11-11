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

teste <- read.csv2("C:/tcc2_eng/respostas_teste.csv")
gabarito <- read.csv2("C:/tcc2_eng/gabarito_teste.csv")

respostas <- teste |> mutate(CodigoQuestao = str_sub(CodigoQuestao,1,3))
gabarito <- gabarito |> mutate(Item = str_sub(Item,1,3))

questoes <- gabarito$Item

matriz <- respostasParaMatriz(respostas) 

matriz_alternativas <- respostasParaMatriz(respostas, alternativas = T)

tct_alt <- calculoTctAlternativas(matriz_alternativas, gabarito)

tct_alternativas <- tct_alt  |>
  select(Item, correct, key, n, rspP, pBis) %>%  
  mutate_if(is.double, ~round(.,2)) |>
  mutate(rspP = paste0(rspP * 100, "%")) |> distinct() |> 
  gather(key = "Alternativa", value = "Valores", -c(Item, key)) |> 
  spread(key = key, value = Valores) |>
  arrange(Item, factor(Alternativa, levels = c("correct", "n", "rspP", "pBis")))

acertos <- matriz %>% select(RespondenteId) %>% mutate(Acertos = rowSums(matriz[,-1]))

grafico_alt <- respostas |> left_join(acertos) |>
  group_by(Acertos,CodigoQuestao,AlternativaOrdem) |> 
  count() |>
  mutate(AlternativaOrdem = as.character(AlternativaOrdem)) 


###########################  Rodar Aplicacao ################################### 

shinyApp(ui = ui, server = server)
