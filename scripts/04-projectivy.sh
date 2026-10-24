#!/bin/bash
# Instala o Projectivy Launcher (releases oficiais do autor no GitHub) e ativa o serviço
# de acessibilidade que permite a ele assumir o botão Home.
source "$(dirname "$0")/comum.sh"
APK="$RAIZ/.cache/projectivy.apk"; mkdir -p "$RAIZ/.cache"
URL=$(curl -fsSL https://api.github.com/repos/spocky/miproja1/releases/latest \
  | grep -o '"browser_download_url": *"[^"]*\.apk"' | head -1 | sed 's/.*"\(http[^"]*\)"/\1/')
[ -z "$URL" ] && { echo "Não encontrei o APK na página de releases."; exit 1; }
echo "Baixando $URL"; curl -fL -o "$APK" "$URL" || exit 1
adb -s "$DEV" install -r "$APK" || exit 1
S settings put secure enabled_accessibility_services \
  com.spocky.projengmenu/com.spocky.projengmenu.services.ProjectivyAccessibilityService
S settings put secure accessibility_enabled 1
echo
echo "Instalado. Agora, NA TV:"
echo "  1. Abra o Projectivy (Apps) e conclua o assistente."
echo "  2. Configurações > Geral > ligue 'Sobrepor o launcher atual'."
echo "Para desfazer: desligue essa opção, ou: adb -s $DEV shell settings put secure enabled_accessibility_services null"
