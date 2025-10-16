#!/bin/bash
set -euo pipefail

# ANSI colors
RED='\e[31m'; GREEN='\e[32m'; YELLOW='\e[33m'; BLUE='\e[34m'; MAGENTA='\e[35m'; CYAN='\e[36m'; RESET='\e[0m'

# Watermark
print_watermark() {
  echo -e "${CYAN}==============================================================${RESET}"
  echo -e "${GREEN} _______    _______     __    __    __    _______    _______ ${RESET}"
  echo -e "${YELLOW}|  ___  |  |_____  |   |  |  |   \\/   |  |  _____|  |  _____|${RESET}"
  echo -e "${MAGENTA}| |___| |       /  /   |  |  |  \\  /  |  | |____    | |____${RESET}"
  echo -e "${BLUE}| |___| |     /  /     |  |  |  |\\/|  |  |  ____|   |  ____|${RESET}"
  echo -e "${RED}| |   | |   /  /____   |  |  |  |  |  |  | |_____   | |_____${RESET}"
  echo -e "${CYAN}|_|   |_|  |________|  |__|  |__|  |__|  |_______|  |_______|${RESET}"
  echo
  echo -e "${MAGENTA}              POWERED BY AZIMEEE${RESET}"
  echo -e "${CYAN}==============================================================${RESET}"
}

# Loading animation
loading_animation() {
    echo -e "${CYAN}Starting Installer${RESET}"
    local i sp n
    sp='/-\|'
    n=${#sp}
    for ((i=0; i<20; i++)); do
        printf "\r${YELLOW}[%c] Loading...${RESET}" "${sp:i%n:1}"
        sleep 0.1
    done
    printf "\r${GREEN}[✔] Ready!         ${RESET}\n"
    sleep 0.5
}

# ---- SCRIPT START ----
clear
print_watermark
loading_animation
sleep 0.5

while true; do
    clear
    print_watermark
    echo "========= MAIN MENU ========="
    echo "1) Panels"
    echo "2) Themes"
    echo "3) Tunneling System"
    echo "4) Exit"
    read -p "Choose an option: " choice

    case $choice in
        1)
            clear
            echo "========= PANEL CATEGORY ========="
            echo "1) Ubuntu/Debian Panels"
            echo "2) Docker Panels"
            echo "3) Back"
            read -p "Select: " panelcat

            case $panelcat in
                1)
                    clear
                    echo "========= UBUNTU/DEBIAN PANELS ========="
                    echo "1) Pterodactyl"
                    echo "2) Jexactyl"
                    echo "3) Reviadactyl"
                    echo "4) Pelican"
                    echo "5) PufferPanel"
                    echo "6) TeryxPanel"
                    echo "7) Skyport"
                    echo "8) Back"
                    read -p "Select a panel: " upanel
                    case $upanel in
                        1) bash <(curl -s https://raw.githubusercontent.com/lottanodesofficial/panel/refs/heads/main/pp) ;;
                        2) bash <(curl -s https://raw.githubusercontent.com/lottanodesofficial/panel/refs/heads/main/jp) ;;
                        3) bash <(curl -s https://raw.githubusercontent.com/lottanodesofficial/panel/refs/heads/main/rp) ;;
                        4) wget https://raw.githubusercontent.com/dazeb/pelican-installer/main/install_pelican.sh && chmod +x install_pelican.sh && ./install_pelican.sh ;;
                        5) bash <(curl -sSL https://raw.githubusercontent.com/KSWarrior/moh-codes/refs/heads/main/pufferpanel/ks-install.sh) ;;
                        6) bash <(curl -s https://raw.githubusercontent.com/titan-modz/install/refs/heads/main/teryxpanel.sh) ;;
                        7) bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/skyport) ;;
                        8) continue ;;
                    esac
                    ;;
                2)
                    clear
                    echo "========= DOCKER PANELS ========="
                    echo "1) Pterodactyl (Docker)"
                    echo "2) PufferPanel (Docker)"
                    echo "3) TeryxPanel (Docker)"
                    echo "4) Skyport (Docker)"
                    echo "5) Back"
                    read -p "Select a panel: " dpanel
                    case $dpanel in
                        1) bash <(curl -s https://raw.githubusercontent.com/titan-modz/24-7/refs/heads/main/code) ;;
                        2) bash <(curl -sSL https://raw.githubusercontent.com/KSWarrior/moh-codes/refs/heads/main/pufferpanel/ks-install.sh) ;;
                        3) bash <(curl -s https://raw.githubusercontent.com/titan-modz/install/refs/heads/main/teryxpanel.sh) ;;
                        4) bash <(curl -s https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/skyport) ;;
                        5) continue ;;
                    esac
                    ;;
            esac
            ;;
        2)
            clear
            echo "========= THEMES ========="
            echo "1) Arix Theme"
            echo "2) Ice Theme"
            echo "3) Nook Theme"
            echo "4) BeefBytes Theme"
            echo "5) Back"
            read -p "Select a theme: " theme

            case $theme in
                1)
                    wget https://github.com/lottanodesofficial/theme/raw/main/ArixTheme.zip
                    unzip ArixTheme.zip -d /var/www/pterodactyl
                    cd /var/www/pterodactyl || exit
                    php artisan arix || php artisan migrate --force && php artisan optimize:clear && php artisan optimize && chmod -R 755 storage/* bootstrap/cache
                    ;;
                2)
                    bash <(curl -s https://raw.githubusercontent.com/Angelillo15/IceMinecraftTheme/main/install.sh)
                    ;;
                3)
                    wget https://github.com/parkervcp/nooktheme/archive/refs/heads/main.zip
                    unzip main.zip -d /var/www/pterodactyl
                    ;;
                4)
                    wget https://github.com/BeefBytes/PteroTheme/archive/refs/heads/main.zip
                    unzip main.zip -d /var/www/pterodactyl
                    ;;
                5) continue ;;
            esac
            ;;
        3)
            clear
            echo "========= TUNNELING SYSTEM ========="
            apt update && apt install -y git && git clone https://github.com/nahmolol/tunnel && chmod +x tunnel/tunnel && mv tunnel/tunnel /usr/local/bin/ && rm -rf tunnel && clear && echo "Tunnel installed successfully! Run it with 'tunnel'"
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
    esac
done
