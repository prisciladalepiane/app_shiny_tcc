###########################  Carregar Pacotes ##################################

library(shiny)
library(ltm)
library(fresh)
library(shinyWidgets)
library(htmltools)
library(tidyverse)
library(DT)


source("./model/funcoes.R")

###########################  Definir Variáveis ################################# 

teste <- read.csv2("C:/tcc2_eng/respostas_teste.csv")
gabarito <- read.csv2("C:/tcc2_eng/gabarito_teste.csv")

respostas <- teste |> mutate(CodigoQuestao = str_sub(CodigoQuestao,1,3))
gabarito <- gabarito |> mutate(Item = str_sub(Item,1,3))

questoes <- gabarito$Item

matriz <- respostasParaMatriz(respostas) 

matriz_alternativas <- respostasParaMatriz(respostas, alternativas = T)

tct_alt <- calculoTctAlternativas(matriz_alternativas, gabarito)

tct_alternativas <- formatarTctAlternativas(tct_alt)

acertos <- matriz |> select(RespondenteId) |> mutate(Acertos = rowSums(matriz[,-1]))

grafico_alt <- respostas |> left_join(acertos) |>
  group_by(Acertos,CodigoQuestao,AlternativaOrdem) |> 
  count() |>
  mutate(Alternativa = LETTERS[AlternativaOrdem]) 


###########################  Rodar Aplicacao ################################### 

source("server.R")
source("ui.R")
# source("app/server.R")
# source("app/ui.R")

shinyApp(ui = ui, server = server)

