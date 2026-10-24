# DNS blocking (optional, protects the whole home)

Some telemetry and ad packages are **protected** by Amazon and cannot be disabled.
For those, the way out is to block their addresses with DNS on your **router**.

## AdGuard DNS (free, no account)

| Field | Value |
|---|---|
| Primary DNS (IPv4) | `94.140.14.14` |
| Secondary DNS (IPv4) | `94.140.15.15` |
| Primary DNS (IPv6) | `2a10:50c0::ad1:ff` |
| Secondary DNS (IPv6) | `2a10:50c0::ad2:ff` |

- **Fill in the IPv6 fields too.** If they keep your ISP's or Google's DNS, devices using IPv6 bypass the blocking.
- On the router, the setting is usually under "DHCP", "LAN" or "Internet > DNS".
- **Test it:** open `https://adguard.com/test.html` on any device on the network.
- **To undo:** set DNS back to "Automatic".
- **It does not slow your internet down.** DNS only translates names into addresses; video traffic does not go through it.
- **Limitation:** the large banner on Amazon's home screen may still show up, because it comes from the launcher itself. To get rid of it, use Projectivy (see the README).
