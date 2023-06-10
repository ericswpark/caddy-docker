#################
# Builder image #
#################
FROM caddy:builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/transform-encoder \
    --with github.com/corazawaf/coraza-caddy

##############
# Main image #
##############
FROM caddy:alpine

# Copy executable from builder
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Install Fail2ban
RUN apk add fail2ban openrc
RUN rc-update add fail2ban

# Copy fail2ban configuration files
COPY fail2ban/caddy-4xx.conf /etc/fail2ban/filter.d/caddy-4xx.conf
COPY fail2ban/jail.local /etc/fail2ban/jail.local

# Copy and run entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
