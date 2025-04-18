#!/bin/bash

echo "== Configuración de creación de script de red =="
read -p "Ruta para guardar los logs [/var/log]: " logdir
logdir=${logdir:-/var/log}

echo "--- Configuración para red de la Universidad ---"
read -p "IP estática (Universidad): " uni_ip
read -p "Gateway (Universidad) [10.2.65.1]: " uni_gw
uni_gw=${uni_gw:-10.2.65.1}
read -p "Máscara de red (Universidad) [255.255.0.0]: " uni_mask
uni_mask=${uni_mask:-255.255.0.0}
read -p "Dominio (Universidad) [is.escuelaing.edu.co]: " uni_domain
uni_domain=${uni_domain:-is.escuelaing.edu.co}

echo "--- DNS para Universidad ---"
read -p "¿Cuántos servidores DNS querés configurar para la universidad? " uni_dns_count
uni_dns_list=()
for ((i = 1; i <= uni_dns_count; i++)); do
  read -p "DNS #$i (Universidad): " dns
  uni_dns_list+=("$dns")
done

echo "--- Configuración para red Externa (Casa, etc.) ---"
read -p "IP estática (Externa): " ext_ip
read -p "Gateway (Externa): " ext_gw
read -p "Máscara de red (Externa) [255.255.255.0]: " ext_mask
ext_mask=${ext_mask:-255.255.255.0}
read -p "Dominio (Externa) [localhost]: " ext_domain
ext_domain=${ext_domain:-localhost}

echo "--- DNS para Red Externa ---"
read -p "¿Cuántos servidores DNS querés configurar para la red externa? " ext_dns_count
ext_dns_list=()
for ((i = 1; i <= ext_dns_count; i++)); do
  read -p "DNS #$i (Externa): " dns
  ext_dns_list+=("$dns")
done

read -p "Nombre de host (hostname) [SLACKWARE]: " hostname_val
hostname_val=${hostname_val:-SLACKWARE}

read -p "Nombre de la interfaz de red activa [eth0]: " iface
iface=${iface:-eth0}

echo "Generando script de red /etc/rc.d/configNet.sh ..."
sleep 1

cat > /etc/rc.d/configNet.sh << EOF
#!/bin/sh

IFACE="$iface"
LOGDIR="$logdir"
LOGFILE="\$LOGDIR/logip-\$(date +%Y%m%d).log"

mkdir -p "\$LOGDIR"

ifconfig \$IFACE up

# Testear conectividad a la universidad
ping -c 1 -W 1 $uni_gw > /dev/null 2>&1

if [ \$? -eq 0 ]; then
    NET="Universidad"
    IP="$uni_ip"
    GW="$uni_gw"
    MASK="$uni_mask"
    DOMAIN="$uni_domain"
    DNS_LIST="${uni_dns_list[*]}"
else
    NET="Externa"
    IP="$ext_ip"
    GW="$ext_gw"
    MASK="$ext_mask"
    DOMAIN="$ext_domain"
    DNS_LIST="${ext_dns_list[*]}"
fi

# Configuración de red
ifconfig \$IFACE inet \$IP netmask \$MASK up
route del default 2>/dev/null
route add default gw \$GW

# Configuración DNS
echo "" > /etc/resolv.conf
for dns in \$DNS_LIST; do
  echo "nameserver \$dns" >> /etc/resolv.conf
done
echo "" >> /etc/resolv.conf
echo "domain \$DOMAIN" >> /etc/resolv.conf

# Configurar el hostname
hostname "$hostname_val"

# Log de la configuración
echo "\$(date '+%Y-%m-%d %H:%M:%S') | Red: \$NET | IP: \$IP | Gateway: \$GW | Hostname: \$(hostname)" >> "\$LOGFILE"

# Notificación gráfica si existe
if command -v notify-send >/dev/null 2>&1; then
    notify-send "Configuración de Red" "Red configurada: \$NET (\$IP)"
fi
EOF

chmod +x /etc/rc.d/configNet.sh

echo "Generando script de servicio /etc/rc.d/rc.configNet ..."
sleep 1

cat > /etc/rc.d/rc.configNet << 'EOF'
#!/bin/sh
# Servicio para configurar la red en Slackware

case "$1" in
  start)
    echo "Iniciando configuración de red..."
    sh /etc/rc.d/configNet.sh
    ;;
  restart)
    echo "Reiniciando configuración de red..."
    sh /etc/rc.d/configNet.sh
    ;;
  stop)
    echo "Este script de red no soporta stop. No se hace nada."
    ;;
  *)
    echo "Uso: $0 {start|restart|stop}"
    exit 1
    ;;
esac

exit 0
EOF

chmod +x /etc/rc.d/rc.configNet

if ! grep -q "/etc/rc.d/rc.configNet start" /etc/rc.d/rc.local 2>/dev/null; then
    echo "sh /etc/rc.d/rc.configNet start" >> /etc/rc.d/rc.local
    chmod +x /etc/rc.d/rc.local
    echo "Script agregado a rc.local para ejecución automática."
else
    echo "Ya existía en rc.local, no se agregó de nuevo."
fi

echo "Todo listo para Slackware."
echo "Recordá que podés usar:"
echo "  /etc/rc.d/rc.configNet start"
echo "  /etc/rc.d/rc.configNet restart"
