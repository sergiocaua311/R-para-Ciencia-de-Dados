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

voos |>
  arrange(ano,mes, dia, horario_saida) #Ordem crescente, primeiro ano, depois mes ..

voos|>
  arrange(desc(atraso_saida))|>
  View()
  
#Remover linhas duplicadas
  
voos |>
  distinct()

#Para encontrar pares únicos de origens e destinos

voos |>
  distinct(origem, destino)

#Para exibir as outras colunas depois da filtragem
voos |>
  distinct(origem, destino, .keep_all = TRUE)

voos |>
  count(origem, destino, sort = TRUE)

#Alguns exercícios para praticar

voos  |>
  filter(atraso_chegada >=120) |># atraso está em minutos 
  view()

voos |>
  filter(destino == "IAH" | destino == "HOU") |>
  View()

#Foi operado pela United, American ou Delta

voos |>
  filter(companhia_aerea == "AA" | companhia_aerea == "UA" | companhia_aerea == "DL") |>
  view()

#Decolou no verão

voos |>
  filter(mes == 7 | mes == 8 | mes == 9) |>
  View()

#Chegou com mais de duas horas de atraso, mas não teve atraso na decolagem

voos |>
  filter(atraso_saida <= 0 & atraso_chegada > 120) |>
  View()

#Atrasou pelo menos uma hora, mas recuperou mais de 30 minutos em vôo

voos |>
  filter(atraso_saida >= 60 & (atraso_saida - atraso_chegada) > 30)|>
  View()
  
#Estudando as funções que modificam colunas

voos |>
  mutate(
    tempo_ganho = atraso_saida - atraso_chegada,
    velocidade = distancia / tempo_voo * 60,
    .before = 1 #Serve para criar a coluna a esquerda do tibble
    #Essa função .before pode criar colunas antes de variáveis do tibble
  )

voos |>
  mutate(
    tempo_ganho = atraso_saida - atraso_chegada,
    velocidade = distancia / tempo_voo * 60,
    horas = tempo_voo / 60,
    tempo_ganho_por_hora = tempo_ganho / horas,
    .keep = "used" #Mantém apenas as colunas usadas na função mutate
  )|>
  View()

#Como eu adiciono as novas colunas ao meu tibble?
voos <- voos |>
  mutate(
    tempo_ganho = atraso_saida - atraso_chegada,
    velocidade = distancia / tempo_voo * 60,
    horas = tempo_voo / 60,
    tempo_ganho_por_hora = tempo_ganho / horas,
  )

#Visualizando as colunas do tibble
colnames(voos)


#Selecionando colunas em específico
voos |>
  select(ano,mes, dia)

voos |>
  select(ano:dia) #Seleciona todas as colunas entre ano e dia

voos|>
  select(!ano:dia) #Seleciona as colunas que não estão entre ano e dia

#Para selecionar todas as colunas que são numéricas
voos|>
  select(where(is.numeric))

?select

voos|>
  select(tail_num = cauda) #Isso não altera o nome da coluna em voos

#Para alterar o nome das colunas
voos <-voos|>
  rename(id_cauda = cauda)
 

view(voos)

#Para realocar colunas de lugar
voos|>
  relocate(data_hora, tempo_voo, .after = origem)|>
  view()


#group_by()
voos |> 
  group_by(mes) |> 
  summarize(
    atraso = mean(atraso_saida, na.rm = TRUE), #Retorna a média do atraso_saída agrupado por mês
    n = n() #Conta quantas linhas tem
  )


voos |> 
  group_by(destino) |> 
  slice_max(atraso_chegada, n=1,with_ties = FALSE) |> #with_ties para repetir linhas empatadas
  relocate(destino) #Serve para puxar a coluna para frente do tibble


por_dia <- voos |> 
  group_by(dia, mes, ano)
por_dia

voos_diarios <- por_dia |> 
  summarize(n = n(),
            .groups = "drop_last")
voos_diarios

#ungrup()
por_dia |> 
  ungroup() 

por_dia |> 
  ungroup() |> 
  summarize(
    atraso_medio = mean(atraso_saida, na.rm = TRUE),
    voos = n()
  )

#.by
voos |> 
  summarize(
    atraso = mean(atraso_saida, na.rm = TRUE),
    n = n(),
    .by = c(dia,mes)
  )


df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)

df|>
  group_by(y)


##arrange ordena as linhas 
df|> 
  arrange(z)

## Os dois abaixo faz a mesma coisa
summarize(group_by(df,y),mean_x = mean(x))

df |>
  group_by(y) |>
  summarize(mean_x = mean(x))



























