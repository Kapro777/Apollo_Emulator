# ðŸš€ ApolloEmu - Emulador de PC Completo para Termux

## ðŸ“– DescriÃ§Ã£o

ApolloEmu Ã© um script completo e automatizado que transforma seu Android em um poderoso emulador de PC usando Termux. Com interface bonita e instalaÃ§Ã£o totalmente automatizada, inclui todos os componentes necessÃ¡rios para executar aplicaÃ§Ãµes e jogos Windows no seu dispositivo mÃ³vel.

## âœ¨ CaracterÃ­sticas Principais

### ðŸŽ¯ Componentes Inclusos
- **Box64/Box86** - EmulaÃ§Ã£o de instruÃ§Ãµes x86/x64 para ARM
- **Wine** - Camada de compatibilidade Windows/Linux  
- **DXVK** - DirectX 11/10/9 sobre Vulkan para GPUs Snapdragon
- **Turnip** - Driver Vulkan otimizado para GPUs Adreno
- **Proton** - VersÃ£o otimizada do Wine da Valve
- **Zink** - OpenGL sobre Vulkan para mÃ¡xima compatibilidade
- **VirGL** - RenderizaÃ§Ã£o acelerada por hardware
- **Mesa** - Drivers grÃ¡ficos open-source
- **Termux-X11** - Interface grÃ¡fica nativa

### ðŸ–¥ï¸ Interface Inteligente
- Menu colorido e intuitivo com emojis
- DetecÃ§Ã£o automÃ¡tica de hardware
- Barra de progresso em tempo real
- Suporte a whiptail para menus grÃ¡ficos
- Sistema de fallback para texto puro

### âš¡ Modos de ExecuÃ§Ã£o
1. **Modo Gaming** - DXVK + Turnip para mÃ¡ximo desempenho
2. **Modo Proton** - Compatibilidade otimizada com jogos
3. **Modo Zink** - OpenGL sobre Vulkan
4. **Modo Compatibilidade** - VirGL para hardware nÃ£o-Snapdragon

## ðŸ“± Requisitos do Sistema

### MÃ­nimos
- **Android:** 10+ (recomendado 12+)
- **Arquitetura:** ARM64 (aarch64)
- **Armazenamento:** 4GB livres (recomendado 8GB+)
- **RAM:** 4GB+ (recomendado 6GB+)

### Recomendados para Melhor ExperiÃªncia
- **SOC:** Snapdragon 855+ ou equivalente
- **GPU:** Adreno 640+ (para DXVK/Turnip)
- **Android:** 12+ sem root
- **Armazenamento:** 8GB+ livres

### Compatibilidade de GPU
| GPU | DXVK | Turnip | VirGL | Zink |
|-----|------|--------|-------|------|
| Adreno 610+ | âœ… | âœ… | âœ… | âœ… |
| Mali | âŒ | âŒ | âœ… | âš ï¸ |
| PowerVR | âŒ | âŒ | âœ… | âŒ |

## ðŸ› ï¸ InstalaÃ§Ã£o

### InstalaÃ§Ã£o RÃ¡pida
```bash
# Baixar e executar o script
curl -o apolloemu.sh https://raw.githubusercontent.com/apolloemu/installer/main/apolloemu-installer.sh
chmod +x apolloemu.sh
./apolloemu.sh
```

### InstalaÃ§Ã£o Manual
1. Instalar Termux da F-Droid (nÃ£o Google Play)
2. Instalar Termux-X11 APK
3. Baixar o script ApolloEmu
4. Executar instalaÃ§Ã£o completa

### AplicaÃ§Ãµes Complementares
- **Termux** - F-Droid (obrigatÃ³rio)
- **Termux-X11** - GitHub releases (obrigatÃ³rio)
- **InputBridge v0.1.9** - Controles na tela
- **Termux:Widget** - Widgets na tela inicial

## ðŸŽ® Como Usar

### Primeiro Uso
1. Execute `apolloemu` no Termux
2. Escolha o modo de execuÃ§Ã£o apropriado
3. Aguarde inicializaÃ§Ã£o do ambiente grÃ¡fico
4. Instale aplicaÃ§Ãµes via Wine ou copy para `/sdcard`

### Executar AplicaÃ§Ãµes
```bash
# Via launcher integrado
apolloemu

# Direto via linha de comando
apolloemu-turnip box64 wine programa.exe

# Com Proton
apolloemu-proton box64 wine jogo.exe
```

### ConfiguraÃ§Ãµes AvanÃ§adas

#### OtimizaÃ§Ãµes Box64
Arquivo: `~/.config/apolloemu/box64.conf`
```bash
# Desempenho otimizado
export BOX64_DYNAREC_STRONGMEM=1
export BOX64_DYNAREC_BIGBLOCK=1
export BOX64_DYNAREC_FORWARD=512
export BOX64_PREFER_WRAPPED=1
```

#### ConfiguraÃ§Ãµes DXVK
Arquivo: `~/.wine/dxvk.conf`
```ini
# Performance mobile
dxvk.enableAsync = True
dxvk.numCompilerThreads = 2
dxvk.useRawSsbo = True
dxvk.hud = fps,memory
```

#### VariÃ¡veis de Ambiente
```bash
# Turnip + DXVK
export VK_DRIVER_FILES="$HOME/.local/share/apolloemu/drivers/vulkan.adreno.so"
export MESA_VK_WSI_DEBUG=sw

# Zink OpenGL
export GALLIUM_DRIVER=zink
export MESA_GL_VERSION_OVERRIDE=4.6

# VirGL Fallback
export MESA_LOADER_DRIVER_OVERRIDE=virpipe
export GALLIUM_DRIVER=virpipe
```

## ðŸŽ¯ Jogos e AplicaÃ§Ãµes Testadas

### âœ… Funcionando Bem (Snapdragon)
- **Grand Theft Auto:** Vice City, San Andreas
- **Call of Duty:** 1, 2, 4 Modern Warfare
- **Portal:** 1, 2
- **Half-Life:** 1, 2, Episodes
- **Age of Empires:** II, III
- **Civilization:** IV, V
- **Counter-Strike:** 1.6, Source
- **Team Fortress:** 2
- **Tomb Raider:** 2013, Rise of

### âš ï¸ Parcialmente Funcionando
- **GTA V** - Requer configuraÃ§Ã£o especÃ­fica
- **Skyrim** - Performance limitada
- **Fallout:** 3, New Vegas - Mods necessÃ¡rios

### âŒ NÃ£o Recomendado
- Jogos DirectX 12
- Jogos que requerem >4GB RAM
- Jogos com anti-cheat

## ðŸ”§ SoluÃ§Ã£o de Problemas

### Problemas Comuns

#### "Signal 9 - Process Completed"
```bash
# Desabilitar Android Phantom Process Killer
adb shell "cmd device_config put activity_manager max_phantom_processes 2147483647"
```

#### Performance Baixa
1. Usar modo Gaming com DXVK
2. Reduzir resoluÃ§Ã£o da tela
3. Fechar outras aplicaÃ§Ãµes
4. Ativar modo performance do Android

#### AplicaÃ§Ãµes nÃ£o Abrem
1. Verificar arquitetura (precisa ser x86/x64)
2. Instalar dependÃªncias via winetricks
3. Testar diferentes modos de execuÃ§Ã£o
4. Verificar logs do Wine

#### Erro de GPU/Vulkan
```bash
# Testar Vulkan
vulkaninfo

# ForÃ§ar software rendering
export MESA_LOADER_DRIVER_OVERRIDE=llvmpipe
```

### Logs e DepuraÃ§Ã£o
```bash
# Ativar logs detalhados
export BOX64_LOG=2
export WINEDEBUG=+all
export DXVK_LOG_LEVEL=debug

# Verificar status dos componentes
apolloemu status
```

## ðŸ”„ AtualizaÃ§Ã£o

O ApolloEmu inclui sistema de atualizaÃ§Ã£o automÃ¡tica:
```bash
# Via menu
apolloemu â†’ OpÃ§Ã£o 8

# Via linha de comando  
apolloemu --update
```

## ðŸ¤ Suporte e Comunidade

### Canais Oficiais
- **Discord:** https://discord.gg/apolloemu
- **Telegram:** @apolloemu_br
- **GitHub:** https://github.com/apolloemu/apolloemu
- **Reddit:** r/ApolloEmu

### ContribuiÃ§Ã£o
ContribuiÃ§Ãµes sÃ£o bem-vindas! Areas que precisam de ajuda:
- Testes em diferentes dispositivos
- OtimizaÃ§Ãµes de performance
- DocumentaÃ§Ã£o e tutoriais
- TraduÃ§Ã£o para outros idiomas

## ðŸ“„ LicenÃ§as

Este projeto utiliza componentes com diferentes licenÃ§as:
- **Box64/Box86:** MIT License
- **Wine:** GNU Lesser General Public License
- **DXVK:** zlib/libpng License
- **Mesa:** MIT/X11 License
- **ApolloEmu Script:** GPL-3.0 License

## âš¡ Performance Esperada

### Snapdragon 8 Gen 2+ (Flagship)
- **Jogos 2D/Indie:** 60 FPS estÃ¡veis
- **Jogos 3D Leves:** 30-60 FPS
- **Jogos 3D MÃ©dios:** 20-45 FPS
- **Emuladores:** Performance excelente

### Snapdragon 7 Gen 1/2 (Mid-range)
- **Jogos 2D/Indie:** 45-60 FPS
- **Jogos 3D Leves:** 20-40 FPS
- **Jogos 3D MÃ©dios:** 15-30 FPS

### GPUs NÃ£o-Snapdragon
- **Jogos 2D/Indie:** 30-45 FPS (VirGL)
- **Jogos 3D:** Performance limitada
- **Recomendado:** Jogos mais antigos

## ðŸ”® Roadmap

### v2.1 (PrÃ³xima)
- [ ] Interface grÃ¡fica nativa (GUI)
- [ ] Instalador de jogos automatizado  
- [ ] Profiles de configuraÃ§Ã£o por jogo
- [ ] Sistema de mods integrado

### v2.2 (Futuro)
- [ ] Suporte a DirectX 12
- [ ] EmulaÃ§Ã£o de controles mais avanÃ§ada
- [ ] Streaming de jogos local
- [ ] Suporte a GPUs Mali melhorado

## â¤ï¸ Agradecimentos

Agradecimentos especiais aos projetos e desenvolvedores:
- **ptitSeb** - Box64/Box86
- **Ilya114** - Box64Droid
- **Wine Team** - Wine Project  
- **Valve** - Proton/DXVK
- **Mesa Team** - Drivers Mesa
- **Termux Team** - Termux
- **Comunidade Android** - Testes e feedback

---

*ApolloEmu - Transformando Android em PC Gaming desde 2025* ðŸš€
