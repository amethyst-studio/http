# Base Runtime as 'builder'
FROM caddy:2-builder AS builder

# Build the 'http' runtime.
RUN xcaddy build \
  --with 'github.com/gamalan/caddy-tlsredis' \
  --with 'github.com/caddyserver/format-encoder' \
  --with 'github.com/kirsch33/realip'

# Layer the runtime into the original image.
FROM caddy:2
COPY --from=builder '/usr/bin/caddy' '/usr/bin/http'

# Install the container launch script.
COPY './scripts/init.sh' '/init.sh'

# Set the entrypoint to the launch script above for container boot.
ENTRYPOINT ["/bin/sh", "/init.sh"]
