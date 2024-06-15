
# Cargar las librerias
library(ggplot2)
library(gridExtra)

# Cargar los datos
datos_gc_otherfungi <- df_contenidoGC_h2h_random_fungi
print(datos_gc_otherfungi)

# Lista de pares de grupos corregida
pares <- list(
  c("Rhimi59", "Rhimi59n"),
  c("Mucci3", "Mucci3n"),
  c("Cunech1", "Cunech1n"),
  c("Hesve2finisherSC", "Hesve2finisherSCn"),
  c("Rhipu1", "Rhipu1n"),
  c("Aspnid1", "Aspnid1n"),
  c("Rhior3", "Rhior3n"),
  c("Phybl2", "Phybl2n"),
  c("Liccor1", "Liccor1n"),
  c("Sakvas1", "Sakvas1n"),
  c("Rhisto1", "Rhisto1n"),
  c("Mucfus1", "Mucfus1n"),
  c("Spoumb1", "Spoumb1n"),
  c("Mucend1", "Mucend1n"),
  c("Mucrac1", "Mucrac1n")
)


# Función para realizar la comparación
perform_comparison <- function(organismo1, organismo2, data) {
  # Subset de los datos para los dos organismos
  grupo1 <- data$GC_Content[data$Organismo == organismo1]
  grupo2 <- data$GC_Content[data$Organismo == organismo2]
  
  # Imprimir mensaje de comparación
  cat("Comparación entre", organismo1, "y", organismo2, ":\n")
  
  # Realizar la prueba correspondiente (prueba de Shapiro-Wilk para normalidad, luego prueba t o U de Mann-Whitney)
  if (shapiro.test(grupo1)$p.value > 0.05 & shapiro.test(grupo2)$p.value > 0.05) {
    # Prueba t (suponiendo varianzas iguales)
    result <- t.test(grupo1, grupo2, var.equal = TRUE)
  } else {
    # Prueba U de Mann-Whitney (prueba no paramétrica)
    result <- wilcox.test(grupo1, grupo2)
  }
  
  # Imprimir el resultado de la prueba
  print(result)
  cat("\n")
}

# Loop a través de cada par en 'pares' y realizar la comparación
for (par in pares) {
  perform_comparison(par[1], par[2], datos_gc_otherfungi)
}










