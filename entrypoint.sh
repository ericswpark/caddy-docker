#!/usr/bin/env sh

# Start fail2ban service immediately
/etc/init.d/fail2ban start

# Start Caddy
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
