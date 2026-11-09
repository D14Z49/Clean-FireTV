# Clean-FireTV

[English](README.md) · **Português (Brasil)**

**Seu Fire TV Stick (e TVs Google TV, como as TCL) sem anúncios, sem rastreamento e mais rápido.** Sem root, sem apagar nada, e com reversão em um comando.

- Desativa **rastreamento, publicidade e telemetria** da Amazon: o reconhecimento do que você assiste, o ID de publicidade, o serviço que envia as senhas do seu Wi-Fi, e mais.
- Troca, opcionalmente, a tela inicial cheia de banners por uma **tela limpa** ([Projectivy Launcher](https://github.com/spocky/miproja1)).
- Deixa o sistema **mais ágil**: animações mais rápidas e cache limpo.
- **Preserva** Alexa, busca por voz, Netflix, YouTube, Prime Video e as Configurações.

Tudo é feito por ADB pela rede Wi-Fi, com `pm disable-user`. **Nenhum app de sistema é desinstalado**, e qualquer mudança volta com `scripts/03-restore.sh`.

---

## Jeito mais fácil: com um assistente de IA

Se você usa **Claude Code**, Codex, Gemini CLI ou outro assistente com acesso ao terminal, basta pedir:

> Clone https://github.com/D14Z49/Clean-FireTV e siga o AGENTS.md para limpar meu Fire TV Stick.

O assistente lê o [`AGENTS.md`](AGENTS.md) e conduz tudo passo a passo, em português. **Antes de desativar qualquer coisa, ele pergunta o que você usa.**

## Jeito manual

### 1. Prepare o Fire Stick
1. **Configurações > Meu Fire TV > Sobre:** clique 7 vezes no nome do aparelho.
2. **Opções do desenvolvedor:** ligue **Depuração ADB** e **Apps de fontes desconhecidas**.
3. **Sobre > Rede:** anote o **IP**.

### 2. Instale o ADB no computador
| Sistema | Comando |
|---|---|
| macOS | `brew install --cask android-platform-tools` |
| Linux | `sudo apt install adb` |
| Windows | [Platform-Tools](https://developer.android.com/tools/releases/platform-tools) ou WSL |

### 3. Rode os scripts (computador na mesma rede Wi-Fi)
```bash
git clone https://github.com/D14Z49/Clean-FireTV && cd Clean-FireTV

bash scripts/01-diagnose.sh                         # só leitura; pede o IP e salva report.txt
bash scripts/02-disable.sh lists/ads-telemetry.txt  # recomendado
bash scripts/04-projectivy.sh                       # opcional: tela inicial limpa
bash scripts/05-optimize.sh                         # animações 0.5x + limpeza de cache
bash scripts/disable-adb.sh                         # ao terminar
```
Na primeira conexão, aceite **"Permitir depuração?"** na TV.

## Listas

| Arquivo | Para quem |
|---|---|
| [`lists/ads-telemetry.txt`](lists/ads-telemetry.txt) | **Todos.** Anúncios, rastreamento e telemetria. |
| [`lists/optional.txt`](lists/optional.txt) | Amazon Kids, Music, Fotos, Silk, Luna. Apague o `#` só do que quiser desativar. |
| [`lists/alexa.txt`](lists/alexa.txt) | **Só para quem NÃO usa Echo ou casa inteligente Amazon.** |
| [`lists/do-not-touch.txt`](lists/do-not-touch.txt) | Pacotes que **não devem** ser desativados, e os protegidos pela Amazon. |

## Tela inicial (Projectivy): o que esperar
O Fire OS **bloqueia** a troca de launcher. O Projectivy intercepta o botão Home, e por isso:
- ao apertar Home, a tela da Amazon aparece por **~5 segundos** antes de o Projectivy assumir;
- as **Configurações do Fire TV** ficam em: **segurar o botão Home por 3 s**;
- para voltar à tela da Amazon, desligue **"Sobrepor o launcher atual"** nas configurações do Projectivy.

## Google TV (TCL e outras)

O mesmo método funciona em TVs **Google TV** (testado numa TCL 43P755). Ative o modo desenvolvedor em **Configurações > Sistema > Sobre > aperte 7 vezes em "Build do Android TV OS"**, depois **Configurações > Sistema > Opções do desenvolvedor > Depuração USB** (na TCL isso também libera o ADB pela rede). O IP fica em **Configurações > Rede e Internet > sua rede**.

```bash
export TV_IP=192.168.0.60                                   # IP da sua TV
bash scripts/01-diagnose.sh
bash scripts/02-disable.sh lists/google-tv/tcl-ads-telemetry.txt   # recomendado na TCL
bash scripts/02-disable.sh lists/google-tv/optional.txt            # depois de apagar o # do que quiser
bash scripts/06-google-tv-launcher.sh                       # tela inicial limpa (Projectivy)
bash scripts/05-optimize.sh
```

**Diferente do Fire OS, o Google TV deixa trocar o launcher de verdade.** O `06-google-tv-launcher.sh` instala o Projectivy *primeiro*, e só então desativa o launcher do Google TV (`launcherx`) e o assistente de configuração, que senão captura o botão Home. Resultado: o Home abre o Projectivy na hora, sem tela de anúncios, e a tela pesada do Google TV deixa de rodar em segundo plano. As Configurações abrem pela engrenagem do Projectivy.

- Desfazer só o launcher: `bash scripts/06-google-tv-launcher.sh restore`
- Nunca desative o `launcherx` sozinho: sem outro launcher instalado a TV fica com tela preta.
- Não desative `com.tcl.suspension`: ele faz o botão de Entradas (Inputs) do controle funcionar.

### Bloqueio de anúncios por DNS privado
`bash scripts/08-private-dns.sh on` bloqueia anúncios e rastreadores no aparelho inteiro (AdGuard DNS); `off` volta ao normal. **Cuidado em redes que você não controla:** redes que bloqueiam DNS criptografado deixam o aparelho sem internet.

## Desfazer
```bash
bash scripts/03-restore.sh                       # reativa tudo que foi desativado
bash scripts/03-restore.sh com.amazon.exemplo    # reativa um pacote
```

## Testado em
| Aparelho | Sistema | Resultado |
|---|---|---|
| Fire TV Stick 3ª geração (AFTSSS) | 7.7.1.7 | Lista recomendada aplicada; Alexa, Netflix, YouTube e Prime Video funcionando após reiniciar |
| TCL 43P755 (Google TV) | Android 12 | Lista TCL + apps Google opcionais desativados; Projectivy como tela inicial de verdade; Configurações, YouTube e Home funcionando após reiniciar. |

Testou em outro modelo? Abra uma *issue* ou um *pull request* com o modelo, a versão do Fire OS e quais pacotes funcionaram ou deram erro.

## Projetos parecidos
- [android-tv-debloat-toolkit](https://github.com/seun-novodev/android-tv-debloat-toolkit): ferramenta com interface para Windows que limpa TVs TCL/Google TV, inspirada num script anterior para TCL de chrissy-dev.
- [cleanyourtv](https://github.com/Gathin23/cleanyourtv): listas por modelo, com script de reversão.
- Launchers de código aberto, para quem prefere ao Projectivy (que é grátis, mas de código fechado): [FLauncher, fork do osrosal](https://github.com/osrosal/flauncher), [LTvLauncher](https://github.com/LeanBitLab/FLauncherL) e [TV Launcher no F-Droid](https://f-droid.org/packages/com.tvlauncher/).

## Mais
- [Bloqueio por DNS na rede toda](docs/pt-BR/dns.md)
- [Solução de problemas](docs/pt-BR/solucao-de-problemas.md)

## Créditos
- Criado e mantido por **[D14Z49](https://github.com/D14Z49)**.
- Parte da lista de telemetria foi conferida com a lista do Fire TV Stick Lite 2020 do projeto [cleanyourtv](https://github.com/Gathin23/cleanyourtv) (MIT).
- [Projectivy Launcher](https://github.com/spocky/miproja1), de spocky. O app não é redistribuído aqui: o script baixa da página oficial do autor.

## Aviso
Use por sua conta e risco. Os scripts só desativam pacotes de forma reversível, mas atualizações da Amazon podem mudar o comportamento. Projeto independente, sem relação com a Amazon.

Licença [MIT](LICENSE) © 2026 D14Z49.
