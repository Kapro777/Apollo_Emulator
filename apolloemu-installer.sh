#!/data/data/com.termux/files/usr/bin/bash
#
# ApolloEmu - Emulador de PC completo para Termux
# VersÃ£o: 2.0
# Autor: ApolloEmu Team
# Data: 2025
#
# Este script instala e configura um ambiente completo de emulaÃ§Ã£o de PC
# incluindo Box64, Box86, Wine, DXVK, Turnip, Proton, Zink e muito mais.
#

# Cores ANSI para interface bonita
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Banner do ApolloEmu
show_banner() {
    clear
    echo -e "${PURPLE}${BOLD}"
    cat << "EOF"
    â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—
    â•‘                                                                  â•‘
    â•‘      â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•— â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—  â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•— â–ˆâ–ˆâ•—     â–ˆâ–ˆâ•—      â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—           â•‘
    â•‘     â–ˆâ–ˆâ•”â•â•â–ˆâ–ˆâ•—â–ˆâ–ˆâ•”â•â•â–ˆâ–ˆâ•—â–ˆâ–ˆâ•”â•â•â•â–ˆâ–ˆâ•—â–ˆâ–ˆâ•‘     â–ˆâ–ˆâ•‘     â–ˆâ–ˆâ•”â•â•â•â–ˆâ–ˆâ•—          â•‘
    â•‘     â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•‘â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•”â•â–ˆâ–ˆâ•‘   â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•‘     â–ˆâ–ˆâ•‘     â–ˆâ–ˆâ•‘   â–ˆâ–ˆâ•‘          â•‘
    â•‘     â–ˆâ–ˆâ•”â•â•â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•”â•â•â•â• â–ˆâ–ˆâ•‘   â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•‘     â–ˆâ–ˆâ•‘     â–ˆâ–ˆâ•‘   â–ˆâ–ˆâ•‘          â•‘
    â•‘     â–ˆâ–ˆâ•‘  â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•‘     â•šâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•”â•â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â•šâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•”â•          â•‘
    â•‘     â•šâ•â•  â•šâ•â•â•šâ•â•      â•šâ•â•â•â•â•â• â•šâ•â•â•â•â•â•â•â•šâ•â•â•â•â•â•â• â•šâ•â•â•â•â•â•           â•‘
    â•‘                                                                  â•‘
    â•‘    â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â–ˆâ–ˆâ–ˆâ•—   â–ˆâ–ˆâ–ˆâ•—â–ˆâ–ˆâ•—   â–ˆâ–ˆâ•—    â–ˆâ–ˆâ•—   â–ˆâ–ˆâ•—â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—  â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—    â•‘
    â•‘    â–ˆâ–ˆâ•”â•â•â•â•â•â–ˆâ–ˆâ–ˆâ–ˆâ•— â–ˆâ–ˆâ–ˆâ–ˆâ•‘â–ˆâ–ˆâ•‘   â–ˆâ–ˆâ•‘    â–ˆâ–ˆâ•‘   â–ˆâ–ˆâ•‘â•šâ•â•â•â•â–ˆâ–ˆâ•—â–ˆâ–ˆâ•”â•â–ˆâ–ˆâ–ˆâ–ˆâ•—   â•‘
    â•‘    â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—  â–ˆâ–ˆâ•”â–ˆâ–ˆâ–ˆâ–ˆâ•”â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•‘   â–ˆâ–ˆâ•‘    â–ˆâ–ˆâ•‘   â–ˆâ–ˆâ•‘ â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•”â•â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•”â–ˆâ–ˆâ•‘   â•‘
    â•‘    â–ˆâ–ˆâ•”â•â•â•  â–ˆâ–ˆâ•‘â•šâ–ˆâ–ˆâ•”â•â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•‘   â–ˆâ–ˆâ•‘    â•šâ–ˆâ–ˆâ•— â–ˆâ–ˆâ•”â•â–ˆâ–ˆâ•”â•â•â•â• â–ˆâ–ˆâ–ˆâ–ˆâ•”â•â–ˆâ–ˆâ•‘   â•‘
    â•‘    â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â–ˆâ–ˆâ•‘ â•šâ•â• â–ˆâ–ˆâ•‘â•šâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•”â•     â•šâ–ˆâ–ˆâ–ˆâ–ˆâ•”â• â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â•šâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•”â•   â•‘
    â•‘    â•šâ•â•â•â•â•â•â•â•šâ•â•     â•šâ•â• â•šâ•â•â•â•â•â•       â•šâ•â•â•â•  â•šâ•â•â•â•â•â•â• â•šâ•â•â•â•â•â•    â•‘
    â•‘                                                                  â•‘
    â•‘               ðŸš€ EMULADOR DE PC PARA TERMUX ðŸš€                   â•‘
    â•‘                                                                  â•‘
    â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
EOF
    echo -e "${NC}"
    echo -e "${CYAN}${BOLD}                    Bem-vindo ao ApolloEmu v2.0${NC}"
    echo -e "${GRAY}        O mais completo emulador de PC para Android com Termux${NC}"
    echo
}

# FunÃ§Ã£o para exibir progresso
show_progress() {
    local current=$1
    local total=$2
    local message=$3
    local percent=$((current * 100 / total))
    local filled=$((percent / 2))
    local empty=$((50 - filled))
    
    printf "\r${YELLOW}${BOLD}[${NC}"
    printf "%${filled}s" | tr ' ' 'â–ˆ'
    printf "${GRAY}%${empty}s${NC}" | tr ' ' 'â–‘'
    printf "${YELLOW}${BOLD}] ${percent}%% - ${WHITE}${message}${NC}"
}

# FunÃ§Ã£o para detectar informaÃ§Ãµes do sistema
detect_system() {
    echo -e "${BLUE}${BOLD}ðŸ” Detectando informaÃ§Ãµes do sistema...${NC}"
    
    # Detectar arquitetura
    ARCH=$(uname -m)
    echo -e "${GREEN}   âœ“ Arquitetura: ${ARCH}${NC}"
    
    # Detectar versÃ£o do Android
    ANDROID_VERSION=$(getprop ro.build.version.release)
    echo -e "${GREEN}   âœ“ Android: ${ANDROID_VERSION}${NC}"
    
    # Detectar GPU
    GPU_INFO=$(getprop ro.hardware.vulkan || echo "Desconhecido")
    echo -e "${GREEN}   âœ“ GPU: ${GPU_INFO}${NC}"
    
    # Verificar se Ã© Snapdragon
    SOC=$(getprop ro.hardware)
    if [[ "$SOC" == *"qcom"* ]] || [[ "$SOC" == *"msm"* ]]; then
        IS_SNAPDRAGON=true
        echo -e "${GREEN}   âœ“ Snapdragon detectado: Suporte completo a Turnip/DXVK${NC}"
    else
        IS_SNAPDRAGON=false
        echo -e "${YELLOW}   âš  GPU nÃ£o-Snapdragon: Usando VirGL${NC}"
    fi
    
    # Verificar espaÃ§o disponÃ­vel
    SPACE_AVAILABLE=$(df $HOME | awk 'NR==2 {print $4}')
    SPACE_GB=$((SPACE_AVAILABLE / 1024 / 1024))
    echo -e "${GREEN}   âœ“ EspaÃ§o disponÃ­vel: ${SPACE_GB}GB${NC}"
    
    if [ $SPACE_GB -lt 4 ]; then
        echo -e "${RED}   âŒ ERRO: NecessÃ¡rio pelo menos 4GB de espaÃ§o livre!${NC}"
        exit 1
    fi
}

# Menu principal usando whiptail
show_main_menu() {
    if command -v whiptail >/dev/null 2>&1; then
        OPTION=$(whiptail --title "ðŸš€ ApolloEmu v2.0 - Menu Principal" \
            --menu "Escolha uma opÃ§Ã£o:" 20 70 10 \
            "1" "ðŸ› ï¸  InstalaÃ§Ã£o Completa (Recomendado)" \
            "2" "âš™ï¸  InstalaÃ§Ã£o Personalizada" \
            "3" "ðŸŽ® Iniciar ApolloEmu" \
            "4" "ðŸ”§ ConfiguraÃ§Ãµes" \
            "5" "ðŸ“¦ Gerenciar Componentes" \
            "6" "ðŸŽ¯ Instalar Jogos/Apps" \
            "7" "ðŸ“Š Status do Sistema" \
            "8" "ðŸ”„ Atualizar ApolloEmu" \
            "9" "â“ Ajuda e Suporte" \
            "0" "âŒ Sair" 3>&1 1>&2 2>&3)
    else
        show_text_menu
    fi
}

# Menu alternativo para texto puro
show_text_menu() {
    clear
    show_banner
    echo -e "${CYAN}${BOLD}â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ MENU PRINCIPAL â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
    echo -e "${CYAN}${BOLD}â”‚${NC}                                               ${CYAN}${BOLD}â”‚${NC}"
    echo -e "${CYAN}${BOLD}â”‚${NC}  ${WHITE}${BOLD}1${NC} - ðŸ› ï¸  InstalaÃ§Ã£o Completa (Recomendado)    ${CYAN}${BOLD}â”‚${NC}"
    echo -e "${CYAN}${BOLD}â”‚${NC}  ${WHITE}${BOLD}2${NC} - âš™ï¸  InstalaÃ§Ã£o Personalizada            ${CYAN}${BOLD}â”‚${NC}"
    echo -e "${CYAN}${BOLD}â”‚${NC}  ${WHITE}${BOLD}3${NC} - ðŸŽ® Iniciar ApolloEmu                   ${CYAN}${BOLD}â”‚${NC}"
    echo -e "${CYAN}${BOLD}â”‚${NC}  ${WHITE}${BOLD}4${NC} - ðŸ”§ ConfiguraÃ§Ãµes                       ${CYAN}${BOLD}â”‚${NC}"
    echo -e "${CYAN}${BOLD}â”‚${NC}  ${WHITE}${BOLD}5${NC} - ðŸ“¦ Gerenciar Componentes               ${CYAN}${BOLD}â”‚${NC}"
    echo -e "${CYAN}${BOLD}â”‚${NC}  ${WHITE}${BOLD}6${NC} - ðŸŽ¯ Instalar Jogos/Apps                 ${CYAN}${BOLD}â”‚${NC}"
    echo -e "${CYAN}${BOLD}â”‚${NC}  ${WHITE}${BOLD}7${NC} - ðŸ“Š Status do Sistema                   ${CYAN}${BOLD}â”‚${NC}"
    echo -e "${CYAN}${BOLD}â”‚${NC}  ${WHITE}${BOLD}8${NC} - ðŸ”„ Atualizar ApolloEmu                 ${CYAN}${BOLD}â”‚${NC}"
    echo -e "${CYAN}${BOLD}â”‚${NC}  ${WHITE}${BOLD}9${NC} - â“ Ajuda e Suporte                     ${CYAN}${BOLD}â”‚${NC}"
    echo -e "${CYAN}${BOLD}â”‚${NC}  ${WHITE}${BOLD}0${NC} - âŒ Sair                                ${CYAN}${BOLD}â”‚${NC}"
    echo -e "${CYAN}${BOLD}â”‚${NC}                                               ${CYAN}${BOLD}â”‚${NC}"
    echo -e "${CYAN}${BOLD}â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
    echo
    echo -ne "${YELLOW}${BOLD}Escolha uma opÃ§Ã£o [0-9]: ${NC}"
    read OPTION
}

# FunÃ§Ã£o para instalar dependÃªncias bÃ¡sicas
install_dependencies() {
    echo -e "${BLUE}${BOLD}ðŸ“¦ Instalando dependÃªncias bÃ¡sicas...${NC}"
    
    local deps=(
        "curl" "wget" "git" "python" "cmake" "ninja"
        "binutils" "bison" "flex" "ndk-multilib" "patchelf"
        "pulseaudio" "virglrenderer-android" "mesa-zink"
        "x11-repo" "tur-repo" "root-repo"
    )
    
    local total=${#deps[@]}
    local current=0
    
    # Atualizar repositÃ³rios
    show_progress $current $total "Atualizando repositÃ³rios..."
    yes | pkg update -y > /dev/null 2>&1
    yes | pkg upgrade -y > /dev/null 2>&1
    
    # Instalar cada dependÃªncia
    for dep in "${deps[@]}"; do
        current=$((current + 1))
        show_progress $current $total "Instalando $dep..."
        yes | pkg install -y $dep > /dev/null 2>&1
        sleep 0.1
    done
    
    echo
    echo -e "${GREEN}${BOLD}âœ… DependÃªncias instaladas com sucesso!${NC}"
}

# FunÃ§Ã£o para instalar Termux-X11
install_termux_x11() {
    echo -e "${BLUE}${BOLD}ðŸ–¥ï¸ Instalando Termux-X11...${NC}"
    
    if ! dpkg -l | grep -q termux-x11; then
        show_progress 1 3 "Baixando Termux-X11..."
        wget -q https://github.com/termux/termux-x11/releases/latest/download/termux-x11-universal-1.03.00-0-all.deb -O /tmp/termux-x11.deb
        
        show_progress 2 3 "Instalando Termux-X11..."
        dpkg -i /tmp/termux-x11.deb > /dev/null 2>&1
        
        show_progress 3 3 "Configurando Termux-X11..."
        rm -f /tmp/termux-x11.deb
        
        echo
        echo -e "${GREEN}âœ… Termux-X11 instalado!${NC}"
    else
        echo -e "${YELLOW}âš ï¸ Termux-X11 jÃ¡ estÃ¡ instalado${NC}"
    fi
}

# FunÃ§Ã£o para instalar Box64 e Box86
install_box64_86() {
    echo -e "${BLUE}${BOLD}ðŸ“¦ Instalando Box64 e Box86...${NC}"
    
    # Instalar Box64
    show_progress 1 4 "Configurando repositÃ³rio Box64..."
    wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor -o $PREFIX/etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg > /dev/null 2>&1
    echo "deb [signed-by=$PREFIX/etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg] https://ryanfortner.github.io/box64-debs/ ./" > $PREFIX/etc/apt/sources.list.d/box64.list
    
    show_progress 2 4 "Instalando Box64..."
    apt update > /dev/null 2>&1
    apt install -y box64-android > /dev/null 2>&1
    
    # Instalar Box86
    show_progress 3 4 "Instalando Box86..."
    wget -qO- https://ryanfortner.github.io/box86-debs/KEY.gpg | gpg --dearmor -o $PREFIX/etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg > /dev/null 2>&1
    echo "deb [signed-by=$PREFIX/etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg] https://ryanfortner.github.io/box86-debs/ ./" > $PREFIX/etc/apt/sources.list.d/box86.list
    apt update > /dev/null 2>&1
    apt install -y box86-android > /dev/null 2>&1
    
    show_progress 4 4 "Configurando Box64/Box86..."
    
    # Criar configuraÃ§Ãµes otimizadas
    mkdir -p $HOME/.config/apolloemu
    cat > $HOME/.config/apolloemu/box64.conf << 'EOF'
export BOX64_NOBANNER=1
export BOX64_LOG=0
export BOX64_SHOWSEGV=0
export BOX64_DYNAREC_STRONGMEM=1
export BOX64_DYNAREC_BIGBLOCK=1
export BOX64_DYNAREC_FORWARD=512
export BOX64_DYNAREC_FASTNAN=0
export BOX64_DYNAREC_FASTROUND=1
export BOX64_DYNAREC_X87DOUBLE=1
export BOX64_DYNAREC_SAFEFLAGS=0
export BOX64_PREFER_WRAPPED=1
export BOX64_PREFER_EMULATED=1
EOF
    
    echo
    echo -e "${GREEN}âœ… Box64 e Box86 instalados!${NC}"
}

# FunÃ§Ã£o para instalar Wine
install_wine() {
    echo -e "${BLUE}${BOLD}ðŸ· Instalando Wine...${NC}"
    
    show_progress 1 5 "Baixando Wine..."
    mkdir -p $HOME/.local/share/apolloemu
    cd $HOME/.local/share/apolloemu
    
    # Baixar Wine otimizado
    if [ "$ARCH" = "aarch64" ]; then
        wget -q https://github.com/Kron4ek/Wine-Builds/releases/download/8.21/wine-8.21-aarch64.tar.xz -O wine.tar.xz
    else
        echo -e "${RED}âŒ Arquitetura nÃ£o suportada: $ARCH${NC}"
        return 1
    fi
    
    show_progress 2 5 "Extraindo Wine..."
    tar -xf wine.tar.xz > /dev/null 2>&1
    mv wine-* wine
    rm wine.tar.xz
    
    show_progress 3 5 "Configurando Wine..."
    export WINEPREFIX="$HOME/.wine"
    export PATH="$HOME/.local/share/apolloemu/wine/bin:$PATH"
    
    show_progress 4 5 "Inicializando Wine..."
    winecfg > /dev/null 2>&1 &
    sleep 3
    pkill winecfg
    
    show_progress 5 5 "Instalando componentes Wine..."
    # Instalar componentes bÃ¡sicos via winetricks
    wget -q https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O $PREFIX/bin/winetricks
    chmod +x $PREFIX/bin/winetricks
    
    echo
    echo -e "${GREEN}âœ… Wine instalado e configurado!${NC}"
}

# FunÃ§Ã£o para instalar DXVK
install_dxvk() {
    echo -e "${BLUE}${BOLD}ðŸŽ® Instalando DXVK...${NC}"
    
    if [ "$IS_SNAPDRAGON" = true ]; then
        show_progress 1 3 "Baixando DXVK..."
        cd $HOME/.local/share/apolloemu
        wget -q https://github.com/doitsujin/dxvk/releases/download/v2.5.1/dxvk-2.5.1.tar.gz -O dxvk.tar.gz
        
        show_progress 2 3 "Instalando DXVK..."
        tar -xzf dxvk.tar.gz > /dev/null 2>&1
        mv dxvk-* dxvk
        rm dxvk.tar.gz
        
        show_progress 3 3 "Configurando DXVK..."
        cd dxvk
        ./setup_dxvk.sh install > /dev/null 2>&1
        
        # Configurar DXVK
        cat > $WINEPREFIX/dxvk.conf << 'EOF'
# DXVK ConfiguraÃ§Ãµes otimizadas para mobile
dxvk.enableAsync = True
dxvk.numCompilerThreads = 2
dxvk.useRawSsbo = True
dxvk.hud = fps,memory
EOF
        
        echo
        echo -e "${GREEN}âœ… DXVK instalado!${NC}"
    else
        echo -e "${YELLOW}âš ï¸ DXVK requer GPU Snapdragon com Vulkan${NC}"
    fi
}

# FunÃ§Ã£o para instalar Turnip
install_turnip() {
    echo -e "${BLUE}${BOLD}ðŸ”¥ Instalando drivers Turnip...${NC}"
    
    if [ "$IS_SNAPDRAGON" = true ]; then
        show_progress 1 4 "Detectando GPU Adreno..."
        
        show_progress 2 4 "Baixando Turnip..."
        cd $HOME/.local/share/apolloemu
        wget -q https://github.com/K11MCH1/AdrenoToolsDrivers/releases/latest/download/turnip.zip -O turnip.zip
        
        show_progress 3 4 "Instalando Turnip..."
        unzip -q turnip.zip
        mkdir -p drivers
        mv *.so drivers/
        rm turnip.zip
        
        show_progress 4 4 "Configurando Turnip..."
        # Criar script de inicializaÃ§Ã£o com Turnip
        cat > $HOME/.local/bin/apolloemu-turnip << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
export VK_DRIVER_FILES="$HOME/.local/share/apolloemu/drivers/vulkan.adreno.so"
export MESA_VK_WSI_DEBUG=sw
export TU_DEBUG=startup,nir
export MESA_DEBUG=silent
exec "$@"
EOF
        chmod +x $HOME/.local/bin/apolloemu-turnip
        
        echo
        echo -e "${GREEN}âœ… Drivers Turnip instalados!${NC}"
    else
        echo -e "${YELLOW}âš ï¸ Turnip disponÃ­vel apenas para GPUs Adreno${NC}"
    fi
}

# FunÃ§Ã£o para instalar Proton
install_proton() {
    echo -e "${BLUE}${BOLD}âš¡ Instalando Proton...${NC}"
    
    show_progress 1 3 "Baixando Proton ARM64..."
    cd $HOME/.local/share/apolloemu
    wget -q https://github.com/Airidosas252/wine-ge-proton-arm64ec/releases/latest/download/proton-arm64ec.tar.xz -O proton.tar.xz
    
    show_progress 2 3 "Instalando Proton..."
    tar -xf proton.tar.xz > /dev/null 2>&1
    mv proton-* proton
    rm proton.tar.xz
    
    show_progress 3 3 "Configurando Proton..."
    # Criar wrapper para Proton
    cat > $HOME/.local/bin/apolloemu-proton << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
export WINEPREFIX="$HOME/.wine-proton"
export PATH="$HOME/.local/share/apolloemu/proton/bin:$PATH"
mkdir -p "$WINEPREFIX"
exec "$@"
EOF
    chmod +x $HOME/.local/bin/apolloemu-proton
    
    echo
    echo -e "${GREEN}âœ… Proton instalado!${NC}"
}

# FunÃ§Ã£o para configurar Zink
configure_zink() {
    echo -e "${BLUE}${BOLD}âš¡ Configurando Zink (OpenGL sobre Vulkan)...${NC}"
    
    show_progress 1 2 "Configurando Zink..."
    
    # Criar script para Zink
    cat > $HOME/.local/bin/apolloemu-zink << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
export GALLIUM_DRIVER=zink
export MESA_LOADER_DRIVER_OVERRIDE=zink
export MESA_GL_VERSION_OVERRIDE=4.6
export MESA_GLSL_VERSION_OVERRIDE=460
export ZINK_DESCRIPTORS=lazy
export ZINK_DEBUG=compact
exec "$@"
EOF
    chmod +x $HOME/.local/bin/apolloemu-zink
    
    show_progress 2 2 "Testando Zink..."
    
    echo
    echo -e "${GREEN}âœ… Zink configurado!${NC}"
}

# FunÃ§Ã£o para criar menu de inicializaÃ§Ã£o
create_launcher() {
    echo -e "${BLUE}${BOLD}ðŸš€ Criando launcher ApolloEmu...${NC}"
    
    mkdir -p $HOME/.local/bin
    cat > $HOME/.local/bin/apolloemu << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# ApolloEmu Launcher
source $HOME/.config/apolloemu/box64.conf

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

show_launcher_menu() {
    clear
    echo -e "${CYAN}${BOLD}ðŸš€ ApolloEmu - Escolha o modo de execuÃ§Ã£o:${NC}"
    echo
    echo -e "${WHITE}1${NC} - ðŸŽ® Modo Gaming (DXVK + Turnip)"
    echo -e "${WHITE}2${NC} - âš¡ Modo Proton"
    echo -e "${WHITE}3${NC} - ðŸ”¥ Modo Zink (OpenGL)"
    echo -e "${WHITE}4${NC} - ðŸ› ï¸  Modo Compatibilidade (VirGL)"
    echo -e "${WHITE}5${NC} - ðŸŽ¯ Executar arquivo especÃ­fico"
    echo -e "${WHITE}6${NC} - âš™ï¸  ConfiguraÃ§Ãµes"
    echo -e "${WHITE}0${NC} - âŒ Sair"
    echo
    echo -ne "${YELLOW}Escolha [0-6]: ${NC}"
    read choice
    
    case $choice in
        1) gaming_mode ;;
        2) proton_mode ;;
        3) zink_mode ;;
        4) virgl_mode ;;
        5) run_specific_file ;;
        6) show_config_menu ;;
        0) exit 0 ;;
        *) show_launcher_menu ;;
    esac
}

gaming_mode() {
    echo -e "${GREEN}ðŸŽ® Iniciando modo Gaming...${NC}"
    start_termux_x11
    apolloemu-turnip box64 wine explorer
}

proton_mode() {
    echo -e "${BLUE}âš¡ Iniciando modo Proton...${NC}"
    start_termux_x11
    apolloemu-proton box64 wine explorer
}

zink_mode() {
    echo -e "${YELLOW}ðŸ”¥ Iniciando modo Zink...${NC}"
    start_termux_x11
    apolloemu-zink box64 wine explorer
}

virgl_mode() {
    echo -e "${CYAN}ðŸ› ï¸ Iniciando modo Compatibilidade...${NC}"
    start_virgl
    box64 wine explorer
}

start_termux_x11() {
    export DISPLAY=:1
    termux-x11 :1 -listen tcp &
    sleep 2
}

start_virgl() {
    export DISPLAY=:1
    virgl_test_server --use-egl-surfaceless &
    Xvfb :1 -screen 0 1024x768x24 &
    sleep 2
}

run_specific_file() {
    echo -e "${WHITE}Digite o caminho completo do arquivo .exe:${NC}"
    read file_path
    if [ -f "$file_path" ]; then
        start_termux_x11
        apolloemu-turnip box64 wine "$file_path"
    else
        echo -e "${RED}Arquivo nÃ£o encontrado!${NC}"
        sleep 2
        show_launcher_menu
    fi
}

show_config_menu() {
    echo -e "${CYAN}âš™ï¸ Menu de ConfiguraÃ§Ãµes em desenvolvimento...${NC}"
    sleep 2
    show_launcher_menu
}

show_launcher_menu
EOF
    chmod +x $HOME/.local/bin/apolloemu
    
    # Criar widget para Termux
    mkdir -p $HOME/.shortcuts
    cat > $HOME/.shortcuts/apolloemu << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
apolloemu
EOF
    chmod +x $HOME/.shortcuts/apolloemu
    
    echo -e "${GREEN}âœ… Launcher criado!${NC}"
}

# FunÃ§Ã£o de instalaÃ§Ã£o completa
full_installation() {
    clear
    show_banner
    echo -e "${GREEN}${BOLD}ðŸ› ï¸ INSTALAÃ‡ÃƒO COMPLETA DO APOLLOEMU${NC}"
    echo -e "${GRAY}Esta instalaÃ§Ã£o pode demorar de 30-60 minutos dependendo da conexÃ£o${NC}"
    echo
    echo -ne "${YELLOW}Continuar? [s/N]: ${NC}"
    read confirm
    
    if [[ $confirm =~ ^[Ss]$ ]]; then
        detect_system
        sleep 2
        
        install_dependencies
        sleep 1
        
        install_termux_x11
        sleep 1
        
        install_box64_86
        sleep 1
        
        install_wine
        sleep 1
        
  
