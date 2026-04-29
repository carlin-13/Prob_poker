
#utilizo o package manager pra puxar os pacotes atraves da função pacman::p_load()

if(!require("pacman")) install.packages("pacman")
library(pacman)

p_load(dplyr,    # manipulação de dados
       ggplot2,  # para gráficos
       ggpubr    # para unir os gráficos no final(ggarrange)
)

# Total de mãos possíveis (combinação de 52 cartas, 5 a 5)  - numero total que tá na citação do Polesi
total_maos_possiveis <- 2598960

# 1) Crio a base de dados com as mãos e suas combinações exatas
base_probabilidades <- data.frame(
  Mao = c("Royal Flush", "Straight Flush", "Quadra", "Full House", "Flush",
          "Sequência", "Trinca", "Dois Pares", "Um Par", "Carta Alta"),
  #cada combinação é feita a partir formula padrão mesmo, eu peguei já do arquivo pra facilitar
  Combinacoes = c(4, 36, 624, 3744, 5108, 10200, 54912, 123552, 1098240, 1302540)
)

# 2) Faço o cálculo das probabilidades usando dplyr
tabela_final <- base_probabilidades %>%
  mutate(
    Probabilidade_Pct = (Combinacoes / total_maos_possiveis) * 100
  ) %>%
  arrange(Combinacoes)

# 3) Faço dois gráficos para separar as mãos raras das comuns

#Aqui eu utilizo o pacote ggplot para a configuração estética do gráfico em si e o que vai aparecer e como...

grafico_raras <- ggplot(tabela_final %>% head(5), aes(x = reorder(Mao, Probabilidade_Pct), y = Probabilidade_Pct, fill = Probabilidade_Pct)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = sprintf("%.5f%%", Probabilidade_Pct)), hjust = -0.1, size = 3.5) +
  scale_fill_gradient(low = "#FF0000", high = "#00FF00") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.4))) +
  coord_flip() +
  labs(title = "As 5 Mãos Mais Raras", x = "", y = "Probabilidade (%)") +
  theme_minimal() + 
    theme(axis.text.y = element_text(face = "bold", size = 11), 
          axis.title.x = element_text(face = "bold"))

grafico_comuns <- ggplot(tabela_final %>% tail(5), aes(x = reorder(Mao, Probabilidade_Pct), y = Probabilidade_Pct, fill = Probabilidade_Pct)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = sprintf("%.2f%%", Probabilidade_Pct)), hjust = -0.1, size = 3.5) +
  scale_fill_gradient(low = "#FF0000", high = "#00FF00") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.2))) +
  coord_flip() +
  labs(title = "As 5 Mãos Mais Comuns", x = "", y = "Probabilidade (%)") +
  theme_minimal() + 
  theme(axis.text.y = element_text(face = "bold", size = 11),  
        axis.title.x = element_text(face = "bold"))

# 4) Vejo o comparativo geral
#Aqui essa função junta os dois gráficos e os mostra 
ggarrange(grafico_raras, grafico_comuns, ncol = 1, nrow = 2)
