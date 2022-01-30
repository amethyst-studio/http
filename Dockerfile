# Base Runtime as 'builder'
FROM caddy:2-builder AS builder

# Build the CaddyServer runtime.
RUN xcaddy build \
  --with github.com/gamalan/caddy-tlsredis \
  --with github.com/caddyserver/format-encoder \
  --with github.com/kirsch33/realip

# Layer the runtime into the original image.
FROM caddy:2
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Install the container launch script.
COPY ./launcher/http.sh /launch.sh

# Set the entrypoint to the launch script above for container boot.
ENTRYPOINT ["/bin/sh", "/launch.sh"]
