library(tidyverse)
library(dados)

dados::voos

voos|>
  select(horario_saida,saida_programada, atraso_saida)|>
  view()

voos|>
  select(horario_saida, horario_saida, horario_chegada, horario_chegada)

variables <- c("ano", "mes", "dia", "atraso_saida", "atraso_chegada","teste")

voos|>
  select(any_of(variables)) #Exibe as colunas que estão no tibble
  
voos |> select(contains("dia")) #Mostra as tabelas que tem essa sequencia de letras na sua composição
#Não distinguindo MAIÚSCULAS e minúsculas 


voos <-voos|>
  rename("tempo_voo_min" = tempo_voo)

colnames(voos)





