# Cargar las librerias
library(ggplot2)
library(gridExtra)

# Cargar los datos
datos_islas_otherfungi <- islasCpG_allfungi
print(datos_islas_otherfungi)



# Lista de organismos únicos
organismos <- unique(islasCpG_allfungi$Organismo)

# Lista para almacenar los subconjuntos de datos
lista_datos <- list()

# Llenar la lista con subconjuntos de datos para cada organismo
for (org in organismos) {
  subset_data <- islasCpG_allfungi$CpG_Count[islasCpG_allfungi$Organismo == org]
  lista_datos[[org]] <- subset_data
}

# Lista de pares de grupos
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

# Función para realizar la comparación evitando errores cuando todos los datos son idénticos
perform_comparison <- function(organismo1, organismo2, lista_datos) {
  # Obtener los datos para los dos organismos
  grupo1 <- lista_datos[[organismo1]]
  grupo2 <- lista_datos[[organismo2]]
  
  # Verificar si los datos extraídos son numéricos y no están vacíos
  if (any(!is.numeric(grupo1)) || any(!is.numeric(grupo2)) || length(grupo1) == 0 || length(grupo2) == 0) {
    cat("Los datos para", organismo1, "y/o", organismo2, "no son numéricos o están vacíos.\n")
    return(NULL)
  }
  
  # Imprimir mensaje de comparación
  cat("Comparación entre", organismo1, "y", organismo2, ":\n")
  
  # Verificar si todos los valores son idénticos en grupo1 o grupo2
  if (length(unique(grupo1)) == 1 | length(unique(grupo2)) == 1) {
    cat("Todos los valores en grupo1 o grupo2 son idénticos. No se puede realizar la comparación.\n")
    return(NULL)
  }
  
  # Realizar la prueba correspondiente (prueba t o U de Mann-Whitney)
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

# Realizar comparaciones para todos los pares en 'pares'
for (par in pares) {
  organismo1 <- par[1]
  organismo2 <- par[2]
  perform_comparison(organismo1, organismo2, lista_datos)
}
