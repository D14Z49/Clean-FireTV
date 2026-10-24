#!/bin/bash
# Tira um print da TV (útil para pedir ajuda). Salva tela-tv.png na pasta do projeto.
source "$(dirname "$0")/comum.sh"
S screencap -p /sdcard/tela-tv.png >/dev/null
adb -s "$DEV" pull /sdcard/tela-tv.png "$RAIZ/tela-tv.png" >/dev/null && S rm /sdcard/tela-tv.png >/dev/null
echo "Print salvo em $RAIZ/tela-tv.png (Netflix e outros apps com DRM saem pretos)"
