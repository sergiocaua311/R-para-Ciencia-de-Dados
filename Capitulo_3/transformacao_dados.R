library(tidyverse)
library(dados)

dados::voos

#Função para visualizar as colunas do tibbles
glimpse(voos)

#summarize(
#  group_by(
#    filter(voos, destino == "IAH"),
#    ano, mes, dia
#  ),
#  atraso_chegada = mean(atraso_chegada, na.rm = TRUE)
#)

voos |> 
  filter(destino == 'IAH') |>
  group_by(ano, mes, dia) |>
  summarize(
    atraso_chegada = mean(atraso_chegada, na.rm = TRUE)
  )
