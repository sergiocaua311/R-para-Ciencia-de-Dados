library(tidyverse)
library(dados)

dados::voos

voos|>
  select(horario_saida,saida_programada, atraso_saida)|>
  view()
