#!/bin/bash

# Verificar si se proporcionan los argumentos esperados
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <archivo_todas_las_secuencias.fasta> <archivo_lista_ids.txt>"
    exit 1
fi

# Asignar los nombres de los archivos a las variables correspondientes
archivo_todas_las_secuencias="$1"
archivo_lista_ids="$2"

# Verificar si los archivos existen
if [ ! -f "$archivo_todas_las_secuencias" ]; then
    echo "El archivo $archivo_todas_las_secuencias no existe."
    exit 1
fi

if [ ! -f "$archivo_lista_ids" ]; then
    echo "El archivo $archivo_lista_ids no existe."
    exit 1
fi

# Función para obtener la secuencia correspondiente a un ID
obtener_secuencia() {
    local id="$1"
    awk -v id="$id" -v RS='>' '$1 == id {print ">" $0}' "$archivo_todas_las_secuencias"
}

# Iterar sobre cada ID en la lista y obtener la secuencia correspondiente
while IFS= read -r id; do
    obtener_secuencia "$id"
done < "$archivo_lista_ids"


