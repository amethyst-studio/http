#!/bin/bash

# Update the http-server from '/data/_.json' Caddyfile.
docker exec -it -d http /sbin/apk add curl && sleep 1
docker exec -it http /usr/bin/curl http://127.0.0.1:1024/load \
  -X POST \
  -H "Content-Type: text/caddyfile" \
  --data-binary @/conf.d/Caddyfile
