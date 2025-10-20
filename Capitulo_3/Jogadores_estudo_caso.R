library(tidyverse)
library(dados)
library(ggplot2)

rebatedores <- dados::rebatedores
help("rebatedores")

## Quantos jogadores diferentes tem nos dados ? ##
n_distinct(rebatedores$id_jogador)

melhores_rebatedores <- dados::rebatedores|>
  group_by(id_jogador) |>
    summarize(
      performance = sum(rebatidas_simples, na.rm = TRUE) / sum(vez_bastao, na.rm = TRUE),
      n = sum(vez_bastao, na.rm = TRUE)
      )

## Plotando o gráfico 
melhores_rebatedores|> 
  ggplot(aes(x = n, y = performance)) +
  geom_point(alpha = 1 / 10) + 
  geom_smooth(se = FALSE)

### Os primeiros registros deixam a análise enviesada

## Filtrando com n>200
melhores_rebatedores|> 
  filter(n>200) |>
  ggplot(aes(x = n, y = performance)) +
  geom_point(alpha = 1 / 10) + 
  geom_smooth(se = FALSE)

## Filtrando com n>100
melhores_rebatedores|> 
  filter(n>200) |>
  ggplot(aes(x = n, y = performance)) +
  geom_point(alpha = 1 / 10) + 
  geom_smooth(se = FALSE)

################################################################################
###                     ESTATÍSTICA DOS JOGADORES                            ###
################################################################################

rebatedores |>
    group_by(id_jogador)|>
        summarize(
            media_rebatidas = (sum(rebatidas_simples, na.rm = TRUE) +
                              sum(rebatidas_duplas, na.rm = TRUE) +
                              sum(rebatidas_triplas, na.rm = TRUE) +
                              sum(homerun, na.rm = TRUE))   / 
                              sum(vez_bastao, na.rm = TRUE)
        )
















