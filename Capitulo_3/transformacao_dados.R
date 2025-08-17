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

#Sem o pipe, esse parâmetro está em minutos de atraso
filter(voos, atraso_saida > 100)

#Com o pipe
voos |>
  filter(atraso_saida < 120)

#Usando operadores & e |

voos|>
  filter(atraso_chegada > 5 & atraso_chegada < 10)

#Outra forma de analisar e cpmbinar filtros é com %in%

voos|>
  filter(mes %in% c(2))

fevereiro <- voos |>
  filter(mes == 2)

fevereiro

#Funções de ordenação


