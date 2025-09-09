#!/data/data/com.termux/files/usr/bin/bash
#
# ApolloEmu - ConfiguraÃ§Ãµes AvanÃ§adas e UtilitÃ¡rios
# Este arquivo complementa o script principal com funcionalidades extras
#

# ConfiguraÃ§Ãµes especÃ­ficas para diferentes jogos
setup_game_profiles() {
    mkdir -p "$HOME/.config/apolloemu/profiles"
    
    # Profile para GTA Vice City
    cat > "$HOME/.config/apolloemu/profiles/gta_vc.conf" << 'EOF'
# GTA Vice City - ConfiguraÃ§Ãµes otimizadas
export BOX64_DYNAREC_STRONGMEM=2
export BOX64_DYNAREC_X87DOUBLE=1
export BOX64_DYNAREC_FASTNAN=1
export DXVK_HUD=fps,memory,drawcalls
export DXVK_FRAME_RATE=60
export MESA_GL_VERSION_OVERRIDE=3.3
export GALLIUM_HUD=fps,cpu,gpu-load
EOF

    # Profile para jogos DirectX 9
    cat > "$HOME/.config/apolloemu/profiles/dx9_games.conf" << 'EOF'
# DirectX 9 Games - ConfiguraÃ§Ã£o geral
export BOX64_DYNAREC_STRONGMEM=1
export BOX64_DYNAREC_BIGBLOCK=3
export DXVK_ASYNC=1
export DXVK_STATE_CACHE=1
export D3D_FEATURE_LEVEL=9_3
export MESA_GL_VERSION_OVERRIDE=4.3
EOF

    # Profile para emuladores
    cat > "$HOME/.config/apolloemu/profiles/emulators.conf" << 'EOF'
# Emuladores - Performance mÃ¡xima
export BOX64_DYNAREC_STRONGMEM=0
export BOX64_DYNAREC_BIGBLOCK=1
export BOX64_DYNAREC_FORWARD=128
export MESA_GL_VERSION_OVERRIDE=4.6
export GALLIUM_DRIVER=zink
EOF

    # Profile para jogos 2D
    cat > "$HOME/.config/apolloemu/profiles/games_2d.conf" << 'EOF'
# Jogos 2D - ConfiguraÃ§Ã£o leve
export BOX64_DYNAREC_STRONGMEM=1
export BOX64_DYNAREC_BIGBLOCK=2
export DXVK_HUD=fps
export MESA_GL_VERSION_OVERRIDE=2.1
EOF

    echo "âœ… Profiles de jogos criados em ~/.config/apolloemu/profiles/"
}

# Sistema de otimizaÃ§Ã£o automÃ¡tica baseado no hardware
auto_optimize() {
    local ram_gb=$(free -g | awk 'NR==2{print $2}')
    local cpu_cores=$(nproc)
    local gpu_vendor=$(getprop ro.hardware.vulkan)
    
    echo "ðŸ”§ Configurando otimizaÃ§Ãµes para seu hardware..."
    
    # OtimizaÃ§Ãµes baseadas na RAM
    if [ "$ram_gb" -ge 8 ]; then
        export BOX64_DYNAREC_BIGBLOCK=3
        export BOX64_DYNAREC_FORWARD=1024
        echo "âœ… ConfiguraÃ§Ã£o HIGH-END ativada (8GB+ RAM)"
    elif [ "$ram_gb" -ge 6 ]; then
        export BOX64_DYNAREC_BIGBLOCK=2
        export BOX64_DYNAREC_FORWARD=512
        echo "âœ… ConfiguraÃ§Ã£o MID-RANGE ativada (6GB RAM)"
    else
        export BOX64_DYNAREC_BIGBLOCK=1
        export BOX64_DYNAREC_FORWARD=256
        echo "âœ… ConfiguraÃ§Ã£o LOW-END ativada (<6GB RAM)"
    fi
    
    # OtimizaÃ§Ãµes baseadas no CPU
    if [ "$cpu_cores" -ge 8 ]; then
        export DXVK_NUM_COMPILER_THREADS=4
        export BOX64_DYNAREC_THREADS=4
    elif [ "$cpu_cores" -ge 4 ]; then
        export DXVK_NUM_COMPILER_THREADS=2
        export BOX64_DYNAREC_THREADS=2
    else
        export DXVK_NUM_COMPILER_THREADS=1
        export BOX64_DYNAREC_THREADS=1
    fi
    
    # Salvar configuraÃ§Ãµes
    cat > "$HOME/.config/apolloemu/auto_config.conf" << EOF
# ConfiguraÃ§Ã£o automÃ¡tica baseada no hardware
export BOX64_DYNAREC_BIGBLOCK=$BOX64_DYNAREC_BIGBLOCK
export BOX64_DYNAREC_FORWARD=$BOX64_DYNAREC_FORWARD
export DXVK_NUM_COMPILER_THREADS=$DXVK_NUM_COMPILER_THREADS
export BOX64_DYNAREC_THREADS=$BOX64_DYNAREC_THREADS
EOF
}

# Instalador de jogos populares
install_popular_games() {
    echo "ðŸŽ® Instalador de Jogos Populares"
    echo
    echo "1 - Grand Theft Auto: Vice City"
    echo "2 - Portal"
    echo "3 - Half-Life 2"
    echo "4 - Age of Empires II"
    echo "5 - OpenTTD (Gratuito)"
    echo "6 - SuperTux Kart (Gratuito)"
    echo "0 - Voltar"
    echo
    echo -n "Escolha [0-6]: "
    read game_choice
    
    case $game_choice in
        5) install_openttd ;;
        6) install_supertuxkart ;;
        *) echo "âš ï¸ Para jogos comerciais, copie os arquivos para /sdcard/Games/" ;;
    esac
}

# Instalar OpenTTD
install_openttd() {
    echo "ðŸ“¦ Instalando OpenTTD..."
    cd /tmp
    wget -q https://cdn.openttd.org/openttd-releases/13.4/openttd-13.4-windows-win64.zip
    unzip -q openttd-13.4-windows-win64.zip
    mkdir -p "$HOME/Games"
    mv openttd-13.4-windows-win64 "$HOME/Games/OpenTTD"
    rm openttd-13.4-windows-win64.zip
    
    # Criar launcher
    cat > "$HOME/Games/OpenTTD/run.sh" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
cd "$HOME/Games/OpenTTD"
apolloemu-turnip box64 wine openttd.exe
EOF
    chmod +x "$HOME/Games/OpenTTD/run.sh"
    echo "âœ… OpenTTD instalado! Execute: $HOME/Games/OpenTTD/run.sh"
}

# Instalar SuperTuxKart
install_supertuxkart() {
    echo "ðŸ“¦ Instalando SuperTuxKart..."
    mkdir -p "$HOME/Games"
    cd "$HOME/Games"
    
    # Baixar versÃ£o ARM nativa (melhor performance)
    wget -q https://github.com/supertuxkart/stk-code/releases/latest/download/SuperTuxKart-android-arm64-v8a.apk
    echo "âš ï¸ SuperTuxKart baixado como APK. Instale manualmente no Android."
    echo "Para versÃ£o Windows via emulaÃ§Ã£o, baixe de: https://supertuxkart.net/Download"
}

# Benchmark e teste de performance
run_benchmarks() {
    echo "ðŸ Executando benchmarks..."
    
    # Teste de Box64
    echo "ðŸ“Š Testando Box64..."
    time box64 --version > /dev/null
    
    # Teste de Wine
    echo "ðŸ· Testando Wine..."
    time wine --version > /dev/null
    
    # Teste de Vulkan (se disponÃ­vel)
    if command -v vulkaninfo >/dev/null; then
        echo "ðŸ”¥ Testando Vulkan..."
        vulkaninfo --summary | grep -E "(deviceName|apiVersion)"
    fi
    
    # Teste de OpenGL
    echo "ðŸŽ¨ Testando OpenGL..."
    glxinfo | grep -E "(OpenGL version|OpenGL renderer)"
    
    # Teste de DirectX via DXVK
    echo "ðŸŽ® Testando DXVK..."
    if [ -f "$HOME/.wine/drive_c/windows/system32/d3d11.dll" ]; then
        echo "âœ… DXVK instalado"
    else
        echo "âŒ DXVK nÃ£o encontrado"
    fi
}

# Monitor de performance em tempo real
performance_monitor() {
    echo "ðŸ“Š Monitor de Performance - Pressione Ctrl+C para sair"
    echo "Timestamp,CPU%,RAM%,GPU_Load,FPS" > /tmp/apolloemu_perf.csv
    
    while true; do
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
        ram_usage=$(free | awk 'FNR==2{printf "%.0f", $3/($3+$4)*100}')
        gpu_load=$(cat /sys/class/kgsl/kgsl-3d0/gpubusy 2>/dev/null | cut -d' ' -f1 || echo "0")
        timestamp=$(date '+%H:%M:%S')
        
        echo "$timestamp,$cpu_usage,$ram_usage,$gpu_load,?" >> /tmp/apolloemu_perf.csv
        printf "\rðŸ”„ CPU: %s%% | RAM: %s%% | GPU: %s%% | Time: %s" "$cpu_usage" "$ram_usage" "$gpu_load" "$timestamp"
        
        sleep 1
    done
}

# Limpeza e manutenÃ§Ã£o do sistema
system_cleanup() {
    echo "ðŸ§¹ Executando limpeza do sistema..."
    
    # Limpar cache do Wine
    echo "ðŸ· Limpando cache do Wine..."
    rm -rf "$HOME/.wine/drive_c/users/*/Temp/*" 2>/dev/null
    rm -rf "$HOME/.wine/drive_c/windows/Temp/*" 2>/dev/null
    
    # Limpar cache do DXVK
    echo "ðŸŽ® Limpando cache do DXVK..."
    rm -rf "$HOME/.cache/dxvk_state_cache/*" 2>/dev/null
    
    # Limpar logs antigos
    echo "ðŸ“ Limpando logs..."
    find /tmp -name "*apolloemu*" -type f -mtime +7 -delete 2>/dev/null
    
    # Limpar downloads temporÃ¡rios
    echo "ðŸ“¦ Limpando downloads temporÃ¡rios..."
    rm -rf /tmp/*.deb /tmp/*.tar.* /tmp/*.zip 2>/dev/null
    
    # Otimizar banco de dados do Wine
    echo "ðŸ”§ Otimizando Wine..."
    wineserver --kill 2>/dev/null
    
    echo "âœ… Limpeza concluÃ­da!"
}

# Backup e restore de configuraÃ§Ãµes
backup_config() {
    local backup_file="$HOME/apolloemu_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
    
    echo "ðŸ’¾ Criando backup das configuraÃ§Ãµes..."
    tar -czf "$backup_file" \
        "$HOME/.config/apolloemu" \
        "$HOME/.wine" \
        "$HOME/.local/share/apolloemu" \
        "$HOME/.local/bin/apolloemu*" 2>/dev/null
    
    echo "âœ… Backup criado: $backup_file"
}

restore_config() {
    echo "ðŸ“‹ Backups disponÃ­veis:"
    ls -la "$HOME"/apolloemu_backup_*.tar.gz 2>/dev/null | awk '{print NR": "$9" ("$5" bytes, "$6" "$7")"}'
    
    echo -n "Digite o nÃºmero do backup para restaurar: "
    read backup_num
    
    backup_file=$(ls -1 "$HOME"/apolloemu_backup_*.tar.gz 2>/dev/null | sed -n "${backup_num}p")
    
    if [ -n "$backup_file" ]; then
        echo "ðŸ”„ Restaurando backup: $backup_file"
        tar -xzf "$backup_file" -C / 2>/dev/null
        echo "âœ… Backup restaurado com sucesso!"
    else
        echo "âŒ Backup nÃ£o encontrado!"
    fi
}

# ConfiguraÃ§Ãµes de rede para jogos online
setup_network_gaming() {
    echo "ðŸŒ Configurando otimizaÃ§Ãµes de rede para jogos..."
    
    # Configurar TCP/IP para gaming
    cat > "$HOME/.config/apolloemu/network.conf" << 'EOF'
# OtimizaÃ§Ãµes de rede para jogos
export WINE_NET_BUFFER_SIZE=65536
export WINE_NET_KEEPALIVE=1
export WINE_TCP_NODELAY=1
export WINE_SOCKET_BUFFER_SIZE=262144
EOF

    # Script para ajustar latÃªncia
    cat > "$HOME/.local/bin/apolloemu-lowping" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
# ConfiguraÃ§Ãµes para reduzir latÃªncia
echo "ðŸš€ Ativando modo low-ping..."
echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null
echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor 2>/dev/null
echo "performance" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor 2>/dev/null
echo "performance" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor 2>/dev/null
source "$HOME/.config/apolloemu/network.conf"
exec "$@"
EOF
    chmod +x "$HOME/.local/bin/apolloemu-lowping"
    
    echo "âœ… ConfiguraÃ§Ãµes de rede aplicadas!"
    echo "ðŸ’¡ Use: apolloemu-lowping <comando> para jogos online"
}

# Sistema de logs detalhado
setup_logging() {
    mkdir -p "$HOME/.local/share/apolloemu/logs"
    
    cat > "$HOME/.local/bin/apolloemu-debug" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
# Sistema de debug avanÃ§ado do ApolloEmu

LOG_DIR="$HOME/.local/share/apolloemu/logs"
LOG_FILE="$LOG_DIR/debug_$(date +%Y%m%d_%H%M%S).log"

mkdir -p "$LOG_DIR"

echo "ðŸ” Iniciando debug mode - Log: $LOG_FILE"
echo "Timestamp: $(date)" > "$LOG_FILE"
echo "System Info:" >> "$LOG_FILE"
echo "  Android: $(getprop ro.build.version.release)" >> "$LOG_FILE"
echo "  SOC: $(getprop ro.hardware)" >> "$LOG_FILE"
echo "  RAM: $(free -h | awk 'NR==2{printf "%s", $2}')" >> "$LOG_FILE"
echo "  Architecture: $(uname -m)" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# VariÃ¡veis de debug
export BOX64_LOG=2
export BOX64_SHOWSEGV=1
export WINEDEBUG=+all
export DXVK_LOG_LEVEL=debug
export MESA_DEBUG=1

# Executar comando com logs
exec "$@" 2>&1 | tee -a "$LOG_FILE"
EOF
    chmod +x "$HOME/.local/bin/apolloemu-debug"
    
    echo "âœ… Sistema de logging configurado!"
    echo "ðŸ’¡ Use: apolloemu-debug <comando> para debug detalhado"
}

# Menu principal dos utilitÃ¡rios
main_utils_menu() {
    while true; do
        clear
        echo -e "${CYAN}${BOLD}ðŸ”§ ApolloEmu - UtilitÃ¡rios AvanÃ§ados${NC}"
        echo
        echo -e "${WHITE}1${NC} - ðŸŽ¯ Configurar Profiles de Jogos"
        echo -e "${WHITE}2${NC} - âš¡ Auto-OtimizaÃ§Ã£o de Hardware"
        echo -e "${WHITE}3${NC} - ðŸŽ® Instalar Jogos Populares"
        echo -e "${WHITE}4${NC} - ðŸ Executar Benchmarks"
        echo -e "${WHITE}5${NC} - ðŸ“Š Monitor de Performance"
        echo -e "${WHITE}6${NC} - ðŸ§¹ Limpeza e ManutenÃ§Ã£o"
        echo -e "${WHITE}7${NC} - ðŸ’¾ Backup/Restore ConfiguraÃ§Ãµes"
        echo -e "${WHITE}8${NC} - ðŸŒ Configurar Rede para Gaming"
        echo -e "${WHITE}9${NC} - ðŸ” Sistema de Debug/Logs"
        echo -e "${WHITE}0${NC} - âŒ Sair"
        echo
        echo -ne "${YELLOW}Escolha [0-9]: ${NC}"
        read choice
        
        case $choice in
            1) setup_game_profiles ;;
            2) auto_optimize ;;
            3) install_popular_games ;;
            4) run_benchmarks ;;
            5) performance_monitor ;;
            6) system_cleanup ;;
            7) 
                echo "ðŸ’¾ Backup ou ðŸ”„ Restore?"
                echo "1 - Backup"
                echo "2 - Restore"
                read br_choice
                case $br_choice in
                    1) backup_config ;;
                    2) restore_config ;;
                esac
                ;;
            8) setup_network_gaming ;;
            9) setup_logging ;;
            0) exit 0 ;;
            *) echo -e "${RED}OpÃ§Ã£o invÃ¡lida!${NC}"; sleep 1 ;;
        esac
        
        echo
        echo -ne "${GREEN}Pressione Enter para continuar...${NC}"
        read
    done
}

# Cores (definir novamente para este arquivo)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Executar menu se chamado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main_utils_menu
fi
