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
uni_dns_list=""
i=1
while [ $i -le $uni_dns_count ]; do
  read -p "DNS #$i (Universidad): " dns
  uni_dns_list="$uni_dns_list $dns"
  i=$((i+1))
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
ext_dns_list=""
i=1
while [ $i -le $ext_dns_count ]; do
  read -p "DNS #$i (Externa): " dns
  ext_dns_list="$ext_dns_list $dns"
  i=$((i+1))
done

read -p "Nombre de host (hostname) [NETBSD]: " hostname_val
hostname_val=${hostname_val:-NETBSD}

read -p "Nombre de la interfaz de red activa [wm0]: " iface
iface=${iface:-wm0}

echo "Generando script de configuración de red en /etc/configNet.sh ..."
sleep 1

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
    DNS_LIST="$uni_dns_list"
else
    NET="Externa"
    IP="$ext_ip"
    GW="$ext_gw"
    MASK="$ext_mask"
    DOMAIN="$ext_domain"
    DNS_LIST="$ext_dns_list"
fi

# Configuración de red
/sbin/ifconfig \$IFACE inet \$IP netmask \$MASK
/sbin/route flush > /dev/null 2>&1
/sbin/route add default \$GW

# Configuración DNS
echo "" > /etc/resolv.conf
for dns in \$DNS_LIST; do
    echo "nameserver \$dns" >> /etc/resolv.conf
done
echo "" >> /etc/resolv.conf
echo "search \$DOMAIN" >> /etc/resolv.conf

# Configurar el hostname
hostname "$hostname_val"

/bin/echo "\$(date '+%Y-%m-%d %H:%M:%S') | Red: \$NET | IP: \$IP | Gateway: \$GW | Hostname: \$(hostname)" >> "\$LOGFILE"
EOF

chmod +x /etc/configNet.sh

echo "Generando script de servicio en /etc/rc.d/configNet ..."
sleep 1

cat > /etc/rc.d/configNet << 'EOF'
#!/bin/sh
#
# PROVIDE: configNet
# REQUIRE: NETWORKING
# BEFORE: DAEMON

. /etc/rc.subr

name="configNet"
rcvar=${name}_enable

start_cmd="${name}_start"

configNet_start() {
    /etc/configNet.sh
}

load_rc_config $name
run_rc_command "$1"
EOF

chmod +x /etc/rc.d/configNet

echo "--------------------------------------------------"
echo "Para que el servicio se ejecute al inicio, agregá en /etc/rc.conf:"
echo ""
echo 'configNet_enable="YES"'
echo ""
echo "Después podés usar:"
echo "  service configNet start    # Para ejecutar manualmente"
echo "--------------------------------------------------"

echo "Todo listo para NetBSD."
