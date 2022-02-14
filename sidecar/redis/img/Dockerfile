FROM redis:7.0-rc

# Build the 'redis-server' runtime.
COPY './conf.d/redis.conf' '/usr/local/etc/redis/redis.conf'

# Install the container launch script.
COPY './scripts/init.sh' '/init.sh'

# Set the entrypoint to the launch script above for container boot.
ENTRYPOINT ["/bin/sh", "/init.sh"]