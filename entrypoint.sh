#!/usr/bin/env sh

# Enable Fail2ban service
rc-update add fail2ban

# Start fail2ban service immediately
/etc/init.d/fail2ban start


# Start Caddy
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
