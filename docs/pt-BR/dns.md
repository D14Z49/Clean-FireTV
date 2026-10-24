# Bloqueio por DNS (opcional, vale para a casa toda)

Alguns pacotes de telemetria e anúncios são **protegidos** pela Amazon e não podem ser desativados.
Para eles, o caminho é bloquear os endereços por DNS no **roteador**.

## AdGuard DNS (gratuito, sem conta)

| Campo | Valor |
|---|---|
| DNS primário (IPv4) | `94.140.14.14` |
| DNS secundário (IPv4) | `94.140.15.15` |
| DNS primário (IPv6) | `2a10:50c0::ad1:ff` |
| DNS secundário (IPv6) | `2a10:50c0::ad2:ff` |

- **Preencha também os campos IPv6.** Se ficarem com o DNS da operadora ou do Google, os aparelhos com IPv6 escapam do bloqueio.
- No roteador, o campo costuma ficar em "DHCP", "LAN" ou "Internet > DNS". Exemplo: em roteadores Intelbras Twibi, ele fica no app Wi-Fi Control Home > DNS > Manual.
- **Teste:** abra `https://adguard.com/test.html` em qualquer aparelho da rede.
- **Para desfazer:** volte o DNS para "Automático".
- **Não diminui a velocidade da internet.** O DNS só traduz nomes em endereços; o tráfego dos vídeos não passa por ele.
- **Limitação:** o banner gigante da tela inicial da Amazon pode continuar aparecendo, porque ele vem do próprio launcher. Para tirá-lo, use o Projectivy (veja o README).
