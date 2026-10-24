#!/bin/bash
# Funções compartilhadas pelos scripts. O IP do Fire Stick vem de FIRE_IP, do arquivo .fire_ip
# (gravado na primeira execução) ou é perguntado. IP em: Configurações > Meu Fire TV > Sobre > Rede.
RAIZ="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

[ -z "$FIRE_IP" ] && [ -f "$RAIZ/.fire_ip" ] && FIRE_IP=$(cat "$RAIZ/.fire_ip")
if [ -z "$FIRE_IP" ]; then
  read -p "IP do Fire Stick (ex.: 192.168.0.50): " FIRE_IP
  [ -z "$FIRE_IP" ] && exit 1
fi
echo "$FIRE_IP" > "$RAIZ/.fire_ip"
DEV="${FIRE_IP%:5555}:5555"

command -v adb >/dev/null || { echo "ADB não encontrado. macOS: brew install --cask android-platform-tools | Linux: sudo apt install adb"; exit 1; }
adb connect "$DEV" >/dev/null 2>&1; sleep 2
adb -s "$DEV" get-state >/dev/null 2>&1 || { echo "Sem conexão com $DEV. Ative 'Depuração ADB' na TV e aceite o pedido que aparece na tela."; exit 1; }

# </dev/null é obrigatório: sem ele o 'adb shell' consome o stdin e os laços 'while read' param no 1º item
S() { adb -s "$DEV" shell "$@" </dev/null 2>&1 | tr -d '\r'; }

# Lê uma lista ignorando comentários (#) e linhas vazias
pacotes() { sed 's/#.*//' "$1" | tr -d ' \t\r' | grep -v '^$'; }
