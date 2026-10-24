# Clean-FireTV

[English](README.md) · **Português (Brasil)**

**Seu Fire TV Stick sem anúncios, sem rastreamento e mais rápido.** Sem root, sem apagar nada, e com reversão em um comando.

- Desativa **rastreamento, publicidade e telemetria** da Amazon: o reconhecimento do que você assiste, o ID de publicidade, o serviço que envia as senhas do seu Wi-Fi, e mais.
- Troca, opcionalmente, a tela inicial cheia de banners por uma **tela limpa** ([Projectivy Launcher](https://github.com/spocky/miproja1)).
- Deixa o sistema **mais ágil**: animações mais rápidas e cache limpo.
- **Preserva** Alexa, busca por voz, Netflix, YouTube, Prime Video e as Configurações.

Tudo é feito por ADB pela rede Wi-Fi, com `pm disable-user`. **Nenhum app de sistema é desinstalado**, e qualquer mudança volta com `scripts/03-restore.sh`.

---

## Jeito mais fácil: com um assistente de IA

Se você usa **Claude Code**, Codex, Gemini CLI ou outro assistente com acesso ao terminal, basta pedir:

> Clone https://github.com/proteus49/Clean-FireTV e siga o AGENTS.md para limpar meu Fire TV Stick.

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
git clone https://github.com/proteus49/Clean-FireTV && cd Clean-FireTV

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

## Desfazer
```bash
bash scripts/03-restore.sh                       # reativa tudo que foi desativado
bash scripts/03-restore.sh com.amazon.exemplo    # reativa um pacote
```

## Testado em
| Aparelho | Fire OS | Resultado |
|---|---|---|
| Fire TV Stick 3ª geração (AFTSSS) | 7.7.1.7 | Lista recomendada aplicada; Alexa, Netflix, YouTube e Prime Video funcionando após reiniciar |

Testou em outro modelo? Abra uma *issue* ou um *pull request* com o modelo, a versão do Fire OS e quais pacotes funcionaram ou deram erro.

## Mais
- [Bloqueio por DNS na rede toda](docs/pt-BR/dns.md)
- [Solução de problemas](docs/pt-BR/solucao-de-problemas.md)

## Créditos
- Criado e mantido por **[Proteus49](https://github.com/proteus49)**.
- Parte da lista de telemetria foi conferida com a lista do Fire TV Stick Lite 2020 do projeto [cleanyourtv](https://github.com/Gathin23/cleanyourtv) (MIT).
- [Projectivy Launcher](https://github.com/spocky/miproja1), de spocky. O app não é redistribuído aqui: o script baixa da página oficial do autor.

## Aviso
Use por sua conta e risco. Os scripts só desativam pacotes de forma reversível, mas atualizações da Amazon podem mudar o comportamento. Projeto independente, sem relação com a Amazon.

Licença [MIT](LICENSE) © 2026 Proteus49.
