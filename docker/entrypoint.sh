#!/bin/sh
set -e

# Lancer PHP-FPM en arrière-plan
php-fpm &

# Lancer NGINX au premier plan pour garder le conteneur actif
exec nginx -g 'daemon off;'
