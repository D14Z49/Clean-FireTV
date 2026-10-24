#!/bin/bash
# Desliga a Depuração ADB ao terminar (fecha a porta 5555 na sua rede).
# Para religar: Configurações > Meu Fire TV > Opções do desenvolvedor > Depuração ADB.
source "$(dirname "$0")/comum.sh"
S settings put global adb_enabled 0; echo "Depuração ADB desligada."
