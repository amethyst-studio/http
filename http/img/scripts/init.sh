#!/bin/sh

echo 'Launching the "http" control plane.'
echo
echo '[0] control-plane::init'
echo

# Initialize the master plane.
echo '[1] control-plane::call:->http(backgrounded)'
( while true; do
    /usr/bin/http run --config '/conf.d/Caddyfile'
    echo '[1] control-plane::call:->http:warning(process exited unexpectedly. attempting to restart.)'
done ) &
echo '[1] control-plane::call:->http(backgrounded::true)'

# Wrapper to keep the container alive for backgrounded tasks.
echo '[0] control-plane::init:->ready(true)'
( while true; do
    sleep 900
done )