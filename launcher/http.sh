#!/bin/sh

# This launcher is registered to the 'http' container.
##: ENTRYPOINT_LAUNCHER

# Entrypoint: Start caddy in forground shell.
echo "Started::service->caddy"
while true; do
  /usr/bin/caddy run --config /conf.d/Caddyfile
  echo "Warning::service->caddy :: The Caddy server exited unexpectedly, restarting..."
done
