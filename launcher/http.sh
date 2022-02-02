#!/bin/sh

# This launcher is registered to the 'http' container.
##: ENTRYPOINT_LAUNCHER

# Entrypoint: Start http in forground shell.
echo "Started::service->http"
while true; do
  /usr/bin/caddy run --config /data/_r.msf.json
  echo "Warning::service->http :: The http(s) server exited unexpectedly, restarting..."
done
