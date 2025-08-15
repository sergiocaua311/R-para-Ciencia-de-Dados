library(tidyverse)
library(dados)
library(ggthemes)

dados::milhas

#Faça um gráfico de dispersão de rodovia em função de cilindrada

ggplot(milhas, aes(x = rodovia, y = cilindrada, color = cilindrada, size = ano, shape = tracao)) + 
  geom_point()

#O que acontece se você mapear uma terceira variável para linewidth

ggplot(milhas, aes(x = rodovia, y = cilindrada, color = cilindrada, linewidth = transmissao)) + 
  geom_point()

# Mapear a mesma variável para linewidth
ggplot(milhas, aes(x = rodovia, y = cilindrada, color = cilindrada, size = ano, shape = tracao)) + 
  geom_point()

dados::pinguins

#Juntando legendas
ggplot(
  data = pinguins,
  mapping = aes(
    x = comprimento_bico, y = profundidade_bico, 
    color = especie, shape = especie
  )
) +
  geom_point(na.rm = TRUE) +
  labs(color = "especie")

#Salvando a última imagem 
ggplot(milhas, aes(x = cidade, y = rodovia)) +
  geom_point()
ggplot(milhas, aes(x = classe)) +
  geom_bar()
ggsave("grafico-milhas.pdf")

#Testando o comportamento da função

meu_grafico_de_barras <- ggplot(milhas, aes(x = classe)) +
  geom_bar()
meu_grafico_de_dispersao <- ggplot(milhas, aes(x = cidade, y = rodovia)) +
  geom_point()

#Agora consigo escolher qual plot quero salvar
ggsave(filename = "milhas-plot.png", plot = meu_grafico_de_barras) 



