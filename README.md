# caddy-docker
Caddy2 Docker image with several goodies built-in

## Included

- Fail2ban
- Caddy modules
    - [Cloudflare DNS module](https://github.com/caddy-dns/cloudflare)
    - [Transform Encoder module for Logger](https://github.com/caddyserver/transform-encoder)
    - [Coraza WAF Caddy Module](https://github.com/corazawaf/coraza-caddy)

# Setup

## Fail2ban setup

Make sure to use this log directive in your `Caddyfile`:

```
log {
    output file /var/log/caddy/access.log
    format transform "{common_log}"
}
```

This transforms the logs into a format that Fail2ban can understand, and places them in a log path that Fail2ban monitors. No further configuration is required on your part to use Fail2ban.

## Coraza setup

Make sure to use the following lines in your `Caddyfile`:

```
{
    order coraza_waf first
}

yoursite.com {
    coraza_waf {
        load_owasp_crs
        directives `
            Include @coraza.conf-recommended
            Include @crs-setup.conf.example
            Include @owasp_crs/*.conf
            SecRuleEngine On
        `
    }


    # And your site config goes here...
    reverse_proxy
}