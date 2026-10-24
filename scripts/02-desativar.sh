#!/bin/bash
# Desativa (pm disable-user, reversível) os pacotes de uma ou mais listas.
# Uso: FIRE_IP=192.168.0.50 bash scripts/02-desativar.sh listas/anuncios-telemetria.txt [outras listas...]
source "$(dirname "$0")/comum.sh"
[ $# -eq 0 ] && { echo "Informe ao menos uma lista. Ex.: listas/anuncios-telemetria.txt"; exit 1; }
LOG="$RAIZ/desativados.log"
for lista in "$@"; do
  [ -f "$lista" ] || { echo "Lista não encontrada: $lista"; continue; }
  echo "== $lista"
  pacotes "$lista" | while read -r p; do
    r=$(S pm disable-user --user 0 "$p" | head -1)
    echo "   $p => $r"
    echo "$r" | grep -q "disabled-user" && echo "$p" >> "$LOG"
  done
done
[ -f "$LOG" ] && sort -u "$LOG" -o "$LOG"
echo "Feito. Reinicie o Fire Stick (segure Selecionar + Play/Pause por 5 s). Para desfazer: bash scripts/03-reverter.sh"
