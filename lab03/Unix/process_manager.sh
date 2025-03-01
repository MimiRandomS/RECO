#!/bin/bash

display_menu() {
    clear
    echo -e "\e[1;36m╔══════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[1;36m║            ⚙️  ADMINISTRADOR DE PROCESOS          ║\e[0m"
    echo -e "\e[1;36m╠══════════════════════════════════════════════════╣\e[0m"
    echo -e "\e[1;33m║ 1) Mostrar procesos en ejecución                ║\e[0m"
    echo -e "\e[1;33m║ 2) Buscar un proceso por nombre                 ║\e[0m"
    echo -e "\e[1;33m║ 3) Terminar un proceso                          ║\e[0m"
    echo -e "\e[1;33m║ 4) Reiniciar un proceso                         ║\e[0m"
    echo -e "\e[1;31m║ 5) Salir                                       ║\e[0m"
    echo -e "\e[1;36m╚══════════════════════════════════════════════════╝\e[0m"
    echo -e "Seleccione una opción: "
}

ascci_art_1(){
    clear
    echo "__     __     ______     __         ______     ______     __    __     ______    "
    echo "/\ \  _ \ \   /\  ___\   /\ \       /\  ___\   /\  __ \   /\ -./  \   /\  ___\   "
    echo "\ \ \/ .\ \  \ \  __\   \ \ \____  \ \ \____  \ \ \/\ \  \ \ \-./\ \  \ \  __\   "
    echo "\ \__/ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \ \_\  \ \_____\ "
    echo "\/_/   \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/  \/_/   \/_____/ "
    echo "-------------------------------------------------------------------------------"
    echo "⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⣀⡀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⣀⡤⠀⠘⢋⣑⣶⣶⣿⣿⣿⣿⣷⣶⣤⣔⣄⠀⠀⠀⠀⠂⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⢰⡊⠡⠤⠴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣄⠀⠰⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⡄⠈⠓⢦⣀⠀⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⡇⠀⠀⠀⠉⠑⢦⡀⠈⠉⣟⡛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⡇⠀⠀⠀⠀⠀⠀⠉⠢⣄⠀⠉⢉⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⡇⠀⠀⢀⣄⡀⠀⠀⠀⠈⠑⢄⠀⠳⣭⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⡃⠀⢷⣤⡀⠉⠑⠒⠒⠤⣤⣀⡑⡄⠈⢿⣄⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⡇⠀⠀⢻⣿⡟⣿⣿⣶⣶⣤⣤⣀⣉⠀⠘⠻⣿⣿⣿⣿⣿⣿⣿⢫⣿⣿⣿⣿⡇⠐⣾⣿⣽⣿⣿⣿⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⡇⠀⢤⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣽⡄⢈⣽⣿⣿⣿⣿⣿⣦⣌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠇⠀⠈⢧⠀⠸⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⢸⡘⡄⠻⣽⣿⣿⣿⣿⣽⣶⣽⢝⢿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣤⣤⣤⣤⣄⣀⡀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠈⠳⡀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⣿⢿⣧⣽⣿⡇⢻⣿⢿⣧⠘⢦⡛⢿⣿⣿⣿⣿⣛⠛⢷⣦⣙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⡄"
    echo "⠀⠀⠀⠀⠀⠹⢦⡀⠈⢿⣿⣿⣿⣿⣿⣿⣷⡸⢿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⡀⢹⢷⣄⠈⢳⣌⣻⣿⣿⣿⣷⠂⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇"
    echo "⠀⠀⠀⠀⠀⠀⠀⠉⠲⢄⡻⢿⣿⣿⣿⣿⣿⣿⣶⡿⢿⣿⣯⣘⡄⠘⢧⠈⠙⠿⣦⣇⠙⢆⢀⣘⣶⣾⣟⣿⣿⣧⣤⣼⣿⣿⣿⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠁⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠢⣉⠛⢿⣿⣿⡿⢿⣿⣇⠻⢿⣍⣧⣀⣈⣀⣴⣦⡈⢻⣶⢏⣿⣧⣴⡾⢿⡿⢿⣟⠛⠛⠿⣿⣿⣧⢿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⢈⢿⣿⢸⣿⣽⣿⣧⠀⠚⠶⠾⠶⠶⠾⣿⣭⣉⣠⠈⢉⣹⣷⣶⣾⣿⣷⢬⣤⣠⣾⣿⣿⣎⣿⣿⣿⣿⣿⣿⣿⣋⣤⣤⣤⣤⣤⣀⣠⡄"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⣦⣭⣿⣿⢸⣿⣻⡿⠈⠙⠀⠀⠀⠀⠀⠀⠀⠙⠟⠀⣀⣿⣄⠛⠋⠉⠉⠉⠉⢻⣿⣿⣿⢍⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢻⣿⣿⣿⣧⢸⣷⠛⢹⡇⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠼⣿⡿⠟⠁⠀⣤⢦⡄⠀⢠⣿⣿⣿⣟⣯⣿⣿⡏⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠃"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠜⢻⣿⣿⣧⡻⢿⣯⣿⠀⠀⠀⠀⠀⠀⠹⢿⢶⡶⠶⣶⣶⡶⢒⣋⡽⣾⠁⠀⣼⣿⣿⡟⣿⣧⣼⠟⢹⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠁⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢓⣿⣦⣀⣹⡄⠀⠀⠀⠀⠀⠀⠈⠳⠷⠶⠶⠤⠴⠾⠋⣰⠟⠀⣼⣿⣿⡏⣽⣛⠳⠋⣰⣿⣿⣿⣿⣿⣿⣿⠟⠉⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣀⡀⠀⠀⠀⠀⣠⣿⣿⡟⣽⢋⣽⣿⣿⣿⡿⠿⠟⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠴⠛⠉⠛⠛⠛⠛⢻⠻⣄⠀⠀⠀⠀⠀⠀⠋⠀⠙⢻⣿⡆⠀⠀⣠⣾⣿⣿⣴⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⢏⠷⣄⠀⠀⠀⠀⠀⠀⠀⠈⠹⠇⠀⢀⣾⣿⣿⣿⣿⡟⠛⠛⣿⣿⡿⠿⠿⠿⠿⠿⠿⠿⠶⠄⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠀⠸⣆⠘⢳⣄⡀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⢿⣿⣇⠀⠻⢿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡞⠀⠀⠹⡄⠀⠙⠿⢤⣄⣀⣴⣾⣿⣿⣿⣿⠛⡻⠃⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣇⣀⣀⣀⣹⡄⠀⠀⠀⠀⠉⠛⢋⣹⣿⣿⣛⣾⣥⣶⣿⣿⣿⣄⠀⠀⢀⣐⣆⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⣤⣀⡀⠀⣠⠞⠁⣈⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠻⣦⣄⠀⠀⢀⡀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⣴⣿⣿⣿⣿⣿⣿⣿⠴⠿⠛⠛⣏⠛⣿⣿⣿⡟⣿⣿⣿⣿⣿⡟⠁⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠠⣝⣿⣷⣶⡆⣧⣀⣀⣀⣠⡄"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⣶⣶⠖⠀⢵⣿⣿⣿⣿⡿⠛⠋⠁⠀⣠⣤⣾⣿⣦⡀⢽⣿⣿⣿⣿⣿⣿⢏⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣹⣿⣿⣿⣿⣱⡿⢛⣿⣿⣿⡇"
    echo "⠀⠀⠀⠠⠀⣠⢟⣡⣿⣿⣃⣺⣿⣿⣿⣿⡇⢀⣤⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣠⣽⣿⣿⣿⣿⣧⡿⣣⣿⣿⣿⣿⡇"
    echo "⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    sleep 3
    clear
}

ascci_art_2(){
    clear
    echo "          ______     __  __     ______    "
    echo "          /\  == \   /\ \_\ \   /\  ___\   "
    echo "          \ \  __<   \ \____ \  \ \  __\   "
    echo "          \ \_____\  \/\_____\  \ \_____\ "
    echo "          \/_____/   \/_____/   \/_____/ "
    echo "--------------------------------------------------------------------"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢠⠳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⢸⢸⢳⡙⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠖⡏⠀⠀⠀⢸⠀⠐⡜⣆⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢞⠵⢸⠀⠀⢀⡇⣸⠀⡆⠘⣌⢆⠀⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢞⡵⠁⡆⡇⠀⡠⠋⡼⠀⠀⡇⠀⠘⠈⢧⡏⡄⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⢠⠀⠀⠀⠀⢀⡴⣡⡯⠀⢀⡇⣧⠞⠁⡰⠃⠀⠀⣧⠀⠀⠀⢸⡇⢃⢸⢇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⢸⡀⠀⠀⢠⢎⡜⡿⠁⠀⢸⣇⡵⠁⠀⠀⠀⠀⠀⣿⠀⠀⠀⠈⠀⢸⣸⠘⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⢸⢣⠀⡴⣡⣿⠁⠃⠀⢀⣾⡿⠁⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠈⡏⠀⢇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⢸⠈⢇⡇⣿⡏⠀⠀⠀⣼⣿⠃⠀⠀⠀⠀⢀⠇⡰⣿⠀⠀⠀⠀⠀⡇⠁⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠸⠐⠄⠀⠏⡇⠀⠀⣧⣿⡇⡀⡜⢰⠀⠀⡘⡐⠁⠏⡆⠀⠀⡄⢠⡇⡄⠀⠈⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠈⠦⢠⣧⠀⣆⣿⣿⢁⣷⣇⡇⠀⣴⣯⠀⠀⠀⡇⠀⣸⡇⣾⡿⠁⠀⡀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⢀⠀⠀⠀⢀⢀⢠⠀⠸⣿⣆⢹⣿⣿⣾⣿⣿⣠⢾⠛⠁⠀⠀⠀⡇⡠⡟⣿⣿⠃⠀⠀⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠘⡶⣄⠀⢸⠸⣼⣧⡀⣿⣿⣾⣿⣿⣿⣿⣿⡇⠘⠀⡀⠀⠀⢠⠟⠀⠃⢹⣥⠃⠀⢠⢏⣜⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠙⡌⠳⢄⣣⠹⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⡇⠀⠀⢀⣄⣴⡢⠀⠀⠀⡿⣯⠀⠐⠁⠘⣻⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠘⢎⢶⣍⣀⠈⢿⣿⣿⣿⣿⣿⣿⣦⠑⣤⡀⠀⣰⠟⡿⠁⠀⠀⠈⠀⠁⠀⠀⡀⡰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠈⢣⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠘⣷⣾⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⡵⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠑⣝⠻⠿⣿⣿⣿⣿⣿⣿⣿⣇⠀⣿⣿⣿⣇⣀⣤⠆⠀⠁⠀⠉⠀⠸⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠈⠉⡇⢸⣿⣿⣿⣿⣿⣿⣿⣼⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠐⢤⡀⠙⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠱⢬⣙⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⡄⠀⠀⠀⠀⠀⠀⠈⠻⠆⠀⠈⠑⠒⣿⣦⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠑⠲⣼⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⣀⣀⣀⠀⠀⣀⣀⣠⣴⣾⣾⣿⣿⣿⣿⣿⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣘⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⠤⣀⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⢘⣿⠟⣡⣶⣶⣤⡄⠙⣿⣿⣿⣿⣿⣿⣟⡛⠿⠿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢿⣿⣿⣿⡿⠟⣩⣿⣿⣿⣿⡀⠀⠀⢏⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⣶⣿⢋⣼⢿⠿⢛⣿⠷⢶⣶⠂⠿⣿⣿⣿⣿⣿⣷⣶⣤⣀⡀⠉⠉⠀⠀⣀⣀⡀⠀⠀⠀⠠⢾⣿⣿⣿⣿⣿⠇⠀⠀⣘⠢⡀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⢀⣽⠁⠘⠁⠀⠀⠁⠀⠠⠟⠛⣿⣄⡩⢉⣿⣿⣿⣿⣿⡿⠋⠀⡠⣶⣶⣶⡶⣶⣶⣾⠿⠶⠀⠀⠻⣿⣿⣿⣿⠀⠀⠠⣿⣷⡘⢆⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⡸⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⣿⣿⣤⡈⣿⣿⣿⣿⡟⠁⣠⣾⡇⠀⣿⣿⣆⠀⠀⠀⠀⣀⣠⣆⠀⢹⣿⣿⡿⠀⠀⢠⣿⣿⣿⡘⡆⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⠁⣺⣿⣿⣿⡿⠀⢰⡟⠛⠇⠘⠿⣿⣇⠀⠀⣀⠀⢀⣽⣿⡀⠀⣿⣿⠃⠀⠀⢸⣿⣿⣿⣧⢸⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⢣⠀⠀⠀⠀⠀⠀⠀⢀⣴⠟⣿⠃⢰⠨⣿⣿⣿⠃⠀⣿⡇⢀⠀⢰⠀⠛⠛⠀⠀⠛⠀⠈⠉⠹⠇⠀⣿⡏⠀⠀⠀⣹⣿⣿⣿⣿⠘⢦⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠈⡆⠀⠀⠀⠀⣠⡶⠋⠁⡼⠃⠀⣾⠃⣿⣿⣿⠀⠀⡟⢀⡜⠀⢋⣠⣶⠀⠀⠒⠒⠀⠀⣶⡾⠀⢠⠏⠀⠀⣠⣾⣿⣿⣿⣿⢿⠁⠀⣣⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⣼⣷⢤⣤⢶⠟⠁⠀⠀⠀⠀⢀⣼⡏⣸⣿⣿⣿⣇⠀⢻⣿⡇⠀⣿⣿⣿⠀⠀⣶⣶⠀⢸⣿⠃⠀⠎⠀⠀⠀⠿⣿⣿⣿⣿⡿⠀⠀⢀⣯⢇⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⢰⣿⣿⠘⠁⠁⠀⠀⢀⣠⣴⣾⣿⠟⣰⣿⣿⣿⣿⣿⡄⠀⠻⠀⣠⣿⣿⣿⠀⠀⠉⠉⠀⠘⠁⢀⠌⠀⠀⠀⢀⠀⠀⠈⠉⠀⠀⠀⢀⣾⣿⡿⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⡟⣿⡏⠀⠀⢀⣠⣾⣿⣿⡿⠛⣡⠀⣿⣿⣿⣿⣿⣿⣿⣦⣀⠈⠙⠻⠿⠿⠶⠾⠟⠃⠀⢀⠔⠁⠀⠀⠀⠀⣾⣆⠀⠀⠀⠀⣰⢀⣾⣿⣿⣧⡇⠀"
    echo "⠀⠀⠀⠀⠀⢸⠁⣿⠃⢀⣴⣿⣿⣿⠟⢻⢁⣾⣿⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣤⣄⣀⡀⠠⠤⠐⠊⠀⠀⠀⠀⠀⢀⡰⣿⣿⡆⠀⠀⣿⣧⣿⣿⣿⣿⣿⡇⠀"
    echo "⠀⠀⠀⠀⠀⣌⠀⠘⢠⣿⣿⣿⡟⠁⢀⣏⣾⣿⡇⣸⣿⣿⣿⣿⣿⣟⠛⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠋⢱⣿⣿⣧⠀⢠⣿⣿⣿⣿⣿⣿⡏⢱⠀"
    echo "⠀⠀⠀⠀⠀⠈⠑⠢⢿⣿⣿⡟⠀⢀⣾⣿⣿⡟⢠⣿⣿⣿⣿⡿⠿⢿⣿⣷⣶⣤⣤⣤⣄⣤⣤⣤⠤⠖⠂⠀⠀⣠⠊⠀⠀⠀⢿⣿⣿⠀⢸⣿⣿⣿⣿⣿⣿⠇⢸⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠣⢤⣈⣿⣿⠏⣰⣿⣿⣿⣷⣭⣍⣑⠂⠀⠀⠈⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⢀⡼⠁⠀⠀⠀⠀⠈⢿⢿⠀⣼⣿⣿⣿⣿⣿⣧⢴⣾⡄"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠑⠚⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠶⠶⠶⠖⠒⠂⠀⠀⠀⠀⢠⠞⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⣿⣿⣿⣿⣿⣿⣡⣿⣿⡇"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠓⠒⠒⠒⠒⠒⠒⠒⠒⠊⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⠤⠛⠛⠿⠯⠭⠭⠙⠒⠚⠁"
    sleep 3
}

# Función para mostrar procesos activos
show_processes() {
    echo -e "\e[1;32mProcesos en ejecución:\e[0m"
    ps -eo pid,%mem,%cpu,cmd --sort=-%cpu | head -20
}

# Función para buscar un proceso por nombre
search_process() {
    read -rp "Ingrese el nombre del proceso: " process_name
    echo -e "\e[1;34mBuscando el proceso '$process_name'...\e[0m"
    ps aux | grep -i "$process_name" | grep -v "grep"
}

# Función para terminar un proceso por PID
kill_process() {
    read -rp "Ingrese el PID del proceso a terminar: " pid
    if kill "$pid"; then
        echo -e "\e[1;31mProceso $pid terminado correctamente.\e[0m"
    else
        echo -e "\e[1;31mError al terminar el proceso $pid.\e[0m"
    fi
}

# Función para reiniciar un proceso por PID
restart_process() {
    read -rp "Ingrese el PID del proceso a reiniciar: " pid
    process_cmd=$(ps -p "$pid" -o cmd --no-headers)
    if [ -z "$process_cmd" ]; then
        echo -e "\e[1;31mNo se encontró el proceso con PID $pid.\e[0m"
        return
    fi
    kill "$pid" && sleep 2 && eval "$process_cmd" &
    echo -e "\e[1;32mProceso $pid reiniciado correctamente.\e[0m"
}

func_exit(){
    ascci_art_2
    echo -e "Saliendo... "
    exit 0
}

# Función principal que ejecuta el menú
main() {
    ascci_art_1
    while true; do
        display_menu
        read -r option
        clear
        case $option in
            1) show_processes ;;
            2) search_process ;;
            3) kill_process ;;
            4) restart_process ;;
            5) func_exit ;;
            *) echo -e "\e[1;31mOpción no válida.\e[0m" ;;
        esac
        echo -e "\nPresione Enter para continuar..."
        read -r
    done
}

# Llamar a la función principal
main
