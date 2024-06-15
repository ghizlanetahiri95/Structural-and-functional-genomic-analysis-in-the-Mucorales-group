#Librerias
# Instalar el paquete si no está instalado
install.packages("dunn.test")
library(ggplot2)
library(gridExtra)


# Cargar el paquete
library(dunn.test)
#datos

data_len_otherfungi <- df_longitudes_IR_fungi

#Imprimer los datos
print(data_len_otherfungi)

# Asegurarse de que 'Organismo' sea un factor
data_len_otherfungi$Organismo <- as.factor(data_len_otherfungi$Organismo)


# Cargar el paquete necesario para ANOVA (si no está cargado)
# install.packages("car")  # Instalar si aún no está instalado
library(car)

# Realizar ANOVA
modelo_anova <- aov(longitud ~ Organismo, data = data_len_otherfungi)

# Resumen del ANOVA
summary(modelo_anova)


#Verificacion de la normalidad de los residuos
# Obtener los residuos del modelo ANOVA
residuos <- residuals(modelo_anova)

# Gráfico QQ-plot de los residuos
qqnorm(residuos)
qqline(residuos)

# Histograma de los residuos
hist(residuos, breaks = 20, main = "Histograma de Residuos")

# Prueba de Shapiro-Wilk para normalidad de los residuos
shapiro.test(residuos) # da error porque el tamaño de la muestra es muy grande 

#Debido al gran tamaño de la muestra se va a considerara la prueba de Kolmogorov-Smirnov.

resultado_ks <- ks.test(residuos, "pnorm", mean = mean(residuos), sd = sd(residuos))

# Imprimir los resultados
print(resultado_ks)

#Este resultado sugiere que los residuos no siguen una distribución normal.

qqnorm(residuos)
qqline(residuos)
#El histograma proporciona una representación visual de la distribución de los residuos. 
#Debe tener una forma aproximadamente simétrica y seguir una distribución similar a la normal.
hist(residuos, breaks = 20, main = "Histograma de Residuos")

#Homogeneidad de varianzas

# Prueba de Levene para homogeneidad de varianzas
levene_test <- leveneTest(longitud ~ Organismo, data = data_len_otherfungi)
print(levene_test)

#Los datos no cumplen con las suposiciones de homogeneidad de varianzas y normalidad de los residuos para realizar un ANOVA paramétrico.

# Se va a considerar utilizar una prueba no paramétrica, esto es, Prueba de Kruskal-Wallis: Para comparar medianas entre más de dos grupos.


# Realizar la prueba de Kruskal-Wallis
resultado_kruskal <- kruskal.test(longitud ~ Organismo, data = data_len_otherfungi)

# Imprimir los resultados
print(resultado_kruskal)
#Pvalor menor que 2.2exp-16
#Rechazo de la hipótesis nula: En base a este resultado, se rechaza la hipótesis nula de que todas las medianas de los grupos son iguales.

#Los datos cumplen con los supuestos necesarios para la Prueba de Kruskal-Wallis (muestras independientes y distribuciones similares).



# Realizar el test de Dunn
dunn_res <- dunn.test(data_len_otherfungi$longitud, g = data_len_otherfungi$Organismo, method = "bonferroni")

# Mostrar los resultados
print(dunn_res)