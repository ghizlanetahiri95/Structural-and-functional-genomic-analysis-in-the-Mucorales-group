#Librarias

library(ggplot2)
library(gridExtra)

#cargar los datos

data_conser <- Datos_conservacion_Lev_Mic_Dim

print(data_conser)

# Realizar las pruebas de Wilcoxon
wilcox_levadura <- wilcox.test(Levadura ~ Dimorfico, data = data_conser)
wilcox_micelio <- wilcox.test(Micelio ~ Dimorfico, data = data_conser)
wilcox_dim <- wilcox.test(Dim ~ Dimorfico, data = data_conser)

# Imprimir los resultados
print(wilcox_levadura)
print(wilcox_micelio)
print(wilcox_dim)

# Definir una paleta de colores personalizada
color_palette <- c("#FF9999", "#66B2FF")  # Colores para FALSE y TRUE respectivamente

# Crear los gráficos de boxplot
p1 <- ggplot(data_conser, aes(x = as.factor(Dimorfico), y = Levadura, fill = factor(Dimorfico))) +
  geom_boxplot() +
  scale_fill_manual(values = color_palette) +
  labs(title = "Levadura", x = "Dimórfico", y = "Levadura") +
  theme_minimal()

p2 <- ggplot(data_conser, aes(x = as.factor(Dimorfico), y = Micelio, fill = factor(Dimorfico))) +
  geom_boxplot() +
  scale_fill_manual(values = color_palette) +
  labs(title = "Micelio", x = "Dimórfico", y = "Micelio") +
  theme_minimal()

p3 <- ggplot(data_conser, aes(x = as.factor(Dimorfico), y = Dim, fill = factor(Dimorfico))) +
  geom_boxplot() +
  scale_fill_manual(values = color_palette) +
  labs(title = "Dim", x = "Dimórfico", y = "Dim") +
  theme_minimal()

# Mostrar los gráficos en una cuadrícula
grid.arrange(p1, p2, p3, ncol = 2)



