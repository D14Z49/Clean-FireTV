#!/bin/bash
# Mostra qual app está aberto na TV agora e, após confirmação, desativa-o (reversível).
# Útil para descobrir o pacote de atalhos teimosos. Protege pacotes críticos.
# Use -y para confirmar sem perguntar (modo automático).
source "$(dirname "$0")/comum.sh"
FG=$(S dumpsys activity activities | grep -m1 ResumedActivity | grep -o '[a-z][a-z0-9_.]*/[A-Za-z0-9_.$]*' | head -1)
PKG=${FG%%/*}
echo "App na tela: ${FG:-nenhum}"
pacotes "$RAIZ/listas/nao-mexer.txt" | grep -qx "$PKG" && { echo "Esse pacote está na lista nao-mexer.txt. Nada feito."; exit 1; }
[ -z "$PKG" ] && exit 1
if [ "$1" != "-y" ]; then read -p "Desativar $PKG? [s/N] " r; [ "$r" = "s" ] || exit 0; fi
S am force-stop "$PKG" >/dev/null
r=$(S pm disable-user --user 0 "$PKG" | head -1); echo "$PKG => $r"
echo "$r" | grep -q "disabled-user" && echo "$PKG" >> "$RAIZ/desativados.log"
