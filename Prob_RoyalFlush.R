#Utilizo das próprias funções nativas do R para fazer a questão do cenário do poker
# Definindo as variaveis do baralho 

cartas_baralho <- 52
cartas_mao <- 5

# Calculando a totalidade de combinações possíveis
total_combinacoes <- choose(cartas_baralho, cartas_mao)

# Definindo o número de royal flushes possíveis em que temos 4 naipes somente (ouros,paus,espadas e copas)
royal_flushes_possiveis <- 4

# Calculando a probabilidade de royal flushes
probabilidade_royal_flush <- royal_flushes_possiveis / total_combinacoes

# Transformando em porcentagem 
probabilidade_pct_royal <- probabilidade_royal_flush * 100

#Aqui só pra ver de forma genérica o que resta do total sem ser royal flushes
probabilidade_pct_não_royal <- 1 - probabilidade_pct

#Aqui é só pra mostrar o numero acompanhado da legenda 
cat("Probabilidade de acertar o Royal Straight Flush:", sprintf("%.6f%%", probabilidade_pct), "\n")
cat("Probabilidade de não acertar o Royal Straight Flush", sprintf("%.6f%%", probabilidade_nãopct), "\n")
