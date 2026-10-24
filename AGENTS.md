# Instruções para assistentes de IA (Claude Code, Codex, Gemini CLI e similares)

O usuário quer limpar o Fire TV Stick dele com este repositório. Conduza o processo de ponta a ponta, **um passo de cada vez**, falando em **português do Brasil**, com linguagem simples.

## Regras

1. **Nunca desative nada sem mostrar a lista e receber "sim" do usuário.** Tudo é feito com `pm disable-user` (reversível). Nunca use `pm uninstall` em apps de sistema.
2. **Nunca toque em pacotes de `listas/nao-mexer.txt`.**
3. **Pergunte antes de aplicar `listas/alexa.txt`.** Se o usuário tem Echo ou casa inteligente Amazon, não aplique.
4. **Rode os scripts a partir da raiz do repositório e passe o IP em `FIRE_IP`**, para não travar em perguntas interativas. Exemplo: `FIRE_IP=192.168.0.50 bash scripts/01-diagnostico.sh`.
5. Se algum pacote der `Cannot disable a protected package`, é normal: a Amazon protege alguns. Siga em frente.
6. Depois de cada etapa, confirme o resultado. Use `scripts/tela.sh` e olhe o PNG gerado sempre que precisar ver a TV.
7. Se algo parar de funcionar, reative com `bash scripts/03-reverter.sh NOME_DO_PACOTE`, ou reative tudo com `bash scripts/03-reverter.sh`.

## Roteiro

### 0. Pré-requisitos
- **Computador:** confira se o `adb` existe (`command -v adb`). Se não existir, instale:
  - macOS: `brew install --cask android-platform-tools`
  - Linux: `sudo apt install adb`
  - Windows: Platform-Tools do Android, ou WSL
- **Fire Stick:** guie o usuário pela TV:
  1. Configurações > Meu Fire TV > Sobre: anotar **modelo e versão do Fire OS**.
  2. Clicar 7 vezes no nome do aparelho para liberar as **Opções do desenvolvedor**.
  3. Opções do desenvolvedor: ligar **Depuração ADB** e **Apps de fontes desconhecidas**.
  4. Sobre > Rede: anotar o **IP**.
- Se o sistema for **Vega OS** em vez de Fire OS, pare: este método não funciona.

### 1. Diagnóstico
1. Rode `FIRE_IP=<ip> bash scripts/01-diagnostico.sh`. O usuário precisa aceitar **"Permitir depuração?"** na TV, marcando "Sempre permitir".
2. Leia o `relatorio.txt` e cruze com as listas. Mostre ao usuário só os pacotes que **existem** no aparelho dele.
3. Aponte apps instalados pelo usuário que sejam suspeitos (IPTV de fora da loja, duplicados) e pergunte se ele usa.

### 2. Perguntas ao usuário, antes de desativar
- Usa **Alexa, Echo ou casa inteligente Amazon**? Se não, ofereça `listas/alexa.txt`.
- Usa **Amazon Kids, Amazon Music, Amazon Fotos, o navegador Silk ("Internet")**?
- Usa **Luna**? Avise que não funciona em contas do Brasil.
- Quer **trocar a tela inicial** pelo Projectivy? Explique o trade-off do passo 4.

### 3. Desativar
- Recomendado: `FIRE_IP=<ip> bash scripts/02-desativar.sh listas/anuncios-telemetria.txt`
- Opcionais: copie as linhas escolhidas de `listas/opcional.txt` para um arquivo `listas/minhas.txt` (sem o `#`) e rode o mesmo script com ele.
- Depois peça para o usuário **reiniciar** (segurar Selecionar + Play/Pause por 5 s) e testar Netflix, YouTube, Prime Video, busca por voz e Configurações.

### 4. Tela inicial sem anúncios (opcional)
- Rode `FIRE_IP=<ip> bash scripts/04-projectivy.sh` e guie o usuário na TV:
  1. Abrir o Projectivy e concluir o assistente.
  2. Configurações > Geral > ligar **"Sobrepor o launcher atual"**.
  3. Opcional: desligar os dois "relatórios anônimos".
- **Avise o usuário de três coisas:**
  - O botão Home mostra a tela da Amazon por ~5 s antes do Projectivy assumir. É limitação do Fire OS (o launcher da Amazon é protegido); não há como eliminar.
  - Para chegar nas **Configurações do Fire TV**, segure o botão Home por 3 s.
  - Para voltar à tela da Amazon, basta desligar "Sobrepor o launcher atual".

### 5. Otimizar
- `FIRE_IP=<ip> bash scripts/05-otimizar.sh` coloca as animações em 0.5x e limpa o cache.
- Pelo menu (não dá por ADB): Configurações > Preferências > Configurações de privacidade, desligar as três opções. Em Preferências > Conteúdo em destaque, desligar a reprodução automática de vídeo e áudio.
- Sugira o bloqueio por DNS no roteador. Veja `docs/dns.md`.

### 6. Encerrar
- Rode `bash scripts/desligar-adb.sh`, para fechar a porta 5555 na rede.
- Resuma o que foi desativado (`desativados.log`) e como reverter.
- Lembre o usuário: atualizações da Amazon podem reativar pacotes. Basta rodar o passo 3 de novo.

## Problemas comuns
Veja `docs/solucao-de-problemas.md`.
