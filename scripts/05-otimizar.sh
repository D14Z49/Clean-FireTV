#!/bin/bash
# Animações em 0.5x + limpeza de cache de todos os apps. Para voltar as animações: ANIM=1 bash scripts/05-otimizar.sh
source "$(dirname "$0")/comum.sh"
V="${ANIM:-0.5}"
antes=$(S df /data | awk 'NR==2{print $4}')
for k in window_animation_scale transition_animation_scale animator_duration_scale; do S settings put global $k $V; done
echo "Animações: $V"
echo "Limpando cache (até 1 minuto)..."; S pm trim-caches 999999999999 >/dev/null
depois=$(S df /data | awk 'NR==2{print $4}')
echo "Espaço liberado: $(( (depois-antes)/1024 )) MB  |  Livre agora: $(S df -h /data | awk 'NR==2{print $4}')"
