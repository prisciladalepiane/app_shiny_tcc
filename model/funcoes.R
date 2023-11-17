
calcularTCT <- function(matriz){
  
  
  difi <- colMeans(matriz, na.rm = TRUE) %>% as.data.frame()
  names(difi) <- "DIFI"
  difi$Item <- row.names(difi) 
  rownames(difi) <- NULL
  
  p_acerto <- rowMeans(matriz) 
  
  respostas1 <- matriz %>% mutate(p_acerto) %>% 
    filter(p_acerto <= quantile(p_acerto,0.27)) %>% 
    dplyr::select(-p_acerto)
  
  abai <- colMeans(respostas1, na.rm = TRUE) %>%
    as.data.frame() 
  names(abai) <- "ABAI"
  abai$Item <- row.names(abai) 
  rownames(abai) <- NULL
  
  respostas2 <- matriz %>% mutate(p_acerto) %>% 
    filter(p_acerto >= quantile(p_acerto,0.73)) %>% 
    dplyr::select(-p_acerto)
  
  acim <- colMeans(respostas2, na.rm = TRUE) %>%
    as.data.frame() 
  names(acim) <- "ACIM"
  acim$Item <- row.names(acim) 
  rownames(acim) <- NULL
  
  tct <- ltm::descript(matriz)
  
  bisCorr <- data.frame(Item = names(tct$bisCor),  BIS = tct$bisCorr)
  
  tct_questoes <- left_join(difi, abai) %>% 
    left_join(acim) %>%
    dplyr::select(Item, DIFI, ABAI, ACIM) %>%
    mutate(DISCR = ACIM - ABAI) %>%
    left_join(bisCorr) %>%
    suppressMessages()
  
  
  return(tct_questoes)
  
}


respostasParaMatriz <- function(respostas, alternativas = FALSE, fill = 0){
  
  respostas <- respostas %>% arrange(desc(Acerto)) %>% 
    distinct(RespondenteId, CodigoQuestao, .keep_all = T) 
  
  if(alternativas){
    
    matriz <- respostas %>%
      filter(!Anulado) %>%
      dplyr::select(RespondenteId, CodigoQuestao, AlternativaOrdem) %>% 
      spread(key = CodigoQuestao, value =  AlternativaOrdem, fill = NA) 
    
  } else {
    
    matriz <- respostas %>% 
      mutate(Acerto = as.integer(Acerto)) %>% 
      dplyr::select(RespondenteId, CodigoQuestao, Acerto) %>% 
      spread(CodigoQuestao, Acerto, fill = fill ) 
    
  }
  
  return(matriz)
}

calculoTctAlternativas <- function(m, gab){
  
  analise <- CTT::distractorAnalysis(m |> 
                                       select(gab$Item) %>% 
                                       replace(is.na(.), 0),gab$Gabarito)
  
  fim <- data.frame()
  
  for( i in 1:length(analise)){
    
    fim1 <- analise[[i]] |> as.data.frame() |>
      mutate(Item = names(analise[i])) 
    
    
    fim <- fim |> bind_rows(fim1) 
    
  }
  
  row.names(fim) <- NULL
  
  return(fim |> select(Item, everything()))
}


formatarTctAlternativas <- function(tct_alt) {
  
  retorno <- tct_alt  |>
    select(Item, correct, key, n, rspP, pBis) %>%  
    mutate_if(is.double, ~round(.,2)) |>
    mutate(rspP = paste0(rspP * 100, "%")) |> distinct() |> 
    gather(key = "Alternativa", value = "Valores", -c(Item, key)) |> 
    spread(key = key, value = Valores) |>
    arrange(Item, factor(Alternativa, levels = c("correct", "n", "rspP", "pBis"))) |>
    mutate(Alternativa = recode(Alternativa, 
                                "correct" = "Correta",
                                "n" = "Total",
                                "rspP" = "% ",
                                "pBis" = "Bisserial"))
  
  
    return(retorno)
  
}


classificacaoDificuldade <- function(DIFI){
  case_when(DIFI <= 0.1 ~ "Muito Difícil", 
            DIFI > 0.1 & DIFI <= 0.3 ~ "Difícil", 
            DIFI > 0.3 & DIFI <= 0.7 ~ "Média", 
            DIFI > 0.7 & DIFI <= 0.9 ~ "Fácil", 
            DIFI  > 0.9 ~ "Muito Fácil")
}

classificacaoBisserial <- function(BIS){
  case_when(
    BIS <= 0 ~ "Inapropriado",
    BIS > 0   & BIS <= 0.1 ~ "Inadequado",
    BIS > 0.1 & BIS < 0.2 ~ "Moderado",
    BIS > 0.2 & BIS < 0.3 ~ "Adequado",
    BIS > 0.3 & BIS < 1 ~ "Excelente"
  )
}




