# Solução de problemas

| Problema | Solução |
|---|---|
| **Não acho as Configurações do Fire TV** (com o Projectivy) | Segure o botão **Home** por 3 s > Configurações. |
| **Quero reiniciar** | Segure **Selecionar + Play/Pause** por 5 s. Ou `adb -s IP:5555 reboot`. |
| **O Home abre a tela da Amazon por alguns segundos** | Normal. O launcher da Amazon é protegido, e o Projectivy assume em seguida. |
| **Quero a tela da Amazon de volta** | No Projectivy: Configurações > Geral > desligar "Sobrepor o launcher atual". |
| **"Cannot disable a protected package"** | A Amazon protege esse pacote. Não há o que fazer sem root; use o bloqueio por DNS. |
| **O script parou no primeiro pacote** | Verifique se você está usando os scripts deste repositório. Comandos `adb shell` dentro de laços precisam de `</dev/null`. |
| **Algo parou de funcionar** | `bash scripts/03-reverter.sh NOME_DO_PACOTE` reativa um pacote; `bash scripts/03-reverter.sh` reativa tudo. |
| **Luna não funciona** | O Luna não está disponível em contas do Brasil e de vários países. Não é culpa da limpeza. |
| **A Alexa no Echo não controla mais a TV** | Você aplicou `listas/alexa.txt`. Reverta os pacotes dela. |
| **Echo deixou de ser caixa de som da TV** | `bash scripts/03-reverter.sh com.amazon.audiohome` |
| **"Sem conexão com IP:5555"** | Confira o IP, ligue a Depuração ADB e aceite o pedido na TV. O computador precisa estar na mesma rede. |
| **Uma atualização da Amazon desfez tudo** | Rode `scripts/02-desativar.sh` com as mesmas listas de novo. |
| **Print da tela sai preto** | Netflix e outros apps com DRM bloqueiam captura de tela. É normal. |
