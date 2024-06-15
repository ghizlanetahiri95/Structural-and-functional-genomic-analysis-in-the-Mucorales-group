#Librerias

library(ggplot2)
library(gridExtra)
#datos del contenido GC de los promotores bidereccionales de Levadura, Micelio y los normales o aleatorios en el genoma de Mucor lusitanicus.
data_gc_dim <- df_gc_total

#Imprimer los datos
print(data_gc_dim)


# Realizar el ANOVA
modelo_anova <- aov(GC_Content ~ Tipo, data = data_gc_dim)

# Resumen del ANOVA
summary(modelo_anova)

