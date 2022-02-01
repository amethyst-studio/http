#!/bin/sh

# This launcher is registered to the 'php-fpm' container.
##: ENTRYPOINT_LAUNCHER

# Initialize the PHP Services in background shell.
## Pterodactyl Panel from panel.amethyst.live. [1, 2]
( while true; do # [1]
    /usr/local/bin/php /var/www/html/panel.amethyst.live/pt-panel/artisan queue:work --queue=high,standard,low --sleep=3 --tries=3 >> /dev/null 2>&1
    echo "Warning::process->pterodactyl/artisan->queue:work => The queue worker exited unexpectedly, restarting..."
    sleep 1
done   ) &
echo "Started::process->pterodactyl/artisan->queue:work"
( while true; do # [2]
    /usr/local/bin/php /var/www/html/panel.amethyst.live/pt-panel/artisan schedule:run >> /dev/null 2>&1
    sleep 60
done   ) &
echo "Started::process->pterodactyl/artisan->schedule:run"

# Entrypoint: Start php-fpm in foreground shell with root enabled.
sed -i 's/www\-data/root/g' /usr/local/etc/php-fpm.d/www.conf
echo "Started::service->php-fpm"
while true; do
  /usr/local/sbin/php-fpm -RF >> /dev/null 2>&1
  echo "Warning::service->php-fpm :: The PHP FastCGI worker exited unexpectedly, restarting..."
done
