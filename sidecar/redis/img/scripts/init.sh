#!/bin/sh

echo 'Launching the "redis-server" control plane.'
echo
echo '[0] control-plane::init'
echo

# Initialize the master plane.
echo '[1] control-plane::call:->redis-server(backgrounded)'
( while true; do
    chown redis:redis '/usr/local/etc/redis/redis.conf'
    redis-server '/usr/local/etc/redis/redis.conf'
    echo '[1] control-plane::call:->redis-server:warning(process exited unexpectedly. attempting to restart.)'
done ) &
echo '[1] control-plane::call:->redis-server(backgrounded::true)'

# Wrapper to keep the container alive for backgrounded tasks.
echo '[0] control-plane::init:->ready(true)'
( while true; do
    sleep 900
done )