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
gabarito <- read.csv2("dados/gabarito_teste.csv")

respostas <- teste |> mutate(CodigoQuestao = str_sub(CodigoQuestao,1,3))
gabarito <- gabarito |> mutate(Item = str_sub(Item,1,3))

questoes <- gabarito$Item

matriz <- respostasParaMatriz(respostas) 

matriz_alternativas <- respostasParaMatriz(respostas, alternativas = T)

tct_alt <- calculoTctAlternativas(matriz_alternativas, gabarito) |>
  mutate(key = ifelse(key == 0, "SR", LETTERS[as.numeric(key)]))

tct_alternativas <- formatarTctAlternativas(tct_alt)

acertos <- matriz |> select(RespondenteId) |> mutate(Acertos = rowSums(matriz[,-1]))

grafico_alt <- respostas |> left_join(acertos) |>
  group_by(Acertos,CodigoQuestao,AlternativaOrdem) |> 
  count() |>
  mutate(Alternativa = LETTERS[AlternativaOrdem]) 


###########################  Rodar Aplicacao ################################### 

source("server.R")
source("ui.R")

shinyApp(ui = ui, server = server)

