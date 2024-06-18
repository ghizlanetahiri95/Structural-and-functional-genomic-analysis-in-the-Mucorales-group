#!/bin/bash

# Verificar que se haya proporcionado un directorio como argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 directorio"
    exit 1
fi

# Asignar el directorio proporcionado a una variable
directorio="$1"

# Verificar que el directorio exista
if [ ! -d "$directorio" ]; then
    echo "El directorio $directorio no existe."
    exit 1
fi

# Iterar sobre los archivos en el directorio
for archivo_fasta in "$directorio"/*.fasta*; do
    # Verificar si hay archivos fasta en el directorio
    if [ -e "$archivo_fasta" ]; then
        # Obtener el nombre del organismo del archivo de secuencias
        organismo=$(basename "$archivo_fasta" | cut -d'_' -f1)
        
        # Buscar el archivo de IDs correspondiente
        archivo_ids="${directorio}/${organismo}_gff.txt"
        
        # Verificar si el archivo de IDs existe
        if [ -e "$archivo_ids" ]; then
            # Ejecutar el comando para procesar el organismo
            ./extraer_fasta "$archivo_fasta" "$archivo_ids" > "${organismo}.fa"
            echo "Procesado $organismo"
        else
            echo "No se encontró el archivo de IDs correspondiente para $organismo"
        fi
    fi
done
