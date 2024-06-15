#Librerias

library(ggplot2)
library(gridExtra)
# Cargar el paquete 'car' necesario para la funcion leveneTest
library(car)
#datos del contenido GC de los promotores bidereccionales de Levadura, Micelio y los normales o aleatorios en el genoma de Mucor lusitanicus.
data_len_dim <- df_distribucion_longitudes

#Imprimer los datos
print(data_len_dim)

#Comprobacion de la normalidad

# Prueba de Shapiro-Wilk por tipo
shapiro_test <- by(data_len_dim$longitud, data_len_dim$Tipo, shapiro.test)
shapiro_results <- data.frame(Tipo = names(shapiro_test), p_value = sapply(shapiro_test, "[[", "p.value"))

print(shapiro_results)

# Prueba de Levene para igualdad de varianzas entre 'Levadura' y 'Micelio'
levene_test <- leveneTest(longitud ~ Tipo, data = data_len_dim)

#Dado que los datos de Levadura no siguen una distribución normal según la prueba de Shapiro-Wilk, sería más apropiado utilizar pruebas no paramétricas para comparar las longitudes entre Levadura y Micelio. Una alternativa sería la prueba de Wilcoxon-Mann-Whitney

# Imprimir los resultados
print(levene_test)

#En este caso, el valor p obtenido es 0.6933, lo cual indica que no hay suficiente evidencia para rechazar H0.
#Esto significa que no podemos concluir que las varianzas de las longitudes sean diferentes entre Levadura y Micelio.

# Realizar la prueba de Wilcoxon-Mann-Whitney (U de Mann-Whitney)
wilcox_test <- wilcox.test(longitud ~ Tipo, data = data_len_dim)

# Imprimir los resultados de la prueba
print(wilcox_test)


#Valor p (p-value): Este valor p es mayor que el nivel de significancia común de 0.05.
#No hay suficiente evidencia para rechazar la hipótesis nula de que no hay diferencia en la mediana de las longitudes entre los grupos Levadura y Micelio.


#En este caso, el valor p obtenido es 0.6443, lo cual indica que no hay suficiente evidencia para rechazar H0.
#Esto significa que no podemos concluir que haya una diferencia significativa en las medianas de las longitudes entre Levadura y Micelio.