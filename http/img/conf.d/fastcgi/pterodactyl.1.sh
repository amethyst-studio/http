/usr/local/bin/php '/data/www/panel.amethyst.live/artisan' queue:work --queue=high,standard,low --sleep=3 --tries=3 >> '/dev/null' 2>&1
echo "[X] control-plane::call:->fastcgi_task(pterodactyl.1):warning(process exited unexpectedly. attempting to restart.)"
sleep 1