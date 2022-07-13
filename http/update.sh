#!/bin/bash

# This script is a utility script for simplified configuration rollout.
##: UTIL_SCRIPT

# Ensure curl is available.
docker exec -it -d http-http-1 sh -c '/sbin/apk add curl'
sleep 3

# Update the http-server from '/data/_GENERATED_.json' Caddyfile.
echo 'Sending the Caddyfile to the http API...'
docker exec -it http-http-1 /usr/bin/curl http://127.0.0.1:1024/load \
  -X POST \
  -H 'Content-Type: text/caddyfile' \
  --data-binary @/conf.d/Caddyfile \
  && echo '=== http_http_1 rtvr: ack_server_load ==='
echo 'Sent! Please ensure the Caddyfile was not rejected by the above response.'
