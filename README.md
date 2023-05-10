# caddy-docker
Caddy2 Docker image with several goodies built-in

## Included

- Fail2ban
- Caddy modules
    - [Cloudflare DNS module](https://github.com/caddy-dns/cloudflare)
    - [Transform Encoder module for Logger](https://github.com/caddyserver/transform-encoder)

# Setup

Make sure to use this log directive in your `Caddyfile`:

```
log {
    output file /var/log/caddy/access.log
    format transform "{common_log}"
}
```

This transforms the logs into a format that Fail2ban can understand, and places them in a log path that Fail2ban monitors. No further configuration is required on your part to use Fail2ban.