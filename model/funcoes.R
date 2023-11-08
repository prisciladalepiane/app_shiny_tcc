
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
      dplyr::select(RespondenteId, CodigoQuestao, Ordem) %>% 
      spread(key = CodigoQuestao, value =  Ordem, fill = NA) 
    
  } else {
    
    matriz <- respostas %>% 
      mutate(Acerto = as.integer(Acerto)) %>% 
      dplyr::select(RespondenteId, CodigoQuestao, Acerto) %>% 
      spread(CodigoQuestao, Acerto, fill = fill ) 
    
  }
  
  return(matriz)
}



