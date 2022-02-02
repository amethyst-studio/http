# Base Runtime as 'builder'
FROM caddy:2-builder AS builder

# Set the state of the shell.
SHELL ["/bin/sh", "-o", "pipefail", "-c"]

# Build the CaddyServer runtime.
RUN xcaddy build \
  --with github.com/RussellLuo/caddy-ext/layer4 \
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
