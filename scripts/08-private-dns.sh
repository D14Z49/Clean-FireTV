#!/bin/bash
# Network-wide ad/tracker blocking on the device itself via Android Private DNS (Android 9+).
# Usage: bash scripts/08-private-dns.sh on [hostname]   (default: dns.adguard-dns.com)
#        bash scripts/08-private-dns.sh off             (automatic mode, the Android default)
# WARNING: some corporate/guest networks block DNS-over-TLS (port 853); with "on" the device then has NO internet.
source "$(dirname "$0")/common.sh"
case "$1" in
  on)  S settings put global private_dns_mode hostname; S settings put global private_dns_specifier "${2:-dns.adguard-dns.com}" ;;
  off) S settings put global private_dns_mode opportunistic; S settings delete global private_dns_specifier >/dev/null ;;
  *) echo "Usage: bash $0 on [hostname] | off"; exit 1 ;;
esac
echo "Private DNS: $(S settings get global private_dns_mode) $(S settings get global private_dns_specifier)"
