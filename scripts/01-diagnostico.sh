#!/bin/bash
# Diagnóstico SOMENTE LEITURA. Salva relatorio.txt na pasta do projeto.
source "$(dirname "$0")/comum.sh"
OUT="$RAIZ/relatorio.txt"
{
  echo "=== APARELHO ==="; S getprop ro.product.model; S getprop ro.build.version.name
  echo; echo "=== LAUNCHER ATUAL ==="; S cmd package resolve-activity -a android.intent.action.MAIN -c android.intent.category.HOME | grep packageName | head -1
  echo; echo "=== APPS DE SISTEMA ==="; S pm list packages -s | sort
  echo; echo "=== APPS INSTALADOS PELO USUÁRIO ==="; S pm list packages -3 | sort
  echo; echo "=== JÁ DESATIVADOS ==="; S pm list packages -d | sort
  echo; echo "=== ESPAÇO E MEMÓRIA ==="; S df -h /data; S cat /proc/meminfo | head -3
} > "$OUT"
echo "Relatório salvo em $OUT"
