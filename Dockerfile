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
