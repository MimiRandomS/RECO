#!/bin/sh

echo "== Instalador de Script de Red para NetBSD =="

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
uni_dns_text=""
for i in $(seq 1 $uni_dns_count); do
  read -p "DNS #$i (Universidad): " dns
  uni_dns_text="${uni_dns_text}nameserver $dns\n"
done

echo "--- Configuración para red Externa ---"
read -p "IP estática (Externa): " ext_ip
read -p "Gateway (Externa): " ext_gw
read -p "Máscara de red (Externa) [255.255.255.0]: " ext_mask
ext_mask=${ext_mask:-255.255.255.0}
read -p "Dominio (Externa) [localhost]: " ext_domain
ext_domain=${ext_domain:-localhost}

echo "--- DNS para Red Externa ---"
read -p "¿Cuántos servidores DNS querés configurar para la red externa? " ext_dns_count
ext_dns_text=""
for i in $(seq 1 $ext_dns_count); do
  read -p "DNS #$i (Externa): " dns
  ext_dns_text="${ext_dns_text}nameserver $dns\n"
done

read -p "Nombre de host (hostname) [NETBSD]: " hostname_val
hostname_val=${hostname_val:-NETBSD}

read -p "Nombre de la interfaz de red activa [wm0]: " iface
iface=${iface:-wm0}

echo "Generando script en /etc/configNet.sh ..."
sleep 1

# Escribir el script final
cat > /etc/configNet.sh << EOF
#!/bin/sh

IFACE="$iface"
LOGDIR="$logdir"
LOGFILE="\$LOGDIR/logip-\$(date +%Y%m%d).log"

mkdir -p "\$LOGDIR"

/sbin/ifconfig \$IFACE up

# Detectar red universitaria
ping -c 1 -w 1 $uni_gw > /dev/null 2>&1

if [ \$? -eq 0 ]; then
    NET="Universidad"
    IP="$uni_ip"
    GW="$uni_gw"
    MASK="$uni_mask"
    DOMAIN="$uni_domain"
    DNS_TEXT="$(printf "$uni_dns_text")"
else
    NET="Externa"
    IP="$ext_ip"
    GW="$ext_gw"
    MASK="$ext_mask"
    DOMAIN="$ext_domain"
    DNS_TEXT="$(printf "$ext_dns_text")"
fi

# Configuración de red
/sbin/ifconfig \$IFACE inet \$IP netmask \$MASK
/sbin/route flush > /dev/null 2>&1
/sbin/route add default \$GW

# Configuración DNS
echo "" > /etc/resolv.conf
printf "%b" "\$DNS_TEXT" >> /etc/resolv.conf
echo "domain \$DOMAIN" >> /etc/resolv.conf

# Configurar el hostname
hostname "$hostname_val"

/bin/echo "\$(date '+%Y-%m-%d %H:%M:%S') | Red: \$NET | IP: \$IP | Gateway: \$GW | Hostname: \$(hostname)" >> "\$LOGFILE"
EOF

chmod +x /etc/configNet.sh

if [ -f /etc/rc.local ]; then
    if ! grep -q "/etc/configNet.sh" /etc/rc.local; then
        echo "sh /etc/configNet.sh" >> /etc/rc.local
        chmod +x /etc/rc.local
        echo "Script agregado a rc.local para ejecución automática al iniciar NetBSD."
    else
        echo "Ya estaba agregado a rc.local, no se modificó."
    fi
else
    echo "/etc/rc.local no existe. Podrías crearlo o usar métodos de inicio de rc.d si querés."
fi

echo "Todo listo para NetBSD."
