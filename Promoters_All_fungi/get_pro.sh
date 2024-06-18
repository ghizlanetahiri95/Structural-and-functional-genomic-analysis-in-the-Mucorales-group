#!/bin/bash

# Directorio actual
DIRECTORIO=$(pwd)

# Encontrar archivos BED y FASTA
ARCHIVOS_BED=$(find $DIRECTORIO -name '*_promoters*.txt')
ARCHIVOS_FASTA=$(find $DIRECTORIO -name '*.fasta')

# Imprimir los archivos encontrados
echo "Archivos BED encontrados:"
echo "$ARCHIVOS_BED"
echo "Archivos FASTA encontrados:"
echo "$ARCHIVOS_FASTA"

# Iterar sobre los archivos BED
for BED in $ARCHIVOS_BED; do
    # Extraer el nombre base del archivo BED (antes del primer guion bajo)
    NOMBRE_BASE=$(basename $BED | awk -F_ '{print $1}')
    echo "Procesando $NOMBRE_BASE..."

    # Buscar el archivo FASTA correspondiente
    FASTA=$(find $DIRECTORIO -name "${NOMBRE_BASE}*.fasta")
    echo "Archivo FASTA correspondiente: $FASTA"

    # Verificar si se encontró el archivo FASTA
    if [ -f "$FASTA" ]; then
        # Definir el archivo de salida
        SALIDA="${DIRECTORIO}/${NOMBRE_BASE}_promoters_seq.txt"

        # Ejecutar bedtools getfasta
        bedtools getfasta -fi $FASTA -bed $BED -fo $SALIDA
        echo "Se ejecutó bedtools getfasta con éxito para $NOMBRE_BASE"
    else
        echo "No se encontró el archivo FASTA correspondiente para $BED"
    fi
done

