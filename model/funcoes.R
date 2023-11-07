
calcularTCT <- function(matriz){
  
  
  difi <- colMeans(matriz[,-1], na.rm = TRUE) %>% as.data.frame()
  names(difi) <- "DIFI"
  difi$CodigoItem <- row.names(difi) 
  rownames(difi) <- NULL
  
  p_acerto <- rowMeans(matriz[,-1]) 
  
  respostas1 <- matriz %>% mutate(p_acerto) %>% 
    filter(p_acerto <= quantile(p_acerto,0.27)) %>% 
    dplyr::select(-p_acerto)
  
  abai <- colMeans(respostas1[,-1], na.rm = TRUE) %>%
    as.data.frame() 
  names(abai) <- "ABAI"
  abai$CodigoItem <- row.names(abai) 
  rownames(abai) <- NULL
  
  respostas2 <- matriz %>% mutate(p_acerto) %>% 
    filter(p_acerto >= quantile(p_acerto,0.73)) %>% 
    dplyr::select(-p_acerto)
  
  acim <- colMeans(respostas2[,-1], na.rm = TRUE) %>%
    as.data.frame() 
  names(acim) <- "ACIM"
  acim$CodigoItem <- row.names(acim) 
  rownames(acim) <- NULL
  
  tct <- ltm::descript(matriz[,-1])
  
  bisCorr <- data.frame(CodigoItem = names(tct$bisCor),  BIS = tct$bisCorr)
  
  tct_questoes <- left_join(difi, abai) %>% 
    left_join(acim) %>%
    dplyr::select(CodigoItem, DIFI, ABAI, ACIM) %>%
    mutate(DISCR = ACIM - ABAI) %>%
    left_join(bisCorr) %>%
    suppressMessages()
  
  
  return(tct_questoes)
  
}