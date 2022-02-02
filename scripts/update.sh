#!/bin/bash

# This script is a utility script for simplified configuration rollout.
##: UTIL_SCRIPT

# Use the upstream binary to adapt the Caddyfile to JSON.
docker exec -it http sh -c "/usr/bin/caddy adapt -adapter caddyfile -config /conf.d/Caddyfile > /data/_.msf.json"
docker exec -it http sh -c "/bin/chmod 0444 /data/_.msf.json"

# Run the builder script to generate the JSON.
node ./scripts/js/generate.js

# Ensure curl is available.
docker exec -it -d http sh -c "/sbin/apk add curl"
sleep 3

# Update the http-server from '/data/_GENERATED_.json' Caddyfile.
echo "Sending the generated JSON to the http-server API..."
docker exec -it http /usr/bin/curl http://127.0.0.1:1024/load \
  -X POST \
  -H "Content-Type: application/json" \
  --data-binary @/data/_r.msf.json
echo "Sent! Please ensure the JSON was not rejected."
