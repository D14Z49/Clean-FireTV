#!/bin/bash
# Reativa tudo o que 02-desativar.sh desativou (desativados.log), ou um pacote específico.
# Uso: bash scripts/03-reverter.sh            -> reativa tudo
#      bash scripts/03-reverter.sh com.amazon.x -> reativa só esse
source "$(dirname "$0")/comum.sh"
LOG="$RAIZ/desativados.log"
if [ -n "$1" ]; then S pm enable "$1"; exit; fi
[ -f "$LOG" ] || { echo "Nada a reverter ($LOG não existe)."; exit 0; }
while read -r p; do echo "   $p => $(S pm enable "$p")"; done < "$LOG"
mv "$LOG" "$LOG.revertido"
echo "Tudo reativado. Reinicie o Fire Stick."
