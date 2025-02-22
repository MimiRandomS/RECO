#!/bin/sh
export LANG=C.UTF-8

show_menu() {
    clear
    echo -e "\e[1;36m╔══════════════════════════════════════════════╗\e[0m"
    echo -e "\e[1;36m║           📂 NetBSD Log Viewer Menu          ║\e[0m"
    echo -e "\e[1;36m╠══════════════════════════════════════════════╣\e[0m"
    echo -e "\e[1;35m║ 1) Show last 15 lines of system logs         ║\e[0m"
    echo -e "\e[1;33m║ 2) Filter last 15 lines for a specific word  ║\e[0m"
    echo -e "\e[1;31m║ 3) Salir                                     ║\e[0m"
    echo -e "\e[1;36m╚══════════════════════════════════════════════╝\e[0m"
    echo -ne "\e[1;36mSeleccione una opción: \e[0m"
}

show_logs() {
    echo "===== /var/log/messages ====="
    tail -n 15 /var/log/messages
    echo ""
    
    echo "===== /var/log/authlog ====="
    tail -n 15 /var/log/authlog
    echo ""

    echo "===== /var/log/secure ====="
    tail -n 15 /var/log/secure
    echo ""

    sleep 3
}

filter_logs() {
    echo -n "Enter the word to search for: "
    read keyword

    echo "===== /var/log/messages (Filtered) ====="
    tail -n 15 /var/log/messages | grep --color=auto -i "$keyword"
    echo ""

    echo "===== /var/log/authlog (Filtered) ====="
    tail -n 15 /var/log/authlog | grep --color=auto -i "$keyword"
    echo ""

    echo "===== /var/log/secure (Filtered) ====="
    tail -n 15 /var/log/secure | grep --color=auto -i "$keyword"
    echo ""

    sleep 3
}

func_exit(){
    echo -e "\e[1;31m Saliendo... \e[0m"
    exit 0
}

# Lógica del menú
while true; do
    show_menu
    read -r opcion
    clear
    case $opcion in
        1) show_logs ;;
        2) filter_logs ;;
        3) func_exit ;;
        *) echo -e "\e[1;31m Opción no válida, intenta de nuevo. \e[0m";;
    esac
    echo -e "\n\e[1;36mPresione Enter para continuar...\e[0m"
    read -r
done
