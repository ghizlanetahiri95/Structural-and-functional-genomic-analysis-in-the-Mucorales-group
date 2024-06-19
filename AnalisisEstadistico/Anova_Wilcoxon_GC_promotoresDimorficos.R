#Librerias

library(ggplot2)
library(gridExtra)

# Cargar el paquete necesario para ANOVA (si no está cargado)
# install.packages("car")  # Instalar si aún no está instalado
library(car)
#datos del contenido GC de los promotores bidereccionales de Levadura, Micelio y los normales o aleatorios en el genoma de Mucor lusitanicus.
data_gc_dim <- df_gc_total

#Imprimer los datos
print(data_gc_dim)


# Realizar el ANOVA
modelo_anova <- aov(GC_Content ~ Tipo, data = data_gc_dim)

# Resumen del ANOVA
summary(modelo_anova)


#Prueba de la normalidad 

#Verificacion de la normalidad de los residuos

# Obtener los residuos del modelo ANOVA
residuos <- residuals(modelo_anova)

# Gráfico QQ-plot de los residuos
qqnorm(residuos)
qqline(residuos)

# Histograma de los residuos
hist(residuos, breaks = 20, main = "Histograma de Residuos")

# Prueba de Shapiro-Wilk para normalidad de los residuos
shapiro.test(residuos) # Se rechaza la H0 de que la muestra proviene de una pobalción normalmente distribuida.

# Prueba de Levene para homogeneidad de varianzas
levene_test <- leveneTest(GC_Content ~ Tipo, data = data_gc_dim)
print(levene_test)
# P valor superior a 0.0, no se rechaza la H0, hay igualdad de varianzas. 

# Realizar la prueba de Kruskal-Wallis
resultado_kruskal <- kruskal.test(GC_Content ~ Tipo, data = data_gc_dim)

# Imprimir los resultados
print(resultado_kruskal)

# el p-valor es superior a 0.05. No se rechaza la H0. No hay diferencias significativas entre las medias del contenido GC.