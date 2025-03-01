#!/bin/bash

# Función para validar que los argumentos sean correctos
validate_input() {
    if [[ $# -ne 2 ]]; then
        echo "Uso: $0 [cantidad_archivos] [tamaño_máximo]"
        echo "Ejemplo: $0 10 1G"
        exit 1
    fi
    if ! [[ $1 =~ ^[0-9]+$ ]]; then
        echo "Error: La cantidad de archivos debe ser un número entero."
        exit 1
    fi
}

# Función para encontrar los archivos más pequeños dentro del tamaño máximo
find_smallest_files() {
    local no_files=$1
    local max_size=$2
    
    find . -type f -size -$max_size -printf "%s %p\n" 2>/dev/null |
    sort -n |
    head -n $no_files |
    awk '{printf "Tamaño: %d bytes | Archivo: %s\n", $1, $2}'
}

# Inicio del script
validate_input "$@"
echo "Buscando los $1 archivos más pequeños menores a $2..."
find_smallest_files "$1" "$2"
