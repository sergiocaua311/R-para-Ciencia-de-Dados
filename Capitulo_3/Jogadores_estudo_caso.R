library(tidyverse)
library(dados)
library(ggplot2)
library(dplyr)
library(DescTools)


rebatedores <- dados::rebatedores
help("rebatedores")

################################################################################
###                           LIMPEZA DOS DADOS                              ###
################################################################################

## Qual o tipo dos dados?
sapply(rebatedores, class)

#factor é um dado categórico usado no R, internamente é um inteiro

## Quantos jogadores diferentes tem nos dados? 
n_distinct(rebatedores$id_jogador)

## Verificando a quantidade de dados nulos ou não preenchidos
colSums(is.na(rebatedores))

## Analisando a proporção de dados faltantes de cada coluna
(colSums(is.na(rebatedores)) / nrow(rebatedores)) * 100

df_percentuais <- data.frame(
  coluna = names(rebatedores),
  percentual_NA = round((colSums(is.na(rebatedores)) / nrow(rebatedores) * 100),2))|>
  arrange(desc(percentual_NA))

df_percentuais

## Eliminando os que tem mais de 10% faltante
cols_manter <- df_percentuais$coluna[ df_percentuais$percentual_NA <= 10 ]
rebatedores <- rebatedores[,cols_manter]

rebatedores
## Substituindo os dados faltantes pela moda
DescTools::Mode(rebatedores$toque_sacrificio[!is.na(rebatedores$toque_sacrificio)])

(rebatedores$toque_sacrificio[is.na(rebatedores$toque_sacrificio)] 
  <- DescTools::Mode(rebatedores$toque_sacrificio[!is.na(rebatedores$toque_sacrificio)]))

colSums(is.na(rebatedores))

################################################################################
###                     ESTATÍSTICA DOS JOGADORES                            ###
################################################################################

rebatedores |>
    group_by(id_jogador)|>
    filter(vez_bastao > 50)|>
    summarize(
      media_rebatidas = ((sum(rebatidas_simples, na.rm = TRUE) +
                          sum(rebatidas_duplas, na.rm = TRUE) +
                          sum(rebatidas_triplas, na.rm = TRUE) +
                          sum(homerun, na.rm = TRUE))   / 
                          sum(vez_bastao, na.rm = TRUE))
                        )|>
    arrange(desc(media_rebatidas))

rebatedores|>
  group_by(id_jogador)|>
  summarise(anos_jogados =  n_distinct(id_ano))|>
  arrange(desc(anos_jogados)) |>
  filter(anos_jogados > 1)



melhores_rebatedores <- dados::rebatedores|>
  group_by(id_jogador) |>
  summarize(
    performance = sum(rebatidas_simples, na.rm = TRUE) / sum(vez_bastao, na.rm = TRUE),
    n = sum(vez_bastao, na.rm = TRUE)
  )



################################################################################
###                           ANÁLISE DOS DADOS                              ###
################################################################################

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
  



