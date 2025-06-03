# Aplicativo Shiny para Análise de Provas com TCT

Este projeto apresenta um aplicativo web interativo desenvolvido em R com Shiny para auxiliar na análise de provas por meio da **Teoria Clássica dos Testes (TCT)**. O sistema tem como objetivo facilitar a identificação de questões problemáticas e fornecer métricas que apoiem a revisão pedagógica dos itens avaliativos.

 **Acesse o App:** [AnaliseProvas - shinyapps.io](https://prisciladalepiane.shinyapps.io/AnaliseProvas/)  
 **Código-fonte:** [Repositório no GitHub](https://github.com/prisciladalepiane/app_shiny_tcc)

---

##  Objetivo

Este projeto tem como objetivo o desenvolvimento de um software estatístico voltado para a análise de provas, com foco na Teoria Clássica dos Testes (TCT).
A ferramenta busca automatizar o cálculo de estatísticas psicométricas, como o índice de dificuldade, discriminação, correlação bisserial, entre outros, 
permitindo a identificação rápida e precisa de questões problemáticas, como gabaritos incorretos ou alternativas confusas. 
Além disso, visa oferecer uma interface intuitiva que facilite a visualização dos dados, 
a interpretação dos resultados e a tomada de decisão por parte de professores, coordenadores e avaliadores envolvidos na elaboração e revisão de avaliações.

- Automatizar o cálculo dos principais índices estatísticos utilizados na TCT.
- Facilitar a interpretação pedagógica de cada questão.
- Sinalizar automaticamente questões que possam conter problemas de formulação ou gabarito.

---

##  Funcionalidades

1. **Cálculo de índices por item**
   - Índice de Dificuldade (DIFI)
   - Índice de Dificuldade - Grupo Inferior (ABAI)
   - Índice de Dificuldade - Grupo Superior (ACIM)
   - Discriminação clássica (DISCR)
   - Correlação bisserial (BIS)

2. **Classificação automática dos itens**
   - Com base nos índices de dificuldade e discriminação.

3. **Análise por alternativa**
   - Total e porcentagem de marcações
   - Correlação bisserial e discriminação por alternativa
   - Distribuição por quartis (Q1–Q4)

4. **Visualização individual de questões**
   - Estatísticas e gráficos por item específico

5. **Exportação dos dados**
   - Download das tabelas geradas (.csv)

6. **Sinalização automática de problemas**
   - Itens com bisserial abaixo de 0,2
  
---
## Tecnologias Utilizadas

- **R + Shiny**: Desenvolvimento da aplicação web
- **Tidyverse**: Manipulação e visualização de dados
- **HTML + CSS**: Ajustes visuais e estrutura da interface
- **Hospedagem**: [shinyapps.io](https://www.shinyapps.io)

---

##  Metodologia

O projeto seguiu a metodologia **Scrum**, com duas Sprints:

- **Sprint 1:** Implementação dos índices TCT (concluída)
- **Sprint 2:** Planejada para desenvolvimento de análises baseadas na Teoria de Resposta ao Item (TRI)

---

##  Considerações Finais

Este aplicativo permite uma análise estatística eficaz de provas, oferecendo suporte à tomada de decisão pedagógica. 
Futuramente, o sistema poderá ser expandido com integração a bancos de dados, recursos de TRI e relatórios automatizados.

---


##  Autora

**Priscila Dalepiane**  
Desenvolvedora e estatística formada pela UFMT | Pós-graduanda em Machine Learning e MLOps  
📎 [LinkedIn](https://www.linkedin.com/in/prisciladalepiane) | 🌐 [RPubs](https://rpubs.com/prisciladalepiane)

