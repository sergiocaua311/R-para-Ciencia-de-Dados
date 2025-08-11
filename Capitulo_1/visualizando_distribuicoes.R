library(tidyverse)
library(dados)
library(ggthemes)

# Carregar os dados
dados::pinguins

# Variável Categorica 
# Plota o gráfico sem estar ordenado
ggplot(pinguins, aes(x = especie))+
  geom_bar()

#Plota o gráfico ordenado
ggplot(pinguins, aes(x= fct_infreq(especie)))+
  geom_bar()

#O parâmetro binwith se refere ao intervalo no eixo X do histograma.
ggplot(pinguins, aes(x = massa_corporal)) +
  geom_histogram(binwidth = 250, na.rm = TRUE)

#Vendo a função que estima a densidade:

ggplot(pinguins, aes(x = massa_corporal)) +
  geom_density(na.rm = TRUE)


# Faça um gráfico de barras de especie de pinguins, no qual você atribui especie 
# ao atributo estético y. 
# Como esse gráfico é diferente?

ggplot(pinguins, aes(y = especie)) +
  geom_bar(na.rm = TRUE, color = "black",fill = "gray")

# O que o argumento bins em geom_histogram() faz?

ggplot(pinguins, aes(x = profundidade_bico)) + 
  geom_histogram(bins = 50)

# bins é a quantidade de intervalos que meu histograma terá.


# Testando com outro conjunto de dados.

dados::diamante


ggplot(diamante, aes(x = quilate)) +
  geom_histogram(na.rm = TRUE, binwidth = 0.1)

# Box plot
ggplot(pinguins, aes(x = especie, y= massa_corporal))+
  geom_boxplot()

ggplot(pinguins, aes(x = massa_corporal,color = especie, fill = especie))+
  geom_density(linewidth = 0.75, na.rm = TRUE, alpha = 0.5)

# Duas variáveis categóricas 

ggplot(pinguins, aes(x = ilha, fill = especie))+
  geom_bar()

ggplot(pinguins, aes(x = ilha, fill = especie)) + 
  geom_bar(position = "fill")

# Duas variáveis numéricas

ggplot(pinguins, aes( x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point(aes(color = especie, shape = especie), na.rm = TRUE) +
  facet_wrap(~ilha)

# Três ou mais variáveis
