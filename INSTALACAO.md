# ðŸš€ ApolloEmu - Guia de InstalaÃ§Ã£o Passo a Passo

## ðŸ“‹ PrÃ©-requisitos

### 1. Preparar o Android
```bash
# Verificar arquitetura (deve ser arm64)
uname -m

# Verificar versÃ£o do Android
getprop ro.build.version.release

# Verificar espaÃ§o disponÃ­vel (mÃ­nimo 4GB)
df -h
```

### 2. Instalar AplicaÃ§Ãµes Base
1. **Termux** - OBRIGATÃ“RIO instalar da F-Droid, NÃƒO da Play Store
   - Link: https://f-droid.org/packages/com.termux/
   
2. **Termux-X11** - Para interface grÃ¡fica
   - Link: https://github.com/termux/termux-x11/releases/latest
   - Baixar: termux-x11-universal-*.apk

3. **InputBridge** - Para controles na tela (opcional)
   - VersÃ£o: 0.1.9
   - Link: GitHub releases do InputBridge

### 3. Configurar Termux
```bash
# Primeiro acesso - atualizar pacotes
pkg update && pkg upgrade -y

# Dar permissÃµes de armazenamento
termux-setup-storage

# Instalar dependÃªncias bÃ¡sicas
pkg install curl wget git -y
```

## ðŸ› ï¸ InstalaÃ§Ã£o do ApolloEmu

### MÃ©todo 1: InstalaÃ§Ã£o AutomÃ¡tica (Recomendado)
```bash
# Baixar e executar o script
curl -fsSL https://raw.githubusercontent.com/apollo-emu/installer/main/install.sh | bash
```

### MÃ©todo 2: InstalaÃ§Ã£o Manual
```bash
# Baixar o script
wget https://raw.githubusercontent.com/apollo-emu/installer/main/apolloemu-installer.sh

# Dar permissÃµes
chmod +x apolloemu-installer.sh

# Executar
./apolloemu-installer.sh
```

### MÃ©todo 3: Clone do RepositÃ³rio
```bash
# Clonar repositÃ³rio completo
git clone https://github.com/apollo-emu/apolloemu.git
cd apolloemu

# Executar instalaÃ§Ã£o
bash install.sh
```

## âš™ï¸ ConfiguraÃ§Ã£o PÃ³s-InstalaÃ§Ã£o

### 1. Configurar Termux-X11
```bash
# Abrir configuraÃ§Ãµes do Termux-X11
# Ativar:
# - Hardware acceleration
# - Use device GPU
# - DRI3 support (se disponÃ­vel)
```

### 2. Testar InstalaÃ§Ã£o
```bash
# Verificar componentes
apolloemu --status

# Teste bÃ¡sico
apolloemu --test

# Executar Wine pela primeira vez
apolloemu
# Escolher opÃ§Ã£o 3 (Iniciar ApolloEmu)
```

### 3. OtimizaÃ§Ã£o Inicial
```bash
# Executar otimizaÃ§Ã£o automÃ¡tica
apolloemu-utils
# Escolher opÃ§Ã£o 2 (Auto-OtimizaÃ§Ã£o)

# Configurar profiles para jogos especÃ­ficos
apolloemu-utils
# Escolher opÃ§Ã£o 1 (Profiles de Jogos)
```

## ðŸŽ® Instalando Seu Primeiro Jogo

### MÃ©todo 1: Copiar via Android
1. Copie arquivos do jogo para `/sdcard/Games/NomeDoJogo/`
2. Execute ApolloEmu
3. Navegue atÃ© a pasta e execute o arquivo .exe

### MÃ©todo 2: Via Wine (interno)
```bash
# Iniciar ApolloEmu
apolloemu

# No Wine, usar:
# C:\ = Wine prefix
# Z:\ = Raiz do Android (/storage/emulated/0/)
```

### MÃ©todo 3: Download Direto
```bash
# Para jogos gratuitos/demos
cd /sdcard/Games
wget [URL_DO_JOGO]
unzip arquivo.zip
```

## ðŸ”§ Comandos Importantes

### Comandos BÃ¡sicos
```bash
# Iniciar ApolloEmu
apolloemu

# Modo gaming (melhor para Snapdragon)
apolloemu-turnip box64 wine game.exe

# Modo Proton
apolloemu-proton box64 wine game.exe

# Modo compatibilidade
apolloemu-zink box64 wine game.exe

# Debug mode
apolloemu-debug box64 wine game.exe
```

### VariÃ¡veis de Ambiente Ãšteis
```bash
# Performance
export BOX64_DYNAREC_BIGBLOCK=3
export BOX64_DYNAREC_STRONGMEM=1

# DXVK
export DXVK_HUD=fps,memory
export DXVK_ASYNC=1

# Zink/OpenGL
export MESA_GL_VERSION_OVERRIDE=4.6
export GALLIUM_DRIVER=zink

# Debug
export BOX64_LOG=2
export WINEDEBUG=+all
```

## ðŸš¨ SoluÃ§Ã£o de Problemas Comuns

### Erro: "Signal 9 - Process completed"
**Causa:** Android mata processos em segundo plano
**SoluÃ§Ã£o:**
```bash
# Via ADB (PC necessÃ¡rio)
adb shell "cmd device_config put activity_manager max_phantom_processes 2147483647"

# Ou configurar manualmente:
# ConfiguraÃ§Ãµes > Sistema > OpÃ§Ãµes do desenvolvedor > Phantom Process Killer > Desabilitar
```

### Erro: "Box64 not found"
**Causa:** InstalaÃ§Ã£o incompleta
**SoluÃ§Ã£o:**
```bash
# Reinstalar Box64
pkg uninstall box64-android -y
apolloemu-installer.sh
# Escolher opÃ§Ã£o 1 (InstalaÃ§Ã£o Completa)
```

### Erro: "Wine failed to start"
**Causa:** Prefix corrompido ou faltando
**SoluÃ§Ã£o:**
```bash
# Recriar Wine prefix
rm -rf ~/.wine
winecfg
# Cancelar apÃ³s aparecer a janela
```

### Erro: "No GPU acceleration"
**Causa:** GPU nÃ£o suportada ou drivers em falta
**SoluÃ§Ã£o:**
```bash
# Para Snapdragon
apolloemu-turnip vulkaninfo

# Para outros
export MESA_LOADER_DRIVER_OVERRIDE=llvmpipe
export GALLIUM_DRIVER=llvmpipe
```

### Performance Baixa
**SoluÃ§Ãµes:**
```bash
# 1. Usar profile adequado
source ~/.config/apolloemu/profiles/dx9_games.conf

# 2. Reduzir qualidade grÃ¡fica no jogo

# 3. Fechar outras apps
# 4. Ativar modo performance:
echo performance > /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

### Controles nÃ£o Funcionam
**SoluÃ§Ãµes:**
```bash
# 1. Instalar InputBridge 0.1.9
# 2. Configurar profile no InputBridge
# 3. Usar controle USB/Bluetooth via OTG
```

### Som nÃ£o Funciona
**SoluÃ§Ãµes:**
```bash
# 1. Verificar PulseAudio
pulseaudio --start

# 2. Configurar Wine
winecfg
# Audio tab > Definir driver
```

### Jogos Crash no InÃ­cio
**Debug:**
```bash
# Executar com logs
apolloemu-debug box64 wine game.exe

# Verificar logs em:
~/.local/share/apolloemu/logs/

# Tentar different wine versions
# Instalar dependÃªncias via winetricks
```

## ðŸ“± Compatibilidade por Dispositivo

### Snapdragon 8 Gen 2+ (Flagship)
- âœ… DXVK + Turnip
- âœ… Jogos 3D modernos
- âœ… 60 FPS em jogos leves
- ðŸŽ¯ ConfiguraÃ§Ã£o recomendada: Modo Gaming

### Snapdragon 7 Gen 1/2 (Upper Mid-range)
- âœ… DXVK + Turnip
- âš ï¸ Jogos 3D com ajustes
- âœ… 30-45 FPS jogos leves
- ðŸŽ¯ ConfiguraÃ§Ã£o recomendada: Modo Gaming

### Snapdragon 6 Gen 1 / 695 (Mid-range)
- âš ï¸ DXVK limitado
- âœ… VirGL funciona bem
- âœ… Jogos 2D/clÃ¡ssicos
- ðŸŽ¯ ConfiguraÃ§Ã£o recomendada: Modo Compatibilidade

### MediaTek / Exynos
- âŒ Sem DXVK/Turnip
- âœ… VirGL apenas
- âš ï¸ Performance limitada
- ðŸŽ¯ ConfiguraÃ§Ã£o recomendada: VirGL + Zink

## ðŸ“Š Jogos Testados e Performance

### âœ… Excelente (60+ FPS)
- **2D/Indie:** Terraria, Stardew Valley, FTL
- **ClÃ¡ssicos:** Age of Empires II, Warcraft III
- **Emuladores:** PCSX2, Dolphin, PPSSPP

### âœ… Bom (30-60 FPS) - Snapdragon
- **FPS:** Counter-Strike 1.6/Source, Half-Life 2
- **RPG:** Skyrim (modded), Fallout 3/NV
- **Racing:** GTA Vice City, Need for Speed

### âš ï¸ Playable (20-30 FPS) - Snapdragon
- **Modern:** GTA V (configuraÃ§Ã£o baixa)
- **AAA Old:** Bioshock, Dead Space
- **Strategy:** Civilization V, Total War

### âŒ NÃ£o Recomendado
- **DirectX 12 only games**
- **VR Games**
- **Anti-cheat games (online)**
- **>8GB RAM requirements**

## ðŸ”„ AtualizaÃ§Ãµes e ManutenÃ§Ã£o

### Atualizar ApolloEmu
```bash
# Via script
apolloemu --update

# Manual
cd ~/apolloemu
git pull
bash install.sh
```

### ManutenÃ§Ã£o Regular
```bash
# Executar semanalmente
apolloemu-utils
# Escolher opÃ§Ã£o 6 (Limpeza e ManutenÃ§Ã£o)

# Backup mensal
apolloemu-utils
# Escolher opÃ§Ã£o 7 > 1 (Backup)
```

### Monitorar Performance
```bash
# Monitor em tempo real
apolloemu-utils
# Escolher opÃ§Ã£o 5 (Monitor de Performance)

# Benchmark
apolloemu-utils
# Escolher opÃ§Ã£o 4 (Benchmarks)
```

## ðŸ†˜ Suporte e Ajuda

### Antes de Pedir Ajuda
1. âœ… Verificar este guia completamente
2. âœ… Executar `apolloemu --status`
3. âœ… Gerar logs com `apolloemu-debug`
4. âœ… Verificar compatibilidade do dispositivo

### InformaÃ§Ãµes para Suporte
```bash
# Coletar informaÃ§Ãµes do sistema
echo "=== SYSTEM INFO ===" > ~/apollo-debug.txt
getprop ro.build.version.release >> ~/apollo-debug.txt
getprop ro.hardware >> ~/apollo-debug.txt
uname -a >> ~/apollo-debug.txt
free -h >> ~/apollo-debug.txt
apolloemu --status >> ~/apollo-debug.txt
cat ~/apollo-debug.txt
```

### Canais Oficiais
- **Discord:** https://discord.gg/apolloemu
- **Telegram:** @apolloemu_br  
- **GitHub Issues:** https://github.com/apollo-emu/apolloemu/issues
- **Reddit:** r/ApolloEmu

### Contribuir
```bash
# Reportar bugs
# Testar em diferentes dispositivos
# Melhorar documentaÃ§Ã£o
# Traduzir para outros idiomas
```

---

## ðŸ“ Checklist de InstalaÃ§Ã£o

- [ ] Android 10+ com 4GB+ RAM
- [ ] Termux instalado da F-Droid
- [ ] Termux-X11 APK instalado
- [ ] PermissÃµes de armazenamento concedidas
- [ ] Script ApolloEmu baixado
- [ ] InstalaÃ§Ã£o completa executada
- [ ] Primeiro teste realizado
- [ ] Profile otimizado configurado
- [ ] Phantom Process Killer desabilitado
- [ ] Backup das configuraÃ§Ãµes criado

**ðŸŽ‰ InstalaÃ§Ã£o Completa! Hora de jogar!** ðŸš€
