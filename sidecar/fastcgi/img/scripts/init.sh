#!/bin/sh

echo 'Launching the "fastcgi" control plane.'
echo
echo '[0] control-plane::init'
echo

# Initialize the master plane.
echo '[1] control-plane::call:->fastcgi(backgrounded)'
sed -i 's/www\-data/root/g' '/usr/local/etc/php-fpm.d/www.conf'
( while true; do
    /usr/local/sbin/php-fpm -RF
    echo '[1] control-plane::call:->fastcgi:warning(process exited unexpectedly. attempting to restart.)'
done ) &
echo '[1] control-plane::call:->fastcgi(backgrounded::true)'

# Initialize the worker plane(s).
for TASK in /conf.d/fastcgi/*.sh; do
    echo '[X] control-plane::call:->fastcgi_task($TASK -> backgrounded)'
    ( while true; do
        /bin/sh '$TASK'
    done ) &
    echo '[X] control-plane::call:->fastcgi_task($TASK -> backgrounded::true)'
done

# Wrapper to keep the container alive for backgrounded tasks.
echo '[0] control-plane::init:->ready(true)'
( while true; do
    sleep 900
done )