#!/bin/sh
#!/usr/pkg/bin/bash


if [ "$#" -lt 2 ]; then
    echo "Uso: $0 '<frecuencia>' '<comando>'"
    echo "Ejemplo: $0 '* * * * *' '/ruta/script.sh'"
    exit 1
fi

FRECUENCIA="$1"
COMANDO="$2"

( crontab -l 2>/dev/null; echo "$FRECUENCIA $COMANDO" ) | crontab -

echo "Tarea programada con éxito: $FRECUENCIA $COMANDO"
